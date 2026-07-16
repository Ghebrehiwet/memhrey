// lib/screens/shared/result_screen.dart
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/quiz_data.dart';
import 'congrats_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int correct;
  final int total;
  final int level;
  final bool passed;

  const ResultScreen({
    super.key,
    required this.score,
    required this.correct,
    required this.total,
    required this.level,
    required this.passed,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 4));
    if (widget.passed) _confetti.play();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _levelColor(widget.level);
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: Stack(
        children: [
          SafeArea(
            // Fixed: this content used to be a plain, non-scrollable Column
            // with mainAxisAlignment.center. Centering can only work when
            // the content fits — it can't shrink a 72px animated percentage,
            // a padded stats card, 3 stars, a status badge, and the buttons
            // if they're taller than the available height. On a landscape
            // viewport (much shorter) or even a moderate portrait screen,
            // that produced a bottom overflow with nowhere to go. This
            // screen is shared across every quiz level (1-4), so the same
            // overflow would show up after finishing any of them, not just
            // this one.
            //
            // Wrapping in SingleChildScrollView + ConstrainedBox(minHeight)
            // keeps the same centered look when content fits the screen,
            // but scrolls instead of overflowing when it doesn't.
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight - 48, // minus the 24+24 vertical padding above
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.passed ? '🎉 ጽቡቕ!' : '😅 ደጋጊምካ ፈትን። ዝፍትን ይዕወት።',
                        style: const TextStyle(fontSize: 48),
                        textAlign: TextAlign.center,
                      ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.withOpacity(0.1), color.withOpacity(0.03)],
                            begin: Alignment.topCenter, end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: color.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: [
                            TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: widget.score),
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeOut,
                              builder: (_, value, __) => Text(
                                '$value%',
                                style: TextStyle(
                                  fontSize: 72, fontWeight: FontWeight.bold,
                                  color: color, height: 1,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text('${widget.correct} / ${widget.total} ቅኑዕ - correct',
                                style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (i) {
                                final earned = i < _starsFromScore(widget.score);
                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: Duration(milliseconds: 400 + i * 200),
                                  curve: Curves.elasticOut,
                                  builder: (_, v, __) => Transform.scale(
                                    scale: v,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Text(earned ? '⭐' : '☆',
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: earned ? Colors.amber : Colors.grey[300])),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: widget.passed ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: widget.passed ? const Color(0xFF4CAF50) : const Color(0xFFFF9800)),
                              ),
                              child: Text(
                                widget.passed
                                    ? (widget.level == 4
                                        ? '🏆 ምስክር ወረቐት ተቐበሉ! - Get Your Certificate!'
                                        : '✅ ደረጃ ${widget.level + 1} ተኸፊቱልኩም ኣሎ! - Level ${widget.level + 1} Unlocked!')
                                    : 'ልዕሊ 80% የድሊ። ልምምድካ ቀጽ! - Need 80% to advance. Keep practicing!',
                                style: TextStyle(
                                  color: widget.passed ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                                  fontWeight: FontWeight.bold, fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ).animate().slideY(begin: 0.3, delay: 200.ms, duration: 600.ms),
                      const SizedBox(height: 32),
                      if (widget.passed && widget.level == 4)
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const CongratsScreen())),
                          icon: const Icon(Icons.emoji_events),
                          label: const Text('ሽልማትኩም ተቐበሉ! - Get Your Certificate!'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                        ).animate().scale(delay: 800.ms, duration: 500.ms, curve: Curves.elasticOut),
                      if (!widget.passed && widget.level == 4) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (_) => QuizScreen(
                                    level: 4,
                                    questions: getQuizQuestions(4)))),
                            icon: const Icon(Icons.refresh),
                            label: const Text('ዕዮ ደጊምኩም ውሰዱ - Retake Quiz', style: TextStyle(fontSize: 16)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E7D32),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text('ናብ መበገሲ ቦታ ተመለሱ - Back to Home', style: TextStyle(fontSize: 16)),
                      ).animate().slideY(begin: 1, delay: 400.ms, duration: 400.ms),
                    ],
                  ),
                ),
              );
            }),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 30,
              colors: const [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }

  int _starsFromScore(int score) {
    if (score >= 95) return 3;
    if (score >= 80) return 2;
    if (score >= 60) return 1;
    return 0;
  }

  Color _levelColor(int level) {
    const colors = [Color(0xFF7C4DFF), Color(0xFF00BCD4), Color(0xFFFF7043), Color(0xFF2E7D32)];
    return colors[(level - 1).clamp(0, 3)];
  }
}