// lib/screens/level3/level3_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/progress_provider.dart';
import '../../data/sentences_data.dart';
import '../../data/quiz_data.dart';
import '../../models/sentence.dart';
import '../../widgets/widgets.dart';
import '../shared/quiz_screen.dart';
import 'sentence_audio.dart';
import 'sentence_image_match.dart';
import 'sentence_reorder.dart';
import 'listening_challenge_screen.dart';

class Level3Screen extends StatefulWidget {
  const Level3Screen({super.key});

  @override
  State<Level3Screen> createState() => _Level3ScreenState();
}

class _Level3ScreenState extends State<Level3Screen> {
  String _search = '';
  int _currentPage = 0;
  static const int _pageSize = 5;

  List<Sentence> _filtered() => sentencesData
      .where((s) =>
          _search.isEmpty ||
          s.tigrigna.contains(_search) ||
          s.english.toLowerCase().contains(_search.toLowerCase()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final progress    = context.watch<ProgressProvider>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final all        = _filtered();
    final totalPages = (all.length / _pageSize).ceil().clamp(1, 999);
    if (_currentPage >= totalPages) _currentPage = 0;
    final start         = _currentPage * _pageSize;
    final end           = (start + _pageSize).clamp(0, all.length);
    final pageSentences = all.sublist(start, end);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text(' ምሉእ ሓሳባት - Sentences',
            style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: const Color(0xFFFF7043),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${(progress.sentenceLevelProgress * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Column(children: [
        // ── Progress bar ─────────────────────────────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 16, vertical: isLandscape ? 4 : 6),
          color: const Color(0xFFFF7043).withOpacity(0.08),
          child: Row(children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress.sentenceLevelProgress,
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      const AlwaysStoppedAnimation(Color(0xFFFF7043)),
                  minHeight: 8,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${sentencesData.where((s) => progress.isSentenceDone(s.id)).length}/${sentencesData.length}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ]),
        ),

        // ── Search bar — tightened padding, always dense ─────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'ምሉእ ሓሳባት ፈትሽ...',
              hintStyle: const TextStyle(fontSize: 13),
              isDense: true,
              prefixIcon: const Icon(Icons.search, size: 20),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (v) => setState(() {
              _search = v;
              _currentPage = 0;
            }),
          ),
        ),

        // ── Quiz + Listening buttons — compact single-line style in both
        // orientations now, instead of tall multi-line cards. This was the
        // biggest fixed-space cost after the sentence list itself.
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 4),
          child: Column(children: [
            if (progress.canTakeLevel3Quiz)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => QuizScreen(
                                level: 3, questions: getQuizQuestions(3)))),
                    icon: const Icon(Icons.quiz_rounded, size: 18),
                    label: const Text('ደረጃ 3 ፈተና ውሰድ 🎯',
                        style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7043),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 9),
                    ),
                  ),
                ),
              ).animate().fadeIn().scale(),
            _listeningChallengeBanner(progress),
          ]),
        ),

        // ── Sentence list ─────────────────────────────────────────────────────
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(
                12, 4, 12, MediaQuery.of(context).viewInsets.bottom + 4),
            itemCount: pageSentences.length,
            itemBuilder: (ctx, i) {
              final sentence = pageSentences[i];
              final globalIndex = start + i;
              final done = progress.isSentenceDone(sentence.id);
              return _SentenceCard(
                sentence: sentence,
                isDone: done,
                index: globalIndex,
              ).animate().fadeIn(delay: (i * 40).ms, duration: 300.ms);
            },
          ),
        ),

        // ── Pagination ────────────────────────────────────────────────────────
        if (totalPages > 1)
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 12, vertical: isLandscape ? 4 : 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 6,
                    offset: const Offset(0, -2))
              ],
            ),
            child: Row(children: [
              _PageBtn(
                icon: Icons.chevron_left,
                label: 'ቅድሚት',
                enabled: _currentPage > 0,
                onTap: () => setState(() => _currentPage--),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalPages, (i) {
                      final active = i == _currentPage;
                      return GestureDetector(
                        onTap: () => setState(() => _currentPage = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin:
                              const EdgeInsets.symmetric(horizontal: 3),
                          width: active ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: active
                                ? const Color(0xFFFF7043)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              _PageBtn(
                icon: Icons.chevron_right,
                label: 'ዝቕጽል',
                enabled: _currentPage < totalPages - 1,
                onTap: () => setState(() => _currentPage++),
                iconRight: true,
              ),
            ]),
          ),
      ]),
    );
  }

  // ── Compact single-row Listening Challenge banner — locked and unlocked
  // states are both a single row now (icon + short text + trailing badge),
  // matching the compact banner pattern used elsewhere, instead of the
  // previous multi-line card with a title, subtitle, and separate badge.
  Widget _listeningChallengeBanner(ProgressProvider progress) {
    final unlocked = progress.canPlayListeningChallenge;
    final pct = (progress.sentenceLevelProgress * 100).toInt();

    if (unlocked) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(
                  builder: (_) => const ListeningChallengeScreen())),
          icon: const Icon(Icons.hearing_rounded, size: 18),
          label: const Text('👂 ምስማዕ ምጽዋት - Listening Challenge',
              style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 13)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5D4037),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 9),
          ),
        ),
      ).animate().fadeIn().scale();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(children: [
        const Icon(Icons.lock_rounded, color: Colors.grey, size: 16),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '👂 ምስማዕ ምጽዋት - Listening Challenge',
            style: TextStyle(
                fontFamily: 'AbyssinicaSIL',
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
                fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '$pct% / 80%',
            style: TextStyle(
                fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.bold),
          ),
        ),
      ]),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  final bool iconRight;

  const _PageBtn({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
    this.iconRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final color     = enabled ? const Color(0xFFFF7043) : Colors.grey[300]!;
    final textColor = enabled ? const Color(0xFFFF7043) : Colors.grey[400]!;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 1.5),
          borderRadius: BorderRadius.circular(20),
          color: enabled
              ? const Color(0xFFFF7043).withOpacity(0.06)
              : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: iconRight
              ? [
                  Text(label,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  Icon(icon, color: color, size: 18)
                ]
              : [
                  Icon(icon, color: color, size: 18),
                  Text(label,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600))
                ],
        ),
      ),
    );
  }
}

class _SentenceCard extends StatelessWidget {
  final Sentence sentence;
  final bool isDone;
  final int index;

  const _SentenceCard({
    required this.sentence,
    required this.isDone,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showMenu(context),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: isDone
                    ? const Color(0xFF4CAF50).withOpacity(0.15)
                    : const Color(0xFFFF7043).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isDone
                    ? const Icon(Icons.check_rounded,
                        color: Color(0xFF4CAF50), size: 20)
                    : Text('${index + 1}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF7043))),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sentence.tigrigna,
                      style: const TextStyle(
                          fontFamily: 'AbyssinicaSIL',
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(sentence.transliteration,
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: 11)),
                  Text(sentence.english,
                      style: TextStyle(
                          color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            AudioBtn(
              ttsText: sentence.tigrigna,
              audioPath: sentence.audioPath,
              size: 36,
              color: const Color(0xFFFF7043),
            ),
          ]),
        ),
      ),
    );
  }

  // Fixed: previously used DraggableScrollableSheet(initialChildSize: 0.45),
  // which deliberately opened at only 45% of screen height regardless of
  // how much content there was — forcing a swipe-up to see the 3rd activity
  // option every single time. Switched to the same self-sizing pattern used
  // for the word activity sheet: a plain Container + SingleChildScrollView
  // with mainAxisSize.min. This shows the full content (header + all 3
  // activities) immediately; it only becomes scrollable as a fallback if
  // the content genuinely doesn't fit the screen (e.g. a very short
  // landscape viewport), never as the default interaction.
  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(height: 16),
                Text(sentence.tigrigna,
                    style: const TextStyle(
                        fontFamily: 'AbyssinicaSIL',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text(sentence.english,
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: 14),
                    textAlign: TextAlign.center),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.headphones_rounded,
                      color: Color(0xFFFF7043)),
                  title:
                      const Text('ስማዕ ድገም - Listen & Repeat'),
                  subtitle: const Text('ልምምድ ብምስማዕ ድምጺ'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SentenceAudioScreen(
                                sentence: sentence)));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.link_rounded,
                      color: Color(0xFFFF7043)),
                  title: const Text(
                      'ስእሊ ኣዛምድ - Image Match'),
                  subtitle:
                      const Text('ምሉእ ሓሳብ ምስ ትርእዮ ኣመዓራርዮ'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                SentenceImageMatchScreen(
                                    sentence: sentence)));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.reorder_rounded,
                      color: Color(0xFFFF7043)),
                  title: const Text(
                      'ቃላት ኣማዓራሪ - Reorder Words'),
                  subtitle:
                      const Text('ቃላት ብቕኑዕ ቅደም ተኸተል ስራዕ'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                SentenceReorderScreen(
                                    sentence: sentence)));
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}