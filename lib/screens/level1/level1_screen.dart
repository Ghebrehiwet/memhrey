// lib/screens/level1/level1_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart'; 
import 'alphabet_game.dart';
import '../../providers/progress_provider.dart';
import '../../data/alphabet_data.dart';
import '../../data/quiz_data.dart';
import '../../widgets/widgets.dart';
import '../shared/quiz_screen.dart';
import 'alphabet_audio.dart';
import 'alphabet_tracing.dart';
import 'alphabet_matching.dart';
import 'alphabet_word_combo.dart';
import 'reference_alphabets_section.dart';

class Level1Screen extends StatefulWidget {
  const Level1Screen({super.key});

  @override
  State<Level1Screen> createState() => _Level1ScreenState();
}

class _Level1ScreenState extends State<Level1Screen> {
  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F0FF),
      appBar: AppBar(
        title: const Text('ፊደላት - Alphabets', style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(child: Text(
              '${(progress.level1.progressPercent * 100).toInt()}%',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
          ),
        ],
      ),
      // The stats header used to sit outside this ListView, as a fixed
      // sibling in a Column — meaning it permanently occupied screen space
      // above the list no matter how far the user scrolled, "covering a
      // huge chunk of the page" even when they were trying to look at the
      // reference table or the quiz button way down the list. It's now the
      // first item IN the ListView, so it scrolls away with everything
      // else and the full screen height is available once you scroll past
      // it.
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader(progress),
          const SizedBox(height: 8),
          ...List.generate(32, (i) => _AlphabetSetTile(
            setIndex: i,
            set: alphabetSets[i],
          ).animate().slideX(begin: 0.15, delay: (i * 50).ms, duration: 300.ms)),
          const SizedBox(height: 8),
          const ReferenceAlphabetsSection(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: progress.canTakeLevel1Quiz
                ? () => Navigator.push(context, MaterialPageRoute(
                    builder: (_) => QuizScreen(level: 1, questions: getQuizQuestions(1))))
                : null,
            icon: const Icon(Icons.quiz),
            label: Text(
              progress.canTakeLevel1Quiz
                  ? 'ደረጃ 1 ፈተና ውሰድ'
                  : 'ደረጃ 1 ፈተና - ${(progress.level1.progressPercent * 100).toInt()}% / 80% needed',
              style: const TextStyle(fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: progress.canTakeLevel1Quiz
                  ? const Color(0xFF7C4DFF)
                  : Colors.grey[300],
              foregroundColor: progress.canTakeLevel1Quiz
                  ? Colors.white
                  : Colors.grey[600],
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildHeader(ProgressProvider progress) {
    // Note: margin changed from EdgeInsets.all(16) to none — this header now
    // lives inside the ListView's own padding (EdgeInsets.all(16)), which
    // already provides the left/right/top spacing that the old standalone
    // margin duplicated when the header sat outside the list.
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF9C6DFF)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('32 ፊደላት', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Text('6 ንጥፈታት ንነፍሰ ወከፍ ፊደል',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                Text('ልዕሊ 80% ምሉእ ብምሉእ ስራሕ ናብ ዕዮ ንምስጓም',
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Consumer<ProgressProvider>(builder: (_, p, __) =>
            Container(
              constraints: const BoxConstraints(minWidth: 64),
              child: StatBadge(
                icon: Icons.star,
                value: '${p.level1.xpPoints}',
                label: 'XP',
                color: Colors.amber,
              ),
            )),
        ],
      ),
    );
  }
}

class _AlphabetSetTile extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;

  const _AlphabetSetTile({required this.setIndex, required this.set});

  @override
  State<_AlphabetSetTile> createState() => _AlphabetSetTileState();
}

class _AlphabetSetTileState extends State<_AlphabetSetTile> {
  int get setIndex => widget.setIndex;
  AlphabetSet get set => widget.set;

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    final unlocked = progress.isAlphabetSetUnlocked(setIndex);
    final setProgress = progress.getAlphabetSetProgress(setIndex);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: unlocked ? Colors.white : Colors.grey[100],
      child: ExpansionTile(
        leading: Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            color: unlocked ? const Color(0xFF7C4DFF).withValues(alpha: 0.1) : Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Center(child: unlocked
              ? Text(set.letters.first.character,
                  style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 20))
              : const Icon(Icons.lock_outline, color: Colors.grey)),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                set.letters.map((l) => l.character).join(' '),
                style: TextStyle(
                  fontFamily: 'AbyssinicaSIL',
                  fontSize: 16,
                  color: unlocked ? Colors.black87 : Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: setProgress,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation(Color(0xFF7C4DFF)),
                    minHeight: 5,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('${(setProgress * 100).toInt()}%',
                  style: TextStyle(fontSize: 11, color: Colors.grey[600])),
            ],
          ),
        ),
        children: unlocked ? [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                // Letter preview row
                SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: set.letters.map((l) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: EmojiBox(character: l.character, romanization: l.romanization, size: 70),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 12),
                // Activity buttons
                Consumer<ProgressProvider>(
                  builder: (ctx, progress, _) => Wrap(
                    spacing: 8, runSpacing: 8,
                    children: [
                      _activityBtn(ctx, progress, setIndex, 'audio',      '🔊 ስማዕ',       Icons.headphones),
                      _activityBtn(ctx, progress, setIndex, 'sequencing', '🔢 ስራዕ',       Icons.sort),
                      _activityBtn(ctx, progress, setIndex, 'tracing',    '✏️ ወቅጥ',       Icons.edit),
                      _activityBtn(ctx, progress, setIndex, 'matching',   '🎯 ኣዛምድ',      Icons.link),
                      _activityBtn(ctx, progress, setIndex, 'game',       '🎮 ጌም',        Icons.sports_esports),
                      _activityBtn(ctx, progress, setIndex, 'combo',      '📖 ቃልን ስእልን', Icons.table_rows),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] : [],
      ),
    );
  }

  Widget _activityBtn(BuildContext context, ProgressProvider progress,
      int setIndex, String activity, String label, IconData icon) {
    final done = progress.isAlphabetActivityDone(setIndex, activity);
    return ElevatedButton.icon(
      onPressed: () => _navigate(context, setIndex, activity),
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: done ? const Color(0xFF4CAF50) : const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  void _navigate(BuildContext context, int setIndex, String activity) {
    final set = alphabetSets[setIndex];
    Widget screen;
    switch (activity) {
      case 'audio':      screen = AlphabetAudioScreen(setIndex: setIndex, set: set);     break;
      case 'sequencing': screen = AlphabetSequencingScreen(setIndex: setIndex, set: set); break;
      case 'tracing':    screen = AlphabetTracingScreen(setIndex: setIndex, set: set);    break;
      case 'matching':   screen = AlphabetMatchingScreen(setIndex: setIndex, set: set);   break;
      case 'game':       screen = AlphabetGameScreen(setIndex: setIndex, set: set);       break;
      case 'combo':      screen = AlphabetWordComboScreen(setIndex: setIndex, set: set);  break;
      default: return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}