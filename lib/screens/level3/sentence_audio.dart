// lib/screens/level3/sentence_audio.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/sentence.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

class SentenceAudioScreen extends StatefulWidget {
  final Sentence sentence;
  const SentenceAudioScreen({super.key, required this.sentence});

  @override
  State<SentenceAudioScreen> createState() => _SentenceAudioScreenState();
}

class _SentenceAudioScreenState extends State<SentenceAudioScreen> {
  int _listenCount = 0;
  bool _completed  = false;
  static const _required = 2;
  static const _accent   = Color(0xFFFF7043);

  void _onListened() {
    setState(() {
      _listenCount++;
      if (_listenCount >= _required) _completed = true;
    });
  }

  Future<void> _markDone() async {
    await context.read<ProgressProvider>().markSentenceDone(widget.sentence.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final s           = widget.sentence;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('ስማዕ ድገም - Listen & Repeat',
            style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: _accent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isLandscape ? 12 : 24),
        child: Column(children: [
          SizedBox(height: isLandscape ? 6 : 12),

          // ── Sentence card ──────────────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(isLandscape ? 14 : 28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF7043), Color(0xFFE64A19)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: _accent.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: isLandscape
                // Landscape: image left, text right
                ? Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        s.imagePath ?? '',
                        width: 100, height: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Text(s.emoji,
                                style: const TextStyle(fontSize: 52)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.tigrigna,
                              style: const TextStyle(
                                  fontFamily: 'AbyssinicaSIL',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1.4)),
                          const SizedBox(height: 4),
                          Text(s.transliteration,
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic)),
                          Text(s.english,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ])
                // Portrait: stacked
                : Column(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        s.imagePath ?? '',
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) =>
                            Text(s.emoji,
                                style: const TextStyle(fontSize: 80)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(s.tigrigna,
                        style: const TextStyle(
                            fontFamily: 'AbyssinicaSIL',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.5),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    Text(s.transliteration,
                        style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 4),
                    Text(s.english,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center),
                  ]),
          ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),

          SizedBox(height: isLandscape ? 12 : 28),

          // ── Word breakdown ─────────────────────────────────────────────────
          if (s.words.isNotEmpty) ...[
            const Text('ኣብዚ ምሉእ ሓሳብ ዘለው ቃላት - Words in this sentence:',
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.black54),
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: s.words
                  .map((w) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: _accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: _accent.withOpacity(0.4)),
                        ),
                        child: Text(w,
                            style: const TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFBF360C))),
                      ))
                  .toList(),
            ),
            SizedBox(height: isLandscape ? 12 : 20),
          ],

          // ── Listen progress ────────────────────────────────────────────────
          Text('ስማዕ ድገም $_required ግዜ - Listen and repeat $_required times',
              style: TextStyle(
                  color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _required,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: i < _listenCount ? 36 : 14,
                height: 14,
                decoration: BoxDecoration(
                  color: i < _listenCount ? _accent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ),

          SizedBox(height: isLandscape ? 12 : 24),

          // ── Audio button ───────────────────────────────────────────────────
          GestureDetector(
            onTap: _onListened,
            child: AudioBtn(
              ttsText: s.tigrigna,
              audioPath: s.audioPath,
              size: isLandscape ? 56 : 72,
              color: _accent,
            ),
          ),

          SizedBox(height: isLandscape ? 12 : 24),

          // ── Complete button ────────────────────────────────────────────────
          if (_completed)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _markDone,
                icon: const Icon(Icons.check_rounded),
                label: const Text('Mark Complete ✓',
                    style: TextStyle(fontSize: 17)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                      vertical: isLandscape ? 10 : 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ).animate().fadeIn().scale(),

          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}