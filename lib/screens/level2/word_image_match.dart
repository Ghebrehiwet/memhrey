// lib/screens/level2/word_image_match.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/word.dart';
import '../../data/words_data.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

class WordImageMatchScreen extends StatefulWidget {
  final Word word;
  const WordImageMatchScreen({super.key, required this.word});

  @override
  State<WordImageMatchScreen> createState() => _WordImageMatchScreenState();
}

class _WordImageMatchScreenState extends State<WordImageMatchScreen> {
  late List<Word> _options;
  String? _selectedId;
  bool _answered = false;
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
    _buildOptions();
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

  void _buildOptions() {
    final others =
        wordsData.where((w) => w.id != widget.word.id).toList()..shuffle();
    _options = [widget.word, ...others.take(3)]..shuffle();
  }

  void _onSelect(String id) {
    if (_answered) return;
    setState(() {
      _selectedId = id;
      _answered   = true;
    });
    if (id == widget.word.id) {
      _celebrate();
    }
  }

  void _celebrate() {
    _confettiCenter.play();
    _confettiLeft.play();
    _confettiRight.play();
    _audioPlayer.play(AssetSource('audio/success_chime.mp3'));
  }

  Future<void> _next() async {
    if (_selectedId == widget.word.id) {
      await context.read<ProgressProvider>().markWordDone(widget.word.id);
    }
    if (mounted) Navigator.pop(context);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final word        = widget.word;
    final correct     = _selectedId == word.id;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Stack(
      children: [
        // ── Main scaffold ──────────────────────────────────────────────────
        Scaffold(
          backgroundColor: const Color(0xFFF0FCFF),
          appBar: AppBar(
            title: const Text('ስእሊ ኣዛምድ - Image Match',
                style: TextStyle(fontFamily: 'AbyssinicaSIL')),
            backgroundColor: _accent,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: Column(
            children: [
              // ── Question card ──────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(
                    16, isLandscape ? 6 : 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: isLandscape ? 8 : 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: _accent.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  child: Row(
                    children: [
                      // Emoji / image box
                      Container(
                        width:  isLandscape ? 44 : 60,
                        height: isLandscape ? 44 : 60,
                        decoration: BoxDecoration(
                          color: _accent.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: _accent.withOpacity(0.2)),
                        ),
                        child: Center(
                          child: word.emoji.isNotEmpty
                              ? Text(word.emoji,
                                  style: TextStyle(
                                      fontSize:
                                          isLandscape ? 26 : 36))
                              : Icon(Icons.image_outlined,
                                  color: _accent,
                                  size: isLandscape ? 26 : 36),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(word.english,
                                style: TextStyle(
                                    fontSize: isLandscape ? 16 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF00838F))),
                            Text(
                                'ቅኑዕ ቃል ምረጽ - Choose the correct word',
                                style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 11)),
                          ],
                        ),
                      ),
                      AudioBtn(
                          ttsText: word.tigrigna,
                          audioPath: word.audioPath,
                          size: isLandscape ? 30 : 36,
                          color: _accent),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms),
              ),

              SizedBox(height: isLandscape ? 4 : 8),

              // ── Answer tiles ───────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 16, isLandscape ? 4 : 8),
                  itemCount: _options.length,
                  itemBuilder: (_, i) {
                    final opt        = _options[i];
                    final isSelected = _selectedId == opt.id;
                    final isCorrect  = opt.id == word.id;

                    Color bg          = Colors.white;
                    Color borderColor = Colors.grey[200]!;
                    Color labelBg     = _accent.withOpacity(0.1);
                    Color labelColor  = _accent;
                    IconData? trailingIcon;
                    Color trailingColor = Colors.transparent;

                    if (_answered) {
                      if (isCorrect) {
                        bg          = const Color(0xFFE8F5E9);
                        borderColor = const Color(0xFF4CAF50);
                        labelBg     =
                            const Color(0xFF4CAF50).withOpacity(0.15);
                        labelColor  = const Color(0xFF2E7D32);
                        trailingIcon  = Icons.check_circle;
                        trailingColor = const Color(0xFF4CAF50);
                      } else if (isSelected) {
                        bg          = const Color(0xFFFFEBEE);
                        borderColor = const Color(0xFFF44336);
                        labelBg     =
                            const Color(0xFFF44336).withOpacity(0.1);
                        labelColor    = const Color(0xFFC62828);
                        trailingIcon  = Icons.cancel;
                        trailingColor = const Color(0xFFF44336);
                      }
                    } else if (isSelected) {
                      bg          = _accent.withOpacity(0.06);
                      borderColor = _accent;
                    }

                    return GestureDetector(
                      onTap: () => _onSelect(opt.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        margin: EdgeInsets.only(
                            bottom: isLandscape ? 4 : 8),
                        padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: isLandscape ? 6 : 11),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: borderColor, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    Colors.black.withOpacity(0.04),
                                blurRadius: 4,
                                offset: const Offset(0, 2))
                          ],
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 220),
                              width: 30, height: 30,
                              decoration: BoxDecoration(
                                  color: labelBg,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(['A', 'B', 'C', 'D'][i],
                                    style: TextStyle(
                                        color: labelColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(opt.tigrigna,
                                      style: TextStyle(
                                          fontFamily: 'AbyssinicaSIL',
                                          fontSize:
                                              isLandscape ? 18 : 22,
                                          fontWeight: FontWeight.bold,
                                          height: 1.2)),
                                  Text(opt.transliteration,
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 11)),
                                ],
                              ),
                            ),
                            if (_answered && trailingIcon != null)
                              Icon(trailingIcon,
                                  color: trailingColor, size: 22)
                            else if (!_answered)
                              Icon(Icons.radio_button_unchecked,
                                  color: Colors.grey[300], size: 20),
                          ],
                        ),
                      ),
                    ).animate().slideX(
                        begin: 0.2,
                        end: 0,
                        delay: (i * 60).ms,
                        duration: 280.ms,
                        curve: Curves.easeOut);
                  },
                ),
              ),

              // ── Feedback + Continue ────────────────────────────────────
              if (_answered)
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      16, 0, 16, isLandscape ? 4 : 10),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: isLandscape ? 8 : 12),
                        decoration: BoxDecoration(
                          color: correct
                              ? const Color(0xFFE8F5E9)
                              : const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: correct
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFF44336),
                            width: 1.5,
                          ),
                          // Glowing green shadow on correct
                          boxShadow: correct
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
                          children: [
                            Text(correct ? '🎉' : '❌',
                                style: TextStyle(
                                    fontSize:
                                        isLandscape ? 18 : 20)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                correct
                                    ? 'ቅኑዕ - Correct!  ${word.tigrigna}  =  ${word.english}'
                                    : 'መልሲ - Answer:  ${word.tigrigna}  (${word.english})',
                                style: TextStyle(
                                  fontFamily: 'AbyssinicaSIL',
                                  color: correct
                                      ? const Color(0xFF2E7D32)
                                      : const Color(0xFFC62828),
                                  fontWeight: FontWeight.bold,
                                  fontSize: isLandscape ? 13 : 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(duration: 250.ms).slideY(
                          begin: 0.2, end: 0),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _next,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: correct
                                ? const Color(0xFF4CAF50)
                                : _accent,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                vertical: isLandscape ? 10 : 14),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(14)),
                            elevation: 2,
                          ),
                          child: Text(
                            correct
                                ? 'ጹቡቕ ቀጽል! - Great, Continue! →'
                                : 'Continue',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ).animate().fadeIn(duration: 250.ms),
                      SizedBox(height: isLandscape ? 4 : 12),
                    ],
                  ),
                )
              else
                const SizedBox(height: 12),
            ],
          ),
        ),

        // ── Confetti cannons — three positions ─────────────────────────────

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