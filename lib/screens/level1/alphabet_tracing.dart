// lib/screens/level1/alphabet_tracing.dart
//
// AlphabetTracingScreen — the user draws over each of the 7 letters in the set.
//
// Validation uses a pixel-mask approach:
//   1. After the canvas lays out, the letter is rendered off-screen to a
//      ui.Image at the same pixel dimensions as the canvas.
//   2. The RGBA byte data is stored in _letterMaskBytes.
//   3. Every point in the user's stroke is tested against the mask —
//      a point is "on the letter" if a small neighborhood around it has
//      alpha byte > 30 anywhere (forgiving/stable near glyph edges).
//      The result is cached on the point the instant it's drawn.
//   4. Coverage = (on-letter points) / (total points).
//      A stroke must be ≥ _minStrokeLen px to count.
//      Coverage must reach _minCoverage (60%) to pass.
//
// Architecture (this revision):
//   - The drawing surface now lives in its own StatefulWidget, `_TracingCanvas`,
//     with its OWN local state. Every drag point only triggers a setState on
//     that small subtree — the app bar, nature background, letter label, and
//     buttons no longer rebuild on every touch-move event. This is the fix
//     for "canvas is not stable / can't trace": previously a single top-level
//     setState per drag point rebuilt the entire screen dozens of times a
//     second, which is enough overhead on a real device to drop touch input.
//   - The parent screen talks to the canvas through a small controller
//     (`TracingCanvasController`) that exposes `clear()` and `validate()`,
//     plus a `ValueNotifier<bool>` for "has the user drawn anything yet" so
//     the Check/Next button can enable/disable itself without the parent
//     rebuilding on every stroke.
//   - The canvas widget is keyed by the current letter index, so Flutter
//     disposes and recreates its state automatically on letter change —
//     no manual reset of strokes/mask fields needed.
//   - The landscape controls column no longer uses `Spacer()` (which needs a
//     bounded height and overflows when the validation banner wraps to two
//     lines). It's wrapped in a scrollable, min-height column instead, so it
//     can never overflow — it just scrolls if content is taller than the
//     available space.
//   - Mask rebuilds are debounced by ~60ms so screen rotation (which fires a
//     stream of intermediate sizes while animating) doesn't repeatedly
//     regenerate the mask mid-gesture.
//
// Layout:
//   Portrait  — scrollable column; canvas fixed at 280 px
//   Landscape — canvas fills the left 5/8; controls column on the right
//
// Shared at the bottom: _NatureBackground / _NaturePainter (same as audio screen).

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/alphabet_data.dart';
import '../../providers/progress_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STROKE POINT — caches its own on-letter result at the moment it's drawn.
// ─────────────────────────────────────────────────────────────────────────────

class _StrokePoint {
  final Offset offset;
  final bool onLetter;
  const _StrokePoint(this.offset, this.onLetter);
}

class TracingValidationResult {
  final bool pass;
  final double coverage;
  const TracingValidationResult(this.pass, this.coverage);
}

// ─────────────────────────────────────────────────────────────────────────────
// CONTROLLER — the parent screen's handle onto the canvas's internal state,
// without needing to own (or rebuild on) that state itself.
// ─────────────────────────────────────────────────────────────────────────────

class TracingCanvasController {
  _TracingCanvasState? _state;
  final ValueNotifier<bool> hasStrokesNotifier = ValueNotifier(false);

  void _attach(_TracingCanvasState state) {
    _state = state;
    hasStrokesNotifier.value = state._strokes.isNotEmpty;
  }

  void _detach(_TracingCanvasState state) {
    if (_state == state) _state = null;
  }

  void clear() => _state?._clear();

  TracingValidationResult validate() =>
      _state?._validate() ?? const TracingValidationResult(false, 0);

  void dispose() => hasStrokesNotifier.dispose();
}

// ─────────────────────────────────────────────────────────────────────────────
// TRACING CANVAS — owns strokes, mask, and per-point hit testing locally.
// Drag events only ever setState() this widget, never the parent screen.
// ─────────────────────────────────────────────────────────────────────────────

class _TracingCanvas extends StatefulWidget {
  final String character;
  final double fontSize;
  final double? fixedHeight;
  final TracingCanvasController controller;

  const _TracingCanvas({
    super.key,
    required this.character,
    required this.controller,
    this.fontSize = 160,
    this.fixedHeight,
  });

  @override
  State<_TracingCanvas> createState() => _TracingCanvasState();
}

class _TracingCanvasState extends State<_TracingCanvas> {
  final List<List<_StrokePoint>> _strokes = [];
  List<_StrokePoint> _currentStroke = [];
  int _paintRevision = 0;

  bool _validated = false;
  bool _validationPass = false;

  ui.Image? _letterMaskImage;
  ByteData? _letterMaskBytes;
  Size _canvasSize = Size.zero;
  bool _isBuildingMask = false;
  int _maskRequestId = 0;

  static const double _minCoverage = 0.60;
  static const double _minStrokeLen = 30;
  static const int _alphaThreshold = 15;
  static const int _hitTestRadius = 4;

  @override
  void initState() {
    super.initState();
    widget.controller._attach(this);
  }

  @override
  void dispose() {
    widget.controller._detach(this);
    super.dispose();
  }

  // ── Debounced mask scheduling ──────────────────────────────────────────
  // Rotation (and some resizes) fire a burst of intermediate sizes while
  // animating. Waiting ~60ms for the size to settle before rebuilding stops
  // the mask from regenerating — and the guide letter from flickering —
  // mid-gesture.
  void _scheduleMaskBuild(Size size) {
    final requestId = ++_maskRequestId;
    Future.delayed(const Duration(milliseconds: 60), () {
      if (!mounted || requestId != _maskRequestId) return;
      _buildLetterMask(size);
    });
  }

  Future<void> _buildLetterMask(Size canvasSize) async {
    final rounded = Size(
      canvasSize.width.roundToDouble(),
      canvasSize.height.roundToDouble(),
    );

    if (_isBuildingMask) return;
    if (_letterMaskImage != null && _canvasSize == rounded) return;
    if (rounded.width < 1 || rounded.height < 1) return;

    _isBuildingMask = true;
    _canvasSize = rounded;

    try {
      // Paint BOTH a stroked outline pass and a solid fill pass, matching
      // what's actually shown to the user as the guide letter (a faint fill
      // plus a ~2px outline). If the mask were fill-only, the visible
      // outline would extend slightly past the hit-test region, causing
      // strokes drawn right along the visible edge to read as "off letter"
      // (red) even though they look like they're on the letter.
      final fillPainter = TextPainter(
        text: TextSpan(
          text: widget.character,
          style: TextStyle(
            fontFamily: 'AbyssinicaSIL',
            fontSize: widget.fontSize,
            color: Colors.black,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();

      final strokePainter = TextPainter(
        text: TextSpan(
          text: widget.character,
          style: TextStyle(
            fontFamily: 'AbyssinicaSIL',
            fontSize: widget.fontSize,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2.0
              ..color = Colors.black,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      )..layout();

      final originX = rounded.width / 2 - fillPainter.width / 2;
      final originY = rounded.height / 2 - fillPainter.height / 2;

      final recorder = ui.PictureRecorder();
      final offCanvas = Canvas(recorder);
      strokePainter.paint(offCanvas, Offset(originX, originY));
      fillPainter.paint(offCanvas, Offset(originX, originY));

      final picture = recorder.endRecording();
      final image = await picture.toImage(
        rounded.width.ceil().clamp(1, 4096),
        rounded.height.ceil().clamp(1, 4096),
      );
      final bytes = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

      if (mounted) {
        setState(() {
          _letterMaskImage = image;
          _letterMaskBytes = bytes;
        });
      }
    } finally {
      _isBuildingMask = false;
    }
  }

  bool _isOnLetter(Offset pt) {
    if (_letterMaskBytes == null || _letterMaskImage == null) return true;
    final w = _letterMaskImage!.width;
    final h = _letterMaskImage!.height;
    final cx = pt.dx.round();
    final cy = pt.dy.round();

    for (int dy = -_hitTestRadius; dy <= _hitTestRadius; dy++) {
      final y = (cy + dy).clamp(0, h - 1);
      for (int dx = -_hitTestRadius; dx <= _hitTestRadius; dx++) {
        final x = (cx + dx).clamp(0, w - 1);
        final byteOffset = (y * w + x) * 4;
        if (_letterMaskBytes!.getUint8(byteOffset + 3) > _alphaThreshold) {
          return true;
        }
      }
    }
    return false;
  }

  void _onPanStart(DragStartDetails d) {
    setState(() {
      _currentStroke = [_StrokePoint(d.localPosition, _isOnLetter(d.localPosition))];
      _validated = false;
      _paintRevision++;
    });
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() {
      _currentStroke.add(_StrokePoint(d.localPosition, _isOnLetter(d.localPosition)));
      _paintRevision++;
    });
  }

  void _onPanEnd(DragEndDetails _) {
    if (_currentStroke.length < 3) {
      setState(() {
        _currentStroke = [];
        _paintRevision++;
      });
      return;
    }
    final wasEmpty = _strokes.isEmpty;
    setState(() {
      _strokes.add(List.from(_currentStroke));
      _currentStroke = [];
      _paintRevision++;
    });
    if (wasEmpty) widget.controller.hasStrokesNotifier.value = true;
  }

  double _strokeLength(List<_StrokePoint> stroke) {
    double len = 0;
    for (int i = 1; i < stroke.length; i++) {
      len += (stroke[i].offset - stroke[i - 1].offset).distance;
    }
    return len;
  }

  double _computeCoverage() {
    if (_letterMaskBytes == null) return 1.0;
    int total = 0, onLetter = 0;
    for (final stroke in _strokes) {
      if (_strokeLength(stroke) < _minStrokeLen) continue;
      for (final pt in stroke) {
        total++;
        if (pt.onLetter) onLetter++;
      }
    }
    if (total == 0) return 0;
    return onLetter / total;
  }

  TracingValidationResult _validate() {
    final coverage = _computeCoverage();
    final pass = coverage >= _minCoverage;
    setState(() {
      _validated = true;
      _validationPass = pass;
    });
    return TracingValidationResult(pass, coverage);
  }

  void _clear() {
    setState(() {
      _strokes.clear();
      _currentStroke = [];
      _validated = false;
      _validationPass = false;
      _paintRevision++;
    });
    widget.controller.hasStrokesNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final canvasBody = Container(
      height: widget.fixedHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _validated
              ? (_validationPass ? Colors.green : Colors.red)
              : const Color(0xFF7C4DFF).withValues(alpha: 0.3),
          width: _validated ? 2.5 : 2,
        ),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: LayoutBuilder(builder: (ctx, constraints) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          final rounded =
              Size(size.width.roundToDouble(), size.height.roundToDouble());
          if ((rounded != _canvasSize || _letterMaskImage == null) &&
              !_isBuildingMask) {
            _scheduleMaskBuild(size);
          }
          return Stack(children: [
            Center(
              child: Text(
                widget.character,
                style: TextStyle(
                  fontFamily: 'AbyssinicaSIL',
                  fontSize: widget.fontSize,
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.14),
                  height: 1.2,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.character,
                style: TextStyle(
                  fontFamily: 'AbyssinicaSIL',
                  fontSize: widget.fontSize,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2.0
                    ..color = const Color(0xFF7C4DFF).withValues(alpha: 0.30),
                  height: 1.2,
                ),
              ),
            ),
            // Drawing surface — HitTestBehavior.opaque so touches are
            // captured reliably across the whole transparent surface.
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: _TracePainter(
                    strokes: [
                      ..._strokes,
                      if (_currentStroke.isNotEmpty) _currentStroke,
                    ],
                    revision: _paintRevision,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ]);
        }),
      ),
    );

    return Stack(children: [
      widget.fixedHeight != null
          ? canvasBody
          : Positioned.fill(child: canvasBody),
      Positioned(
        top: 8,
        right: 8,
        child: IconButton(
          icon: const Icon(Icons.refresh, color: Colors.grey),
          onPressed: _clear,
          tooltip: 'Clear',
        ),
      ),
    ]);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TRACE PAINTER
// ─────────────────────────────────────────────────────────────────────────────

class _TracePainter extends CustomPainter {
  final List<List<_StrokePoint>> strokes;
  final int revision;

  const _TracePainter({required this.strokes, required this.revision});

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      if (stroke.length < 2) continue;
      for (int i = 1; i < stroke.length; i++) {
        final onLetter = stroke[i].onLetter;
        final paint = Paint()
          ..color = onLetter
              ? const Color(0xFF5C6BC0)
              : Colors.red.withValues(alpha: 0.75)
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke;
        canvas.drawLine(stroke[i - 1].offset, stroke[i].offset, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_TracePainter old) => old.revision != revision;
}

// ─────────────────────────────────────────────────────────────────────────────
// TRACING SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AlphabetTracingScreen extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;

  const AlphabetTracingScreen(
      {super.key, required this.setIndex, required this.set});

  @override
  State<AlphabetTracingScreen> createState() => _AlphabetTracingScreenState();
}

class _AlphabetTracingScreenState extends State<AlphabetTracingScreen> {
  int _currentLetterIndex = 0;
  bool _validated = false;
  bool _validationPass = false;
  double _coverageScore = 0;

  final TracingCanvasController _controller = TracingCanvasController();

  AlphabetLetter get _current => widget.set.letters[_currentLetterIndex];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _nextLetter() async {
    if (!_validated) {
      final result = _controller.validate();
      setState(() {
        _validated = true;
        _validationPass = result.pass;
        _coverageScore = result.coverage;
      });
      return;
    }
    if (!_validationPass) {
      final result = _controller.validate();
      setState(() {
        _validationPass = result.pass;
        _coverageScore = result.coverage;
      });
      return;
    }

    if (_currentLetterIndex < 6) {
      setState(() {
        _currentLetterIndex++;
        _validated = false;
        _validationPass = false;
        _coverageScore = 0;
      });
    } else {
      await context
          .read<ProgressProvider>()
          .markAlphabetActivity(widget.setIndex, 'tracing');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✏️ ምውቃጥ ወዲእኩም! - Tracing completed! +10 XP'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  void _clear() {
    _controller.clear();
    setState(() {
      _validated = false;
      _validationPass = false;
      _coverageScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final progressDots = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          7,
          (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _currentLetterIndex ? 28 : 10,
                height: 10,
                decoration: BoxDecoration(
                  color: i < _currentLetterIndex
                      ? Colors.green
                      : (i == _currentLetterIndex
                          ? const Color(0xFF7C4DFF)
                          : Colors.white.withValues(alpha: 0.7)),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 3,
                    ),
                  ],
                ),
              )),
    );

    final letterLabel = Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: 14, vertical: isLandscape ? 8 : 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF7C4DFF).withValues(alpha: 0.25),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: isLandscape ? 32 : 40,
            height: isLandscape ? 32 : 40,
            decoration: BoxDecoration(
              color: const Color(0xFF7C4DFF).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.edit_rounded,
                color: const Color(0xFF7C4DFF), size: isLandscape ? 16 : 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ፊደል : ${_current.character} (${_current.romanization}) ወቅጥ',
                  style: TextStyle(
                    fontFamily: 'AbyssinicaSIL',
                    color: const Color(0xFF4A3080),
                    fontSize: isLandscape ? 13 : 15,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                if (!isLandscape) ...[
                  const SizedBox(height: 2),
                  const Text(
                    'Trace only on the letter',
                    style: TextStyle(
                      color: Color(0xFF7C4DFF),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    final validationFeedback = _validated
        ? AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: 16, vertical: isLandscape ? 6 : 10),
            decoration: BoxDecoration(
              color: _validationPass
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _validationPass
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFF44336),
              ),
            ),
            child: Row(children: [
              Text(_validationPass ? '✅' : '⚠️',
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _validationPass
                      ? 'ጽቡቕ ወቅጥ! ${(_coverageScore * 100).toInt()}% on the letter.'
                      : 'ኣብ ናይቲ ፊደል ክፋል ጥራሕ ወቅጥ። '
                          '${(_coverageScore * 100).toInt()}% on letter '
                          '(need 60%).',
                  style: TextStyle(
                    color: _validationPass
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFC62828),
                    fontSize: 13,
                  ),
                ),
              ),
            ]),
          )
        : const SizedBox.shrink();

    // Button enablement now listens to the controller's notifier instead of
    // reading strokes directly — this avoids a parent-level rebuild on every
    // drag point, since the notifier only flips twice per stroke lifecycle
    // (first stroke committed / cleared), not on every touch-move.
    final actionButtons = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton.icon(
          onPressed: _clear,
          icon: const Icon(Icons.delete_outline),
          label: const Text('ደምስስ - Clear'),
        ),
        const SizedBox(height: 10),
        ValueListenableBuilder<bool>(
          valueListenable: _controller.hasStrokesNotifier,
          builder: (ctx, hasStrokes, _) {
            return ElevatedButton.icon(
              onPressed: hasStrokes ? _nextLetter : null,
              icon: Icon(_validationPass ? Icons.arrow_forward : Icons.check),
              label: Text(
                _validated && !_validationPass
                    ? 'ደጊምካ ፈትን - Try Again'
                    : _validationPass
                        ? (_currentLetterIndex < 6
                            ? 'ዝስዕብ ፊደል - Next Letter'
                            : 'ተፈጸመ - Complete!')
                        : 'መርምር - Check',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _validationPass ? Colors.green : const Color(0xFF7C4DFF),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: isLandscape ? 10 : 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            );
          },
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
            'ወቅጥ - ፊደላት ጉጅለ  ${widget.setIndex + 1} (${_currentLetterIndex + 1}/7)'),
        backgroundColor: const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _NatureBackground()),

          isLandscape
              ? SafeArea(
                  top: false,
                  child: Builder(builder: (ctx) {
                    final topPad = MediaQuery.of(ctx).padding.top +
                        kToolbarHeight +
                        8.0;
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(12, topPad, 12, 12),
                            child: _TracingCanvas(
                              key: ValueKey(_currentLetterIndex),
                              character: _current.character,
                              controller: _controller,
                            ),
                          ),
                        ),
                        // ── Controls panel ──────────────────────────────
                        // Fixed: no more Spacer() and no forced minHeight.
                        // The button block now sits directly after the
                        // content instead of being pushed to the bottom of
                        // the *full* available height — on a shorter
                        // landscape viewport (nav bar eating into it) that
                        // was pushing the button off-screen entirely. This
                        // still scrolls if content is taller than the
                        // available space, but never needs to.
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(8, topPad, 16, 12),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  letterLabel,
                                  if (_validated) ...[
                                    const SizedBox(height: 8),
                                    validationFeedback,
                                  ],
                                  const SizedBox(height: 12),
                                  actionButtons,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                )
              // ── PORTRAIT ───────────────────────────────────────────────
              // The canvas is deliberately NOT inside a SingleChildScrollView.
              // A scrollable ancestor's own vertical-drag recognizer competes
              // with the canvas's drag gestures in the gesture arena — for
              // letters with vertical strokes, page-scroll could win instead
              // of the trace, which is exactly what "not able to trace at
              // all, page isn't stable" describes. Content above and below
              // the canvas each get their own independent scroll region, so
              // they still handle overflow safely, but neither wraps the
              // canvas itself.
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(children: [
                          const SizedBox(height: 76),
                          progressDots,
                          const SizedBox(height: 12),
                          letterLabel,
                          const SizedBox(height: 12),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _TracingCanvas(
                        key: ValueKey(_currentLetterIndex),
                        character: _current.character,
                        controller: _controller,
                        fixedHeight: 280,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                        child: Column(children: [
                          validationFeedback,
                          const SizedBox(height: 14),
                          actionButtons,
                        ]),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NATURE BACKGROUND  (identical painter to alphabet_audio.dart)
// Sky → sun → clouds → horizon haze → water → ground → grass blades
// ─────────────────────────────────────────────────────────────────────────────

class _NatureBackground extends StatelessWidget {
  const _NatureBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NaturePainter(),
      child: const SizedBox.expand(),
    );
  }
}

class _NaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF87CEEB));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.30),
        Paint()..color = const Color(0xFFD6EFF9));

    canvas.drawCircle(Offset(w * 0.82, h * 0.10), 32,
        Paint()..color = const Color(0xFFFFE066));
    canvas.drawCircle(Offset(w * 0.82, h * 0.10), 22,
        Paint()..color = const Color(0xFFFFD700));

    _drawCloud(canvas, Offset(w * 0.22, h * 0.14), 44, 0.92);
    _drawCloud(canvas, Offset(w * 0.55, h * 0.10), 34, 0.78);

    canvas.drawRect(Rect.fromLTWH(0, h * 0.50, w, h * 0.06),
        Paint()..color = const Color(0xFFC8E9B0).withValues(alpha: 0.55));

    canvas.drawRect(Rect.fromLTWH(0, h * 0.54, w, h * 0.09),
        Paint()..color = const Color(0xFF5BB8E8).withValues(alpha: 0.72));
    final shimmer = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 5; i++) {
      final y = h * 0.555 + i * 6.0;
      canvas.drawLine(Offset(w * 0.05 + i * 18, y),
          Offset(w * 0.30 + i * 12, y), shimmer);
    }
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(w * 0.82, h * 0.575), width: 28, height: 8),
      Paint()..color = const Color(0xFFFFE066).withValues(alpha: 0.45),
    );

    canvas.drawRect(Rect.fromLTWH(0, h * 0.62, w, h * 0.38),
        Paint()..color = const Color(0xFF6BBF47));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.62, w, h * 0.04),
        Paint()..color = const Color(0xFF8BD45A).withValues(alpha: 0.6));

    final bladeCount = (w / 11).ceil();
    for (int i = 0; i <= bladeCount; i++) {
      final x = i * 11.0;
      final baseY = h * 0.645;
      final variance = (i % 5) * 5.0;
      final lean = (i % 3 == 0) ? 4.0 : (i % 3 == 1) ? -3.0 : 0.0;
      final tipH = 24 + variance;

      final back = Path()
        ..moveTo(x + 3, baseY)
        ..quadraticBezierTo(
            x + 7 + lean, baseY - tipH * 0.6, x + 5 + lean, baseY - tipH)
        ..lineTo(x + 3, baseY);
      canvas.drawPath(back,
          Paint()..color = const Color(0xFF4FAB28).withValues(alpha: 0.65));

      final front = Path()
        ..moveTo(x, baseY)
        ..quadraticBezierTo(x + 5 + lean, baseY - tipH * 0.55,
            x + 2 + lean, baseY - tipH - 8)
        ..lineTo(x, baseY);
      canvas.drawPath(front, Paint()..color = const Color(0xFF3D8A24));
    }
  }

  void _drawCloud(Canvas canvas, Offset center, double r, double opacity) {
    final p = Paint()..color = Colors.white.withValues(alpha: opacity);
    canvas.drawOval(
        Rect.fromCenter(center: center, width: r * 2.2, height: r * 0.9), p);
    canvas.drawCircle(center.translate(-r * 0.4, 0), r * 0.65, p);
    canvas.drawCircle(center.translate(r * 0.35, -r * 0.1), r * 0.55, p);
  }

  @override
  bool shouldRepaint(_NaturePainter _) => false;
}