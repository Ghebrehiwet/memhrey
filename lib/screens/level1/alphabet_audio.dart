// lib/screens/level1/alphabet_audio.dart
//
// Contains two screens that share the same nature background:
//   • AlphabetAudioScreen      — listen to each letter's pronunciation
//   • AlphabetSequencingScreen — drag letters into correct order
//
// Shared helpers at the bottom of this file:
//   • _NavButton          — styled previous / next / complete button
//   • _NatureBackground   — full-screen sky / water / grass backdrop
//   • _NaturePainter      — CustomPainter that draws the landscape

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/alphabet_data.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AUDIO SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AlphabetAudioScreen extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;

  const AlphabetAudioScreen({
    super.key,
    required this.setIndex,
    required this.set,
  });

  @override
  State<AlphabetAudioScreen> createState() => _AlphabetAudioScreenState();
}

class _AlphabetAudioScreenState extends State<AlphabetAudioScreen> {
  int _currentIndex = 0;
  // ignore: unused_field
  int _listenCount = 0;

  AlphabetLetter get _current =>
      widget.set.letters[_currentIndex.clamp(0, 6)];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'ስምዑ ጉጅለ ${widget.setIndex + 1} - Listen Set ${widget.setIndex + 1}',
        ),
        backgroundColor: const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: _NatureBackground()),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    7,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: i == _currentIndex ? 24 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: i == _currentIndex
                            ? const Color(0xFF7C4DFF)
                            : Colors.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7C4DFF), Color(0xFF9C6DFF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C4DFF).withValues(alpha: 0.45),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _current.character,
                        style: const TextStyle(
                          fontFamily: 'AbyssinicaSIL',
                          fontSize: 80,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        _current.romanization,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(duration: 350.ms, curve: Curves.elasticOut),
                const SizedBox(height: 28),
                AudioBtn(audioPath: _current.audioPath, size: 72),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C4DFF).withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.volume_up_rounded,
                          color: Color(0xFF7C4DFF),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ድምጺ ክትሰምዑ ናይ ሞግልሒ ድምጺ ምልክት ጠውቑ',
                              style: TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                color: Color(0xFF4A3080),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Tap the speaker to hear the sound',
                              style: TextStyle(
                                color: Color(0xFF7C4DFF),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentIndex > 0)
                      _NavButton(
                        onPressed: () => setState(() => _currentIndex--),
                        icon: Icons.arrow_back_rounded,
                        label: 'ዝሓለፈ',
                      )
                    else
                      const SizedBox(width: 90),
                    if (_currentIndex < 6)
                      _NavButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex++;
                            _listenCount++;
                          });
                        },
                        icon: Icons.arrow_forward_rounded,
                        label: 'ቀጽሉ',
                        primary: true,
                      )
                    else
                      _NavButton(
                        onPressed: _complete,
                        icon: Icons.check_rounded,
                        label: 'ወዲእኩም',
                        primary: true,
                        success: true,
                      ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _complete() async {
    await context
        .read<ProgressProvider>()
        .markAlphabetActivity(widget.setIndex, 'audio');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '🎉 ንጥፈታት ናይ ድምጺ ምስማዕ ወዲእኩም - Audio activity completed! +10 XP',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NAV BUTTON
// ─────────────────────────────────────────────────────────────────────────────

class _NavButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final bool primary;
  final bool success;

  const _NavButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.primary = false,
    this.success = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = success
        ? const Color(0xFF4CAF50)
        : primary
            ? const Color(0xFF7C4DFF)
            : Colors.white.withValues(alpha: 0.85);
    final Color fg =
        (primary || success) ? Colors.white : const Color(0xFF7C4DFF);

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: primary ? 4 : 1,
        shadowColor: bg.withValues(alpha: 0.4),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: primary || success
              ? BorderSide.none
              : BorderSide(
                  color: const Color(0xFF7C4DFF).withValues(alpha: 0.4)),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// NATURE BACKGROUND
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

    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.50, w, h * 0.06),
      Paint()..color = const Color(0xFFC8E9B0).withValues(alpha: 0.55),
    );

    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.54, w, h * 0.09),
      Paint()..color = const Color(0xFF5BB8E8).withValues(alpha: 0.72),
    );
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
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.62, w, h * 0.04),
      Paint()..color = const Color(0xFF8BD45A).withValues(alpha: 0.6),
    );

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

// ─────────────────────────────────────────────────────────────────────────────
// SEQUENCING SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AlphabetSequencingScreen extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;

  const AlphabetSequencingScreen({
    super.key,
    required this.setIndex,
    required this.set,
  });

  @override
  State<AlphabetSequencingScreen> createState() =>
      _AlphabetSequencingScreenState();
}

class _AlphabetSequencingScreenState
    extends State<AlphabetSequencingScreen> {
  late List<AlphabetLetter> _shuffled;
  late List<AlphabetLetter?> _placed;
  int _score = 0;
  bool _showResult = false;

  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _reset();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _reset() {
    _shuffled = [...widget.set.letters]..shuffle();
    _placed = List.filled(7, null);
    _score = 0;
    _showResult = false;
    if (_confettiController.state == ConfettiControllerState.playing) {
      _confettiController.stop();
    }
  }

  void _place(AlphabetLetter letter, int slotIndex) {
    setState(() {
      for (int i = 0; i < _placed.length; i++) {
        if (_placed[i] == letter) _placed[i] = null;
      }
      _placed[slotIndex] = letter;
    });
  }

  void _check() {
    int correct = 0;
    for (int i = 0; i < 7; i++) {
      if (_placed[i]?.character == widget.set.letters[i].character) correct++;
    }
    setState(() {
      _score = correct;
      _showResult = true;
    });
    if (correct == 7) {
      _confettiController.play();
      _audioPlayer.play(AssetSource('audio/success_chime.mp3'));
    }
  }

  Widget _letterChip(AlphabetLetter l) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF7C4DFF), width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Center(
        child: Text(
          l.character,
          style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 24),
        ),
      ),
    );
  }

  Future<void> _completeActivity() async {
    await context
        .read<ProgressProvider>()
        .markAlphabetActivity(widget.setIndex, 'sequencing');
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'ምትዕርራይ ጉጅለ ${widget.setIndex + 1} - Sequence Set ${widget.setIndex + 1}',
            ),
            backgroundColor: const Color(0xFF7C4DFF),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: Stack(
            children: [
              const Positioned.fill(child: _NatureBackground()),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 76),

                    // ── Instruction box ──────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
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
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C4DFF).withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.drag_indicator_rounded,
                                color: Color(0xFF7C4DFF), size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ፊደላት ብግቡእ ኣታዓራርይዎ!',
                                  style: TextStyle(
                                    fontFamily: 'AbyssinicaSIL',
                                    color: Color(0xFF4A3080),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Arrange the letters in the correct order',
                                  style: TextStyle(
                                    color: Color(0xFF7C4DFF),
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── "Correct order" label — only shown after Check ───
                    if (_showResult) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'ቅኑዕ ጌርኩም ኣታዓራሪኽምዎ: - Correct order:',
                          style: TextStyle(
                              color: Color(0xFF4A3080),
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],

                    // ── Drop slots — Wrap prevents overflow ───────────────
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: List.generate(7, (i) {
                        final placed = _placed[i];
                        final isCorrect = _showResult &&
                            placed?.character ==
                                widget.set.letters[i].character;
                        final isWrong = _showResult &&
                            placed != null &&
                            placed.character !=
                                widget.set.letters[i].character;
                        return DragTarget<AlphabetLetter>(
                          onAcceptWithDetails: (details) =>
                              _place(details.data, i),
                          builder: (_, candidates, __) => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? const Color(0xFFE8F5E9)
                                  : isWrong
                                      ? const Color(0xFFFFEBEE)
                                      : candidates.isNotEmpty
                                          ? const Color(0xFFE3F2FD)
                                          : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: isCorrect
                                    ? Colors.green
                                    : isWrong
                                        ? Colors.red
                                        : candidates.isNotEmpty
                                            ? Colors.blue
                                            : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: placed == null
                                ? Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 11),
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                      placed.character,
                                      style: const TextStyle(
                                          fontFamily: 'AbyssinicaSIL',
                                          fontSize: 20),
                                    ),
                                  ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // ── "Drag from here" label ────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.65),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'ካብ\'ዚ ስሓቡ ወይ ወጥጡ - Drag from here:',
                        style: TextStyle(
                            color: Color(0xFF4A3080),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // ── Draggable letter chips ────────────────────────────
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      children: _shuffled.map((l) {
                        final alreadyPlaced = _placed.contains(l);
                        return Draggable<AlphabetLetter>(
                          data: l,
                          feedback: Material(
                            elevation: 8,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7C4DFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  l.character,
                                  style: const TextStyle(
                                      fontFamily: 'AbyssinicaSIL',
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          childWhenDragging:
                              Opacity(opacity: 0.3, child: _letterChip(l)),
                          child: alreadyPlaced
                              ? Opacity(opacity: 0.2, child: _letterChip(l))
                              : _letterChip(l),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // ── Result / action buttons ───────────────────────────
                    if (_showResult) ...[
                      Text(
                        _score == 7
                            ? '🎉 ጽቡቕ! ኩሎም ቅኑዓት - Perfect! All correct!'
                            : '✅ $_score / 7 ቅኑዕ - correct',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _score == 7 ? Colors.green : Colors.orange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      if (_score == 7)
                        ElevatedButton(
                          onPressed: _completeActivity,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white),
                          child: const Text(
                              'ንጥፈት ወዲእኩም! - Complete Activity!'),
                        )
                      else
                        ElevatedButton(
                          onPressed: () => setState(() => _reset()),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7C4DFF),
                              foregroundColor: Colors.white),
                          child: const Text('ደጊምኩም ፈትኑ - Try Again'),
                        ),
                    ] else
                      ElevatedButton(
                        onPressed: _check,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C4DFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 14),
                        ),
                        child: const Text(
                            'ቅኑዕ ኣሰራርዓ ኣረጋግጹ - Check Order'),
                      ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── Confetti cannon ────────────────────────────────────────────────
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 40,
            maxBlastForce: 30,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: const [
              Color(0xFF7C4DFF),
              Color(0xFF4CAF50),
              Colors.amber,
              Colors.pink,
              Colors.cyan,
            ],
          ),
        ),
      ],
    );
  }
}