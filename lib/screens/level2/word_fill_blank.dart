// lib/screens/level2/word_fill_blank.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/word.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

class WordFillBlankScreen extends StatefulWidget {
  final Word word;
  const WordFillBlankScreen({super.key, required this.word});

  @override
  State<WordFillBlankScreen> createState() => _WordFillBlankScreenState();
}

class _WordFillBlankScreenState extends State<WordFillBlankScreen> {
  late List<String> _scrambled;
  final List<String> _placed = [];
  bool _checked = false;
  bool _correct = false;
  static const _accent = Color(0xFF00BCD4);

  // ── Celebration ────────────────────────────────────────────────────────────
  late ConfettiController _confettiCenter;
  late ConfettiController _confettiLeft;
  late ConfettiController _confettiRight;
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const List<Color> _confettiColors = [
    Color(0xFF00BCD4),
    Color(0xFF4CAF50),
    Colors.amber,
    Colors.pink,
    Colors.deepPurple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _confettiCenter = ConfettiController(duration: const Duration(seconds: 4));
    _confettiLeft   = ConfettiController(duration: const Duration(seconds: 4));
    _confettiRight  = ConfettiController(duration: const Duration(seconds: 4));
    _scrambleLetters();
  }

  @override
  void dispose() {
    _confettiCenter.dispose();
    _confettiLeft.dispose();
    _confettiRight.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  // ── Game logic ─────────────────────────────────────────────────────────────

  void _scrambleLetters() {
    final chars = widget.word.tigrigna.characters.toList();
    _scrambled = [...chars]..shuffle();
    _placed.clear();
  }

  void _placeLetter(String letter, int fromIndex) {
    if (_checked) return;
    setState(() {
      _scrambled.removeAt(fromIndex);
      _placed.add(letter);
    });
  }

  void _removeLetter(int fromIndex) {
    if (_checked) return;
    setState(() {
      final letter = _placed.removeAt(fromIndex);
      _scrambled.add(letter);
    });
  }

  void _check() {
    final answer = _placed.join();
    final correct = answer == widget.word.tigrigna;
    setState(() {
      _checked = true;
      _correct = correct;
    });
    if (correct) {
      _celebrate();
    }
  }

  void _celebrate() {
    _confettiCenter.play();
    _confettiLeft.play();
    _confettiRight.play();
    _audioPlayer.play(AssetSource('audio/success_chime.mp3'));
  }

  void _reset() {
    // Stop any running confetti
    _confettiCenter.stop();
    _confettiLeft.stop();
    _confettiRight.stop();
    setState(() {
      _checked = false;
      _correct = false;
      _scrambleLetters();
    });
  }

  Future<void> _done() async {
    if (_correct) {
      await context.read<ProgressProvider>().markWordDone(widget.word.id);
    }
    if (mounted) Navigator.pop(context);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final word        = widget.word;
    final targetLen   = word.tigrigna.characters.length;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Stack(
      children: [
        // ── Main scaffold ────────────────────────────────────────────────────
        Scaffold(
          backgroundColor: const Color(0xFFF0FCFF),
          appBar: AppBar(
            title: const Text('ባዶ ቦታ ምላእ - Fill in the Blank',
                style: TextStyle(fontFamily: 'AbyssinicaSIL')),
            backgroundColor: _accent,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(isLandscape ? 12 : 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: isLandscape ? 4 : 16),

                // ── Hint card ───────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isLandscape ? 10 : 20),
                  decoration: BoxDecoration(
                    color: _accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: _accent.withOpacity(0.3)),
                  ),
                  child: isLandscape
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _EmojiBox(emoji: word.emoji, size: 56, fontSize: 34),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(word.english,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Text(word.transliteration,
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 12)),
                              ],
                            ),
                            const SizedBox(width: 14),
                            AudioBtn(
                                ttsText: word.tigrigna,
                                audioPath: word.audioPath,
                                size: 36,
                                color: _accent),
                          ],
                        )
                      : Column(
                          children: [
                            _EmojiBox(emoji: word.emoji, size: 80, fontSize: 48),
                            const SizedBox(height: 10),
                            Text(word.english,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Text(word.transliteration,
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 14)),
                            const SizedBox(height: 8),
                            AudioBtn(
                                ttsText: word.tigrigna,
                                audioPath: word.audioPath,
                                size: 40,
                                color: _accent),
                          ],
                        ),
                ).animate().fadeIn(duration: 300.ms),

                SizedBox(height: isLandscape ? 12 : 32),

                // ── Answer slots ─────────────────────────────────────────────
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing  = 6.0;
                    final totalSpc = spacing * (targetLen - 1);
                    final boxSize  =
                        ((constraints.maxWidth - totalSpc) / targetLen)
                            .clamp(28.0, 54.0);

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(targetLen, (i) {
                          final filled = i < _placed.length;
                          final letter = filled ? _placed[i] : '';
                          Color borderColor = _accent;
                          if (_checked) {
                            borderColor = _correct
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFF44336);
                          }
                          return GestureDetector(
                            onTap: filled ? () => _removeLetter(i) : null,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: spacing / 2),
                              width:  boxSize,
                              height: boxSize + 6,
                              decoration: BoxDecoration(
                                color: filled
                                    ? borderColor.withOpacity(0.1)
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: borderColor, width: 2),
                              ),
                              child: Center(
                                child: Text(
                                  letter,
                                  style: TextStyle(
                                      fontFamily: 'AbyssinicaSIL',
                                      fontSize: (boxSize * 0.48)
                                          .clamp(14.0, 26.0),
                                      fontWeight: FontWeight.bold,
                                      color: borderColor),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),

                SizedBox(height: isLandscape ? 8 : 16),

                // ── Feedback banner ──────────────────────────────────────────
                if (_checked)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: isLandscape ? 6 : 12),
                    decoration: BoxDecoration(
                      color: _correct
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _correct
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF44336),
                        width: 1.5,
                      ),
                      boxShadow: _correct
                          ? [
                              BoxShadow(
                                color: const Color(0xFF4CAF50)
                                    .withOpacity(0.25),
                                blurRadius: 12,
                                spreadRadius: 2,
                              )
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _correct ? '🎉' : '❌',
                          style: TextStyle(
                              fontSize: isLandscape ? 20 : 26),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _correct
                                ? 'ቅኑዕ - Correct!  ${word.tigrigna}'
                                : 'ድገም! መልሲ: ${word.tigrigna}',
                            style: TextStyle(
                              fontFamily: 'AbyssinicaSIL',
                              color: _correct
                                  ? const Color(0xFF2E7D32)
                                  : const Color(0xFFC62828),
                              fontSize: isLandscape ? 14 : 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().scale(),

                SizedBox(height: isLandscape ? 8 : 24),

                // ── Scrambled letter bank ─────────────────────────────────────
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: _scrambled.asMap().entries.map((e) {
                    final tileSize = isLandscape ? 40.0 : 52.0;
                    return GestureDetector(
                      onTap: () => _placeLetter(e.value, e.key),
                      child: Container(
                        width:  tileSize,
                        height: tileSize,
                        decoration: BoxDecoration(
                          color: _accent,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: _accent.withOpacity(0.4),
                                blurRadius: 6,
                                offset: const Offset(0, 3))
                          ],
                        ),
                        child: Center(
                          child: Text(e.value,
                              style: TextStyle(
                                  fontFamily: 'AbyssinicaSIL',
                                  fontSize: isLandscape ? 18 : 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ).animate().scale(
                          duration: 200.ms, curve: Curves.elasticOut),
                    );
                  }).toList(),
                ),

                SizedBox(height: isLandscape ? 12 : 24),

                // ── Action buttons ────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Reset'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: isLandscape ? 8 : 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _checked
                            ? _done
                            : (_placed.length == targetLen ? _check : null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _checked
                              ? (_correct
                                  ? const Color(0xFF4CAF50)
                                  : const Color(0xFFF44336))
                              : _accent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: isLandscape ? 8 : 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        child: Text(
                          _checked
                              ? 'ቀጽል - Continue'
                              : 'መልሲ ርአ - Check Answer',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),

        // ── Confetti cannons — three positions for full coverage ─────────────

        // Top-center
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiCenter,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 35,
            maxBlastForce: 35,
            minBlastForce: 12,
            emissionFrequency: 0.04,
            gravity: 0.25,
            colors: _confettiColors,
          ),
        ),

        // Top-left corner — shoots toward center-right
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _confettiLeft,
            blastDirection: 0.5, // ~30° downward-right
            numberOfParticles: 20,
            maxBlastForce: 28,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: _confettiColors,
          ),
        ),

        // Top-right corner — shoots toward center-left
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _confettiRight,
            blastDirection: 2.6, // ~150° downward-left
            numberOfParticles: 20,
            maxBlastForce: 28,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: _confettiColors,
          ),
        ),
      ],
    );
  }
}

// ── Helper widget — renders the emoji (never falls back to a placeholder) ─────

class _EmojiBox extends StatelessWidget {
  final String emoji;
  final double size;
  final double fontSize;

  const _EmojiBox({
    required this.emoji,
    required this.size,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF00BCD4).withOpacity(0.15),
        borderRadius: BorderRadius.circular(size * 0.15),
      ),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
    );
  }
}