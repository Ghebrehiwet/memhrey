// lib/screens/level1/alphabet_matching.dart
//
// AlphabetMatchingScreen — tap-to-match letter ↔ romanization activity.
//
// Layout:
//   A three-column row fills the available height:
//     Column 1: 7 Ethiopic letter tiles (left)
//     Column 2: connector dashes (white when unmatched, green when matched)
//     Column 3: 7 romanization + audio button pairs (right, shuffled)
//
//   Above the grid: a frosted instruction card with the set's example
//   word, audio button, and emoji/image.
//
//   The score badge in the AppBar shows X/7 as the user makes matches.
//
// Overflow fix (this revision):
//   The three grid columns previously used
//   `Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [...7 tiles])`.
//   spaceEvenly only DISTRIBUTES leftover space between children — it can't
//   shrink them. On a short landscape viewport, the app bar + instruction
//   card can leave less room than the 7 tiles' combined natural height
//   (padding + font + border), and since spaceEvenly can't compress that,
//   the Column overflows at the bottom with nowhere for the extra space to
//   go — exactly the "BOTTOM OVERFLOWED BY N PIXELS" banner.
//
//   Fixed by wrapping the grid in a LayoutBuilder that explicitly divides
//   the measured available height into 7 equal row slots. If that would
//   make rows shorter than a readable/tappable minimum, the grid falls back
//   to a SingleChildScrollView instead of overflowing.
//
// Matching logic:
//   Tapping a letter sets _selectedLetterIndex.
//   Tapping a romanization tile sets _selectedImageIndex.
//   When both are set _tryMatch() fires: correct → mark both matched + score++;
//   wrong → clear selections after 500 ms.
//   Score == 7 → _showWin() marks the activity done (+10 XP) and shows a dialog.
//
// Shared at the bottom: _NatureBackground / _NaturePainter.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/alphabet_data.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MATCHING SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AlphabetMatchingScreen extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;

  const AlphabetMatchingScreen(
      {super.key, required this.setIndex, required this.set});

  @override
  State<AlphabetMatchingScreen> createState() =>
      _AlphabetMatchingScreenState();
}

class _AlphabetMatchingScreenState extends State<AlphabetMatchingScreen> {
  // ── Selection state ────────────────────────────────────────────────────────
  int? _selectedLetterIndex;
  int? _selectedImageIndex;

  // ── Match state ────────────────────────────────────────────────────────────
  final List<bool> _letterMatched = List.filled(7, false);
  final List<bool> _imageMatched  = List.filled(7, false);
  late List<int> _shuffledImageIndices; // shuffled romanization order
  int _score = 0;

  // Minimum row height for legibility/tappability. Below this, the grid
  // switches from "exact fit" to "scrollable" rather than compressing tiles
  // into something unreadable or too small to tap accurately.
  static const double _minItemHeight = 34.0;

  @override
  void initState() {
    super.initState();
    _shuffledImageIndices = List.generate(7, (i) => i)..shuffle();
  }

  // ── Tap handlers ──────────────────────────────────────────────────────────

  void _selectLetter(int index) {
    if (_letterMatched[index]) return;
    setState(() {
      _selectedLetterIndex = _selectedLetterIndex == index ? null : index;
    });
    _tryMatch();
  }

  void _selectImage(int shuffledIndex) {
    final actualIndex = _shuffledImageIndices[shuffledIndex];
    if (_imageMatched[actualIndex]) return;
    setState(() {
      _selectedImageIndex =
          _selectedImageIndex == shuffledIndex ? null : shuffledIndex;
    });
    _tryMatch();
  }

  // ── Match logic ───────────────────────────────────────────────────────────

  void _tryMatch() {
    if (_selectedLetterIndex == null || _selectedImageIndex == null) return;
    final imageActualIndex = _shuffledImageIndices[_selectedImageIndex!];

    if (_selectedLetterIndex == imageActualIndex) {
      // Correct match: mark both sides and update score
      setState(() {
        _letterMatched[_selectedLetterIndex!] = true;
        _imageMatched[imageActualIndex] = true;
        _score++;
        _selectedLetterIndex = null;
        _selectedImageIndex = null;
      });
      if (_score == 7) _showWin();
    } else {
      // Wrong match: clear selections after brief pause
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _selectedLetterIndex = null;
            _selectedImageIndex = null;
          });
        }
      });
    }
  }

  // ── Win dialog + activity completion ─────────────────────────────────────
  void _showWin() async {
    // Capture provider BEFORE the async gap to avoid BuildContext across async gap
    final progress = context.read<ProgressProvider>();

    await Future.delayed(const Duration(milliseconds: 500));

    // Guard: widget may have been disposed during the delay
    if (!mounted) return;

    await progress.markAlphabetActivity(widget.setIndex, 'matching');

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('🎉 ቅኑዕ ምዝማድ! - Perfect Match!',
            textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ኩሎም ፊደላት ቅኑዕ ጌርኩም ኣዛሚድክምዎም! - You matched all letters correctly!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text('+10 XP earned',
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C4DFF),
                foregroundColor: Colors.white),
            child: const Text('ቀጽሉ - Continue'),
          ),
        ],
      ),
    );
  }

  // ── Single letter tile (column 1) ─────────────────────────────────────────
  Widget _buildLetterTile(int i, bool isLandscape) {
    final letters = widget.set.letters;
    final selected = _selectedLetterIndex == i;
    final matched = _letterMatched[i];
    return GestureDetector(
      onTap: () => _selectLetter(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isLandscape ? 6 : 10,
          vertical: isLandscape ? 3 : 6,
        ),
        decoration: BoxDecoration(
          color: matched
              ? const Color(0xFFE8F5E9)
              : selected
                  ? const Color(0xFFE3F2FD)
                  : Colors.white.withValues(alpha: 0.88),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: matched
                ? Colors.green
                : selected
                    ? Colors.blue
                    : const Color(0xFF7C4DFF).withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          letters[i].character,
          style: TextStyle(
            fontFamily: 'AbyssinicaSIL',
            fontSize: isLandscape ? 18 : 24,
            color: matched ? const Color(0xFF2E7D32) : const Color(0xFF4A3080),
          ),
        ),
      ),
    );
  }

  // ── Single romanization + audio tile (column 3) ───────────────────────────
  Widget _buildRomanizationTile(int i, bool isLandscape) {
    final letters = widget.set.letters;
    final actualIndex = _shuffledImageIndices[i];
    final selected = _selectedImageIndex == i;
    final matched = _imageMatched[actualIndex];
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _selectImage(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(
              horizontal: isLandscape ? 6 : 8,
              vertical: isLandscape ? 3 : 6,
            ),
            decoration: BoxDecoration(
              color: matched
                  ? const Color(0xFFE8F5E9)
                  : selected
                      ? const Color(0xFFE3F2FD)
                      : Colors.white.withValues(alpha: 0.88),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: matched
                    ? Colors.green
                    : selected
                        ? Colors.blue
                        : const Color(0xFF7C4DFF).withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              letters[actualIndex].romanization,
              style: TextStyle(
                fontSize: isLandscape ? 11 : 13,
                fontWeight: FontWeight.bold,
                color:
                    matched ? const Color(0xFF2E7D32) : const Color(0xFF4A3080),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        AudioBtn(
          audioPath: letters[actualIndex].audioPath,
          size: isLandscape ? 24 : 28,
          color: matched ? Colors.green : const Color(0xFF7C4DFF),
        ),
      ],
    );
  }

  // ── The matching grid, sized to fit exactly (or scroll) ───────────────────
  // Replaces the old `Column(mainAxisAlignment: spaceEvenly)` per-column
  // layout, which could overflow if 7 tiles' natural heights exceeded the
  // space left after the app bar and instruction card. This measures the
  // actual available height and divides it into 7 equal rows; if that would
  // make rows smaller than _minItemHeight, it scrolls instead of shrinking
  // tiles into something unreadable or overflowing off-screen.
  Widget _buildGrid(bool isLandscape) {
    return LayoutBuilder(builder: (context, constraints) {
      final rawItemHeight = constraints.maxHeight / 7;
      final itemHeight =
          rawItemHeight < _minItemHeight ? _minItemHeight : rawItemHeight;
      final gridHeight = itemHeight * 7;
      final needsScroll = gridHeight > constraints.maxHeight + 0.5;

      final grid = SizedBox(
        height: gridHeight,
        child: Row(
          children: [
            // Column 1: letter tiles
            Expanded(
              child: Column(
                children: List.generate(
                  7,
                  (i) => SizedBox(
                    height: itemHeight,
                    child: Center(child: _buildLetterTile(i, isLandscape)),
                  ),
                ),
              ),
            ),

            // Column 2: connector dashes
            const SizedBox(width: 6),
            Column(
              children: List.generate(
                7,
                (i) => SizedBox(
                  height: itemHeight,
                  child: Center(
                    child: Container(
                      width: 16,
                      height: 2,
                      decoration: BoxDecoration(
                        color: _letterMatched[i]
                            ? Colors.green
                            : Colors.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),

            // Column 3: romanization + audio
            Expanded(
              child: Column(
                children: List.generate(
                  7,
                  (i) => SizedBox(
                    height: itemHeight,
                    child: Center(
                        child: _buildRomanizationTile(i, isLandscape)),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

      return needsScroll ? SingleChildScrollView(child: grid) : grid;
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'ምዝማድ ጉጅለ ${widget.setIndex + 1} - Match Set ${widget.setIndex + 1}',
        ),
        backgroundColor: const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // Score badge (frosted pill in AppBar)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('$_score/7',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15)),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // ── Nature background ────────────────────────────────────────────
          const Positioned.fill(child: _NatureBackground()),

          // ── Content column ───────────────────────────────────────────────
          Column(
            children: [
              // AppBar clearance
              SizedBox(height: isLandscape ? 56 : 72),

              // ── Frosted instruction + example word card ──────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                    16, isLandscape ? 4 : 8, 16, 0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: isLandscape ? 8 : 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.82),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF7C4DFF)
                              .withValues(alpha: 0.25),
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
                          // Icon badge
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C4DFF)
                                  .withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                                Icons.compare_arrows_rounded,
                                color: Color(0xFF7C4DFF),
                                size: 20),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              children: [
                                // Example word audio button
                                AudioBtn(
                                    audioPath: widget.set.matchAudio,
                                    size: isLandscape ? 30 : 36),
                                const SizedBox(width: 8),
                                // Example word text + subtitle
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.set.matchWord,
                                        style: TextStyle(
                                          fontFamily: 'AbyssinicaSIL',
                                          fontSize: isLandscape ? 16 : 20,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF4A3080),
                                        ),
                                      ),
                                      if (!isLandscape)
                                        const Text(
                                          'ነፍስ ወከፍ ፊደል ምስ ድምጻ ኣዛምድ',
                                          style: TextStyle(
                                            fontFamily: 'AbyssinicaSIL',
                                            color: Color(0xFF7C4DFF),
                                            fontSize: 11,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Emoji or image
                          if (widget.set.matchImage.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                widget.set.matchImage,
                                width: isLandscape ? 32 : 42,
                                height: isLandscape ? 32 : 42,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    widget.set.matchEmoji.isNotEmpty
                                        ? Text(widget.set.matchEmoji,
                                            style: TextStyle(
                                                fontSize:
                                                    isLandscape ? 22 : 28))
                                        : const Icon(Icons.image,
                                            color: Colors.grey),
                              ),
                            )
                          else if (widget.set.matchEmoji.isNotEmpty)
                            Text(widget.set.matchEmoji,
                                style: TextStyle(
                                    fontSize: isLandscape ? 22 : 28))
                          else
                            const Icon(Icons.image, color: Colors.grey),
                        ],
                      ),
                    ),
                    SizedBox(height: isLandscape ? 4 : 8),
                  ],
                ),
              ),

              // ── Matching grid (fills remaining space, never overflows) ───
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                  child: _buildGrid(isLandscape),
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
// NATURE BACKGROUND  (identical to alphabet_audio.dart)
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

    // Sky
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h),
        Paint()..color = const Color(0xFF87CEEB));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h * 0.30),
        Paint()..color = const Color(0xFFD6EFF9));

    // Sun
    canvas.drawCircle(Offset(w * 0.82, h * 0.10), 32,
        Paint()..color = const Color(0xFFFFE066));
    canvas.drawCircle(Offset(w * 0.82, h * 0.10), 22,
        Paint()..color = const Color(0xFFFFD700));

    // Clouds
    _drawCloud(canvas, Offset(w * 0.22, h * 0.14), 44, 0.92);
    _drawCloud(canvas, Offset(w * 0.55, h * 0.10), 34, 0.78);

    // Horizon haze
    canvas.drawRect(Rect.fromLTWH(0, h * 0.50, w, h * 0.06),
        Paint()..color = const Color(0xFFC8E9B0).withValues(alpha: 0.55));

    // Water
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

    // Ground
    canvas.drawRect(Rect.fromLTWH(0, h * 0.62, w, h * 0.38),
        Paint()..color = const Color(0xFF6BBF47));
    canvas.drawRect(Rect.fromLTWH(0, h * 0.62, w, h * 0.04),
        Paint()..color = const Color(0xFF8BD45A).withValues(alpha: 0.6));

    // Grass blades
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