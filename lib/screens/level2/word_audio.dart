// lib/screens/level2/word_audio.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/word.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';
 
class WordAudioScreen extends StatefulWidget {
  final Word word;
  const WordAudioScreen({super.key, required this.word});
 
  @override
  State<WordAudioScreen> createState() => _WordAudioScreenState();
}
 
class _WordAudioScreenState extends State<WordAudioScreen> {
  bool _completed = false;
  int  _repeatCount = 0;
  static const _requiredRepeats = 3;
  static const _accent = Color(0xFF00BCD4);
 
  void _onListened() {
    setState(() {
      _repeatCount++;
      if (_repeatCount >= _requiredRepeats) _completed = true;
    });
  }
 
  Future<void> _markDone() async {
    await context.read<ProgressProvider>().markWordDone(widget.word.id);
    if (mounted) Navigator.pop(context);
  }
 
  @override
  Widget build(BuildContext context) {
    final word        = widget.word;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
 
    return Scaffold(
      backgroundColor: const Color(0xFFF0FCFF),
      appBar: AppBar(
        title: const Text('ሰሚዕካ ድገም - Listen & Repeat',
            style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: _accent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isLandscape ? 12 : 24),
        child: Column(
          children: [
            SizedBox(height: isLandscape ? 8 : 20),
 
            // ── Word display card ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isLandscape ? 14 : 32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                      color: _accent.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8)),
                ],
              ),
              child: isLandscape
                  // ── Landscape: horizontal layout ─────────────────────────
                  ? Row(
                      children: [
                        Container(
                          width: 72, height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(word.emoji,
                                style: const TextStyle(fontSize: 44)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(word.tigrigna,
                                  style: const TextStyle(
                                      fontFamily: 'AbyssinicaSIL',
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(word.transliteration,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 14)),
                              Text(word.english,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ],
                    )
                  // ── Portrait: vertical layout ─────────────────────────────
                  : Column(
                      children: [
                        Container(
                          width: 120, height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(word.emoji,
                                style: const TextStyle(fontSize: 72)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(word.tigrigna,
                            style: const TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(word.transliteration,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 18)),
                        const SizedBox(height: 4),
                        Text(word.english,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
            ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),
 
            SizedBox(height: isLandscape ? 12 : 32),
 
            // ── Instructions ──────────────────────────────────────────────
            Text(
              'ነቲ መጉልሒ ድምጺ ጠዊቕካ ነታ ቃል $_requiredRepeats ግዜ ድገም - Tap the speaker and repeat the word ${_requiredRepeats}x',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: isLandscape ? 12 : 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isLandscape ? 8 : 16),
 
            // ── Progress dots ─────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _requiredRepeats,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width:  i < _repeatCount ? 32 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: i < _repeatCount ? _accent : Colors.grey[300],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
            SizedBox(height: isLandscape ? 12 : 32),
 
            // ── Audio button ──────────────────────────────────────────────
            GestureDetector(
              onTap: _onListened,
              child: AudioBtn(
                ttsText: word.tigrigna,
                audioPath: word.audioPath,
                size: isLandscape ? 56 : 80,
                color: _accent,
              ).animate(onPlay: (c) => c.repeat(reverse: true))
                  .scaleXY(begin: 1.0, end: 1.05, duration: 800.ms),
            ),
 
            SizedBox(height: isLandscape ? 12 : 24),
 
            // ── Complete button ───────────────────────────────────────────
            if (_completed)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _markDone,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Mark Complete ✓',
                      style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: isLandscape ? 10 : 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms).scale(),
 
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}