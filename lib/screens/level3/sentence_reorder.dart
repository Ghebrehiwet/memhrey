// lib/screens/level3/sentence_reorder.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/sentence.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

class SentenceReorderScreen extends StatefulWidget {
  final Sentence sentence;
  const SentenceReorderScreen({super.key, required this.sentence});

  @override
  State<SentenceReorderScreen> createState() =>
      _SentenceReorderScreenState();
}

class _SentenceReorderScreenState extends State<SentenceReorderScreen> {
  late List<String> _available;
  final List<String> _placed = [];
  bool _checked = false;
  bool _correct = false;

  // ── Celebration ────────────────────────────────────────────────────────────
  late ConfettiController _confettiCenter;
  late ConfettiController _confettiLeft;
  late ConfettiController _confettiRight;
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const List<Color> _confettiColors = [
    Color(0xFFFF7043),
    Color(0xFF4CAF50),
    Colors.amber,
    Colors.pink,
    Colors.deepPurple,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();
    _confettiCenter = ConfettiController(duration: const Duration(seconds: 4));
    _confettiLeft   = ConfettiController(duration: const Duration(seconds: 4));
    _confettiRight  = ConfettiController(duration: const Duration(seconds: 4));
    _reset();
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

  void _reset() {
    _available = [...widget.sentence.words]..shuffle();
    _placed.clear();
    _checked = false;
    _correct = false;
    _confettiCenter.stop();
    _confettiLeft.stop();
    _confettiRight.stop();
    if (mounted) setState(() {});
  }

  void _placeWord(String word, int fromIndex) {
    if (_checked) return;
    setState(() {
      _available.removeAt(fromIndex);
      _placed.add(word);
    });
  }

  void _removeWord(int fromIndex) {
    if (_checked) return;
    setState(() {
      final w = _placed.removeAt(fromIndex);
      _available.add(w);
    });
  }

  void _check() {
    final answer  = _placed.join(' ');
    final correct = widget.sentence.tigrigna;
    final isCorrect = answer == correct;
    setState(() {
      _checked = true;
      _correct = isCorrect;
    });
    if (isCorrect) _celebrate();
  }

  void _celebrate() {
    _confettiCenter.play();
    _confettiLeft.play();
    _confettiRight.play();
    _audioPlayer.play(AssetSource('audio/success_chime.mp3'));
  }

  Future<void> _done() async {
    if (_correct) {
      await context
          .read<ProgressProvider>()
          .markSentenceDone(widget.sentence.id);
    }
    if (mounted) Navigator.pop(context);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final s           = widget.sentence;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Stack(
      children: [
        // ── Main scaffold ──────────────────────────────────────────────────
        Scaffold(
          backgroundColor: const Color(0xFFFFF3E0),
          appBar: AppBar(
            title: const Text('ቃላት ኣማዓራሪ - Reorder Words',
                style: TextStyle(fontFamily: 'AbyssinicaSIL')),
            backgroundColor: const Color(0xFFFF7043),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(isLandscape ? 12 : 20),
            child: Column(children: [
              // ── Instructions ─────────────────────────────────────────────
              Container(
                padding: EdgeInsets.all(isLandscape ? 10 : 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7043).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: const Color(0xFFFF7043).withOpacity(0.3)),
                ),
                child: Column(children: [
                  Text(
                    'ቃላት ብቅኑዕ ኣጋባብ ስርዓዮም - Arrange the words into the correct sentence:',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: isLandscape ? 13 : 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text('"${s.english}"',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  AudioBtn(
                      ttsText: s.tigrigna,
                      audioPath: s.audioPath,
                      size: 38,
                      color: const Color(0xFFFF7043)),
                ]),
              ).animate().fadeIn(duration: 300.ms),

              SizedBox(height: isLandscape ? 12 : 24),

              // ── Answer area ───────────────────────────────────────────────
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: EdgeInsets.all(isLandscape ? 8 : 12),
                decoration: BoxDecoration(
                  color: _checked
                      ? (_correct
                          ? const Color(0xFFE8F5E9)
                          : const Color(0xFFFFEBEE))
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _checked
                        ? (_correct
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFFF44336))
                        : Colors.grey[300]!,
                    width: 2,
                  ),
                  // Green glow when correct
                  boxShadow: (_checked && _correct)
                      ? [
                          BoxShadow(
                            color:
                                const Color(0xFF4CAF50).withOpacity(0.3),
                            blurRadius: 14,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                child: _placed.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'ኣብ ታሕቲ ዘለዉ ቃላት ጠውቕ - Tap words below to place them here',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _placed.asMap().entries.map((e) {
                          return GestureDetector(
                            onTap: () => _removeWord(e.key),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: _checked
                                    ? (_correct
                                        ? const Color(0xFF4CAF50)
                                            .withOpacity(0.15)
                                        : const Color(0xFFF44336)
                                            .withOpacity(0.15))
                                    : const Color(0xFFFF7043)
                                        .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: _checked
                                      ? (_correct
                                          ? const Color(0xFF4CAF50)
                                          : const Color(0xFFF44336))
                                      : const Color(0xFFFF7043),
                                ),
                              ),
                              child: Text(e.value,
                                  style: const TextStyle(
                                      fontFamily: 'AbyssinicaSIL',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                          );
                        }).toList(),
                      ),
              ),

              SizedBox(height: isLandscape ? 8 : 12),

              // ── Feedback banner ───────────────────────────────────────────
              if (_checked)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: isLandscape ? 6 : 10),
                  decoration: BoxDecoration(
                    color: _correct
                        ? const Color(0xFFE8F5E9)
                        : const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(12),
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
                  child: Column(children: [
                    Row(children: [
                      Text(_correct ? '🎉' : '❌',
                          style: TextStyle(
                              fontSize: isLandscape ? 18 : 20)),
                      const SizedBox(width: 8),
                      Text(
                        _correct
                            ? 'ቅኑዕ  - Correct!'
                            : '❌ ቅኑዕ ኣሰራርዓ: - Correct order:',
                        style: TextStyle(
                          color: _correct
                              ? const Color(0xFF2E7D32)
                              : const Color(0xFFC62828),
                          fontWeight: FontWeight.bold,
                          fontSize: isLandscape ? 13 : 15,
                        ),
                      ),
                    ]),
                    if (!_correct) ...[
                      const SizedBox(height: 4),
                      Text(s.tigrigna,
                          style: const TextStyle(
                              fontFamily: 'AbyssinicaSIL',
                              fontSize: 18,
                              color: Color(0xFF1565C0),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ],
                  ]),
                ).animate().fadeIn().scale(),

              SizedBox(height: isLandscape ? 12 : 24),

              // ── Word bank ─────────────────────────────────────────────────
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('መኽዘን ናይ ቃላት - Word bank:',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 13)),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _available.asMap().entries.map((e) {
                  return GestureDetector(
                    onTap: () => _placeWord(e.value, e.key),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: isLandscape ? 7 : 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7043),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: const Color(0xFFFF7043)
                                  .withOpacity(0.35),
                              blurRadius: 6,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: Text(e.value,
                          style: TextStyle(
                              fontFamily: 'AbyssinicaSIL',
                              fontSize: isLandscape ? 16 : 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ).animate().scale(
                        duration: 200.ms, curve: Curves.elasticOut),
                  );
                }).toList(),
              ),

              SizedBox(height: isLandscape ? 12 : 24),

              // ── Action buttons ─────────────────────────────────────────────
              Row(children: [
                OutlinedButton.icon(
                  onPressed: _reset,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: isLandscape ? 8 : 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _checked
                        ? _done
                        : (_available.isEmpty ? _check : null),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _checked
                          ? (_correct
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFFF44336))
                          : const Color(0xFFFF7043),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                          vertical: isLandscape ? 8 : 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: Text(
                      _checked
                          ? 'ቀጽል - Continue'
                          : 'ቅኑዕ ኣሰራርዓ ኣረጋግጽ - Check Order',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ]),

              const SizedBox(height: 16),
            ]),
          ),
        ),

        // ── Confetti cannons ───────────────────────────────────────────────

        // Top-center: explosive burst
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

        // Top-left: shoots toward center-right (~30°)
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _confettiLeft,
            blastDirection: 0.5,
            numberOfParticles: 20,
            maxBlastForce: 28,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: _confettiColors,
          ),
        ),

        // Top-right: shoots toward center-left (~150°)
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _confettiRight,
            blastDirection: 2.6,
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