// lib/screens/level4/level4_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/progress_provider.dart';
import '../../data/paragraphs_data.dart';
import '../../data/quiz_data.dart';
import '../../models/paragraph.dart';
import '../../models/question.dart';
import '../../widgets/widgets.dart';
import '../shared/quiz_screen.dart';
import '../shared/congrats_screen.dart';

class Level4Screen extends StatefulWidget {
  const Level4Screen({super.key});

  @override
  State<Level4Screen> createState() => _Level4ScreenState();
}

class _Level4ScreenState extends State<Level4Screen> {
  String _search = '';
  final _searchCtrl = TextEditingController();
  bool _easyExpanded   = true;
  bool _mediumExpanded = false;
  bool _hardExpanded   = false;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Paragraph> _filtered(ParagraphDifficulty diff) {
    final group = paragraphsData.where((p) => p.difficulty == diff).toList();
    if (_search.isEmpty) return group;
    final q = _search.toLowerCase();
    return group.where((p) =>
        p.title.toLowerCase().contains(q) ||
        p.tigrigna.contains(_search) ||
        p.english.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressProvider>();
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        title: const Text('ሕጡበ ጽሑፋት - Paragraphs',
            style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        actions: [
          // In landscape show compact progress chips in the AppBar
          if (isLandscape) ...[
            _AppBarProgressChip(label: '🟢', value: progress.easyProgress, color: Colors.green),
            _AppBarProgressChip(label: '🟡', value: progress.mediumProgress, color: Colors.orange, locked: !progress.mediumUnlocked),
            _AppBarProgressChip(label: '🔴', value: progress.hardProgress, color: Colors.red, locked: !progress.hardUnlocked),
            const SizedBox(width: 4),
          ],
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${(progress.paragraphLevelProgress * 100).toInt()}%',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Progress bars: portrait only ────────────────────────────────
          if (!isLandscape)
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF2E7D32).withOpacity(0.08),
              child: Column(children: [
                _DifficultyBar(label: '🟢 ቀሊል - Easy', progress: progress.easyProgress, color: Colors.green, unlocked: true),
                const SizedBox(height: 6),
                _DifficultyBar(label: '🟡 ማእከላይ - Medium', progress: progress.mediumProgress, color: Colors.orange, unlocked: progress.mediumUnlocked, lockMsg: 'Finish 80% of Easy to unlock'),
                const SizedBox(height: 6),
                _DifficultyBar(label: '🔴 ብርቱዕ - Hard', progress: progress.hardProgress, color: Colors.red, unlocked: progress.hardUnlocked, lockMsg: 'Finish 80% of Medium to unlock'),
              ]),
            ),

          // ── Action buttons ───────────────────────────────────────────────
          if (isLandscape && (progress.level4.isCompleted || progress.canTakeLevel4Quiz))
            // Landscape: compact single-row chips
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 0),
              child: Row(children: [
                if (progress.level4.isCompleted)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CongratsScreen())),
                      icon: const Icon(Icons.emoji_events, size: 16),
                      label: const Text('🏆 Certificate', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(vertical: 8)),
                    ),
                  ),
                if (progress.level4.isCompleted && progress.canTakeLevel4Quiz) const SizedBox(width: 8),
                if (progress.canTakeLevel4Quiz)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(level: 4, questions: getQuizQuestions(4)))),
                      icon: const Icon(Icons.quiz, size: 16),
                      label: Text(progress.level4.isCompleted ? 'Retake Quiz' : 'Take Final Quiz 🏆', style: const TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), padding: const EdgeInsets.symmetric(vertical: 8)),
                    ),
                  ),
              ]),
            ),

          if (!isLandscape) ...[
            if (progress.level4.isCompleted)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CongratsScreen())),
                    icon: const Icon(Icons.emoji_events),
                    label: const Text('🏆 ውጽኢትን ምስክር ወረቐትን - View Certificate & Results', style: TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
              ).animate().fadeIn().scale(),

            if (progress.canTakeLevel4Quiz)
              Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(level: 4, questions: getQuizQuestions(4)))),
                    icon: const Icon(Icons.emoji_events),
                    label: Text(progress.level4.isCompleted ? 'ናይ መወዳእታ ፈተና ውሰድ - Retake Final Quiz' : 'ናይ መወዳእታ ፈተና ወሲድካ ምስክር ተቐበል - Take Final Quiz & Get Certificate! 🏆', style: const TextStyle(fontSize: 14)),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)), padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                ),
              ).animate().fadeIn().scale(),
          ],

          // ── Search bar ───────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(12, isLandscape ? 6 : 8, 12, 4),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'ጽሑፍ ድለ... Search paragraphs...',
                hintStyle: const TextStyle(fontSize: 13),
                prefixIcon: const Icon(Icons.search, size: 20),
                suffixIcon: _search.isNotEmpty ? IconButton(icon: const Icon(Icons.clear, size: 18), onPressed: () { _searchCtrl.clear(); setState(() => _search = ''); }) : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                filled: true, fillColor: Colors.white,
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),

          // ── Paragraph list ───────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
              children: [
                _difficultySection(context, progress, emoji: '🟢', label: 'ቀሊል - Easy', diff: ParagraphDifficulty.easy, color: Colors.green, unlocked: true, expanded: _easyExpanded, onToggle: () => setState(() => _easyExpanded = !_easyExpanded), isLandscape: isLandscape),
                _difficultySection(context, progress, emoji: '🟡', label: 'ማእከላይ - Medium', diff: ParagraphDifficulty.medium, color: Colors.orange, unlocked: progress.mediumUnlocked, expanded: _mediumExpanded, onToggle: () => setState(() => _mediumExpanded = !_mediumExpanded), isLandscape: isLandscape),
                _difficultySection(context, progress, emoji: '🔴', label: 'ብርቱዕ - Hard', diff: ParagraphDifficulty.hard, color: Colors.red, unlocked: progress.hardUnlocked, expanded: _hardExpanded, onToggle: () => setState(() => _hardExpanded = !_hardExpanded), isLandscape: isLandscape),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _difficultySection(BuildContext context, ProgressProvider progress, {required String emoji, required String label, required ParagraphDifficulty diff, required Color color, required bool unlocked, required bool expanded, required VoidCallback onToggle, required bool isLandscape}) {
    final allParas = paragraphsData.where((p) => p.difficulty == diff).toList();
    final filtered = _filtered(diff);
    final doneCount = allParas.where((p) => progress.isParagraphDone(p.id)).length;
    final total = allParas.length;
    final showExpanded = expanded || _search.isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: unlocked ? color.withOpacity(0.35) : Colors.grey[300]!, width: 1.5),
        boxShadow: [BoxShadow(color: (unlocked ? color : Colors.grey).withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(children: [
        InkWell(
          onTap: unlocked ? onToggle : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: isLandscape ? 8 : 12),
            decoration: BoxDecoration(
              color: unlocked ? color.withOpacity(0.08) : Colors.grey[50],
              borderRadius: BorderRadius.only(topLeft: const Radius.circular(16), topRight: const Radius.circular(16), bottomLeft: Radius.circular(showExpanded ? 0 : 16), bottomRight: Radius.circular(showExpanded ? 0 : 16)),
            ),
            child: Row(children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              if (!unlocked) const Icon(Icons.lock, size: 14, color: Colors.grey),
              if (!unlocked) const SizedBox(width: 4),
              Expanded(child: Text(label, style: TextStyle(fontFamily: 'AbyssinicaSIL', fontWeight: FontWeight.bold, fontSize: 15, color: unlocked ? color.withAlpha(210) : Colors.grey))),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: unlocked ? color.withOpacity(0.15) : Colors.grey[200], borderRadius: BorderRadius.circular(20)), child: Text('$doneCount/$total', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: unlocked ? color : Colors.grey))),
              if (!isLandscape) ...[
                const SizedBox(width: 8),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(20)), child: Text('$total paragraphs', style: TextStyle(fontSize: 10, color: Colors.grey[600]))),
              ],
              const SizedBox(width: 6),
              if (unlocked) AnimatedRotation(turns: showExpanded ? 0.5 : 0, duration: const Duration(milliseconds: 250), child: Icon(Icons.keyboard_arrow_down, color: color, size: 22)),
            ]),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: !unlocked
              ? Padding(padding: const EdgeInsets.all(14), child: Row(children: [Icon(Icons.lock_outline, size: 14, color: Colors.grey[400]), const SizedBox(width: 6), Text(diff == ParagraphDifficulty.medium ? 'Finish 80% of Easy to unlock' : 'Finish 80% of Medium to unlock', style: TextStyle(color: Colors.grey[500], fontSize: 12))]))
              : filtered.isEmpty
                  ? Padding(padding: const EdgeInsets.all(16), child: Center(child: Text('No paragraphs match "$_search"', style: TextStyle(color: Colors.grey[500], fontSize: 13))))
                  : Column(children: [
                      const Divider(height: 1),
                      ...filtered.asMap().entries.map((e) => isLandscape
                          ? _ParagraphTitleRow(paragraph: e.value, isDone: progress.isParagraphDone(e.value.id), index: e.key)
                              .animate().fadeIn(delay: (e.key * 30).ms, duration: 200.ms)
                          : _ParagraphCard(paragraph: e.value, isDone: progress.isParagraphDone(e.value.id), index: e.key)
                              .animate().fadeIn(delay: (e.key * 40).ms, duration: 250.ms)),
                    ]),
          crossFadeState: showExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ]),
    );
  }
}

// ─── AppBar Progress Chip (landscape only) ───────────────────────────────────

class _AppBarProgressChip extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  final bool locked;
  const _AppBarProgressChip({required this.label, required this.value, required this.color, this.locked = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 4),
          Text(
            locked ? '🔒' : '${(value * 100).toInt()}%',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: locked ? Colors.grey[300] : Colors.white),
          ),
        ]),
      ),
    );
  }
}

// ─── Compact title-only row for landscape ─────────────────────────────────────

class _ParagraphTitleRow extends StatelessWidget {
  final Paragraph paragraph;
  final bool isDone;
  final int index;
  const _ParagraphTitleRow({required this.paragraph, required this.isDone, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _ParagraphReadScreen(paragraph: paragraph))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFF4CAF50).withOpacity(0.15) : const Color(0xFF2E7D32).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isDone
                  ? const Icon(Icons.check, color: Color(0xFF4CAF50), size: 16)
                  : Text('${index + 1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
            ),
          ),
          const SizedBox(width: 10),
          Text(_paragraphEmoji(paragraph.id), style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              paragraph.title,
              style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 15, fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.quiz_outlined, size: 11, color: Color(0xFF2E7D32)),
              const SizedBox(width: 3),
              Text('${paragraph.comprehensionQuestionIds.length}', style: const TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.w500)),
            ]),
          ),
          const SizedBox(width: 6),
          AudioBtn(ttsText: paragraph.tigrigna, audioPath: paragraph.audioPath, size: 28, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ]),
      ),
    );
  }
}

// ─── Paragraph Emoji Map ──────────────────────────────────────────────────────

String _paragraphEmoji(String id) {
  const map = {
    'p001': '👨‍👩‍👧‍👦',
    'p002': '🏫',
    'p003': '🇪🇷',
    'p004': '🥛',
    'p005': '✏️',
    'p006': '💧',
    'p007': '🎨',
    'p008': '🦁',
    'p009': '📖',
    'p010': '🏙️',
    'p011': '🌾',
    'p012': '🌤️',
    'p013': '🐜',
    'p014': '🐘',
    'p015': '🐪',
    'p016': '🐎',
    'p017': '🐕',
    'p018': '⭐',
    'p019': '☕',
    'p020': '🚂',
    'p021': '🚗',
    'p022': '🌺',
    'p023': '📚',
    'p024': '📻',
    'p025': '🌊',
    'p026': '🖥️',
    'p027': '🐔',
    'p028': '☁️',
    'p029': '📚',
    'p030': '🌙',
    'p031': '👨‍👩‍👧‍👦',
    'p032': '🐘',
    'p033': '🐱',
    'p034': '🌸',
    'p035': '🎒',
    'p036': '☀️',
    'p037': '🍳',
    'p038': '🌧️',
    'p039': '👨‍👩‍👧‍👦',
    'p040': '🌳',
  };
  return map[id] ?? '📖';
}

// ─── Paragraph Card ───────────────────────────────────────────────────────────

class _ParagraphCard extends StatelessWidget {
  final Paragraph paragraph;
  final bool isDone;
  final int index;
  const _ParagraphCard({required this.paragraph, required this.isDone, required this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _ParagraphReadScreen(paragraph: paragraph))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero image / emoji banner ──────────────────────────────────
            _ParagraphHero(
              paragraph: paragraph,
              height: 120,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(color: isDone ? const Color(0xFF4CAF50).withOpacity(0.15) : const Color(0xFF2E7D32).withOpacity(0.1), shape: BoxShape.circle),
                    child: Center(child: isDone ? const Icon(Icons.check, color: Color(0xFF4CAF50)) : Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(paragraph.title, style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 20, fontWeight: FontWeight.bold))),
                  AudioBtn(ttsText: paragraph.tigrigna, audioPath: paragraph.audioPath, size: 36, color: const Color(0xFF2E7D32)),
                ]),
                const SizedBox(height: 10),
                Text(paragraph.tigrigna, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 15, height: 1.6, color: Color(0xFF1B5E20))),
                const SizedBox(height: 6),
                Text(paragraph.english, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[500], fontSize: 12, fontStyle: FontStyle.italic)),
                const SizedBox(height: 10),
                Row(children: [
                  const Icon(Icons.quiz_outlined, size: 14, color: Color(0xFF2E7D32)),
                  const SizedBox(width: 4),
                  Text('${paragraph.comprehensionQuestionIds.length} comprehension questions', style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 12, fontWeight: FontWeight.w500)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Paragraph Hero Widget ────────────────────────────────────────────────────

class _ParagraphHero extends StatelessWidget {
  final Paragraph paragraph;
  final double height;
  final BorderRadius borderRadius;

  const _ParagraphHero({
    required this.paragraph,
    this.height = 180,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  @override
  Widget build(BuildContext context) {
    // Fixed: this used to clamp height to a fraction of SCREEN height
    // (screenHeight * 0.25). In landscape, screen height is short, so that
    // clamp forced the banner down to a tiny height while its width stayed
    // very wide — BoxFit.cover then had to crop away most of the image to
    // fill that extreme wide/short aspect ratio, cutting off content.
    // Height is now just clamped to a fixed, orientation-independent range;
    // callers control the actual height explicitly for their layout
    // context instead of it silently shrinking based on screen dimensions.
    final clampedHeight = height.clamp(60.0, 220.0);

    // If a real image path is provided, try to load it
    if (paragraph.imagePath != null) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          paragraph.imagePath!,
          width: double.infinity,
          height: clampedHeight,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildEmojiBanner(context, clampedHeight),
        ),
      );
    }
    return _buildEmojiBanner(context, clampedHeight);
  }

  Widget _buildEmojiBanner(BuildContext context, double resolvedHeight) {
    final emoji = _paragraphEmoji(paragraph.id);
    return ClipRRect(
      borderRadius: borderRadius,
      child: Container(
        width: double.infinity,
        height: resolvedHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF2E7D32).withOpacity(0.12),
              const Color(0xFF81C784).withOpacity(0.18),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background circles
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2E7D32).withOpacity(0.06),
                ),
              ),
            ),
            Positioned(
              left: -10,
              bottom: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2E7D32).withOpacity(0.06),
                ),
              ),
            ),
            // Emoji centered — scale font size with resolved height
            Center(
              child: Text(
                emoji,
                style: TextStyle(fontSize: resolvedHeight * 0.42),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Paragraph Reading Screen ─────────────────────────────────────────────────

class _ParagraphReadScreen extends StatefulWidget {
  final Paragraph paragraph;
  const _ParagraphReadScreen({required this.paragraph});
  @override
  State<_ParagraphReadScreen> createState() => _ParagraphReadScreenState();
}

class _ParagraphReadScreenState extends State<_ParagraphReadScreen> {
  int _questionIndex = 0;
  int _correct = 0;
  String? _selectedAnswer;
  bool _answered = false;
  bool _quizMode = false;
  late List<Question> _questions;
  List<String> _orderingItems = [];
  final Map<String, String?> _wordMatchSelections = {};
  String? _wordMatchTapped;
  final Map<int, String?> _fillBankSelections = {};

  @override
  void initState() {
    super.initState();
    _questions = allQuizQuestions.where((q) => widget.paragraph.comprehensionQuestionIds.contains(q.id)).toList();
  }

  void _initOrdering(Question q) {
    if (_orderingItems.isEmpty) _orderingItems = List<String>.from(q.options)..shuffle();
  }

  void _startQuiz() => setState(() => _quizMode = true);

  void _selectAnswer(String answer) {
    if (_answered) return;
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (answer == _questions[_questionIndex].correctAnswer) _correct++;
    });
  }

  void _checkOrdering() {
    if (_answered) return;
    final answer = _orderingItems.join('|');
    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (answer == _questions[_questionIndex].correctAnswer) _correct++;
    });
  }

  void _next() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
        _selectedAnswer = null;
        _answered = false;
        _orderingItems = [];
        _wordMatchSelections.clear();
        _wordMatchTapped = null;
        _fillBankSelections.clear();
      });
    } else {
      _finishComprehension();
    }
  }

  Future<void> _finishComprehension() async {
    final passed = _correct >= (_questions.length * 0.5).ceil();
    if (passed) await context.read<ProgressProvider>().markParagraphDone(widget.paragraph.id);
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(passed ? '🎉 Well Done!' : '😔 Not Quite', textAlign: TextAlign.center, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text('$_correct / ${_questions.length} correct', style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(
            passed ? (_correct == _questions.length ? 'ጽቡቕ ነጥቢ! ዝድነቕ ኢዩ! - Perfect score!' : 'ጽቡቕ! ምንባብ ቀጽሉ - Good job! Keep reading!') : 'ነዚ ሕጡበ-ጽሑፍ ንምምላእ እንተወሓደ 50% የድልየኩም። - You need at least 50% to complete this paragraph. Try again!',
            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600]),
          ),
        ]),
        actions: [
          if (!passed)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() { _questionIndex = 0; _correct = 0; _selectedAnswer = null; _answered = false; _orderingItems = []; _wordMatchSelections.clear(); _wordMatchTapped = null; _fillBankSelections.clear(); _quizMode = true; });
                },
                icon: const Icon(Icons.refresh), label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () { Navigator.of(context).pop(); Navigator.of(context).pop(); },
              style: ElevatedButton.styleFrom(backgroundColor: passed ? const Color(0xFF2E7D32) : Colors.grey[400], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: Text(passed ? 'ናብ ሕጡበ ጽሑፋት ተመለሱ - Back to Paragraphs' : 'ተመለሱ ስራሕ ኣይተወደአን - Back (Not Completed)'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(title: Text(widget.paragraph.title, style: const TextStyle(fontFamily: 'AbyssinicaSIL')), backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white),
      body: _quizMode ? _buildQuiz() : _buildReading(),
    );
  }

  // Fixed: previously a single stacked layout was used in both
  // orientations, with the hero's height clamped to a fraction of screen
  // height — extremely cropping the image in landscape's short viewport.
  // Landscape now uses a side-by-side layout: hero + title + audio on a
  // fixed-width left column (with a sane, orientation-independent hero
  // height), paragraph text + translation + quiz button scrollable on the
  // right. Portrait is unchanged.
  Widget _buildReading() {
    final p = widget.paragraph;
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final startQuizButton = SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _questions.isEmpty ? null : _startQuiz,
        icon: const Icon(Icons.quiz),
        label: Text('Answer ${_questions.length} Comprehension Questions'),
        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      ),
    );

    final tigrignaCard = Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.green.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Text(p.tigrigna, style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 20, height: 2.0, color: Color(0xFF1B5E20))),
    ).animate().fadeIn(duration: 400.ms);

    if (isLandscape) {
      return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(
          width: 230,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              _ParagraphHero(
                paragraph: p,
                height: 150,
                borderRadius: BorderRadius.circular(16),
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: Text(p.title, style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)))),
              ]),
              const SizedBox(height: 6),
              AudioBtn(ttsText: p.tigrigna, audioPath: p.audioPath, size: 40, color: const Color(0xFF2E7D32)),
            ]),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 16, 20, 16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              tigrignaCard,
              const SizedBox(height: 12),
              _ExpandableTranslation(english: p.english),
              const SizedBox(height: 20),
              startQuizButton,
            ]),
          ),
        ),
      ]);
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Hero Image / Emoji Banner ──────────────────────────────────────
        _ParagraphHero(
          paragraph: p,
          height: 180,
          borderRadius: BorderRadius.circular(16),
        ).animate().fadeIn(duration: 400.ms),

        const SizedBox(height: 16),

        // ── Title + Audio ──────────────────────────────────────────────────
        Row(children: [
          Expanded(child: Text(p.title, style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)))),
          AudioBtn(ttsText: p.tigrigna, audioPath: p.audioPath, size: 46, color: const Color(0xFF2E7D32)),
        ]),

        const SizedBox(height: 16),

        // ── Tigrigna Text ──────────────────────────────────────────────────
        tigrignaCard,

        const SizedBox(height: 16),

        _ExpandableTranslation(english: p.english),

        const SizedBox(height: 28),

        startQuizButton,
      ]),
    );
  }

  // Fixed: previously a single stacked Column was used in both
  // orientations — question card (padding + up to a few lines of text)
  // stacked ABOVE the options. In landscape's short viewport that pushed
  // the options down to almost nothing, leaving only 1-2 visible. Landscape
  // now uses a side-by-side layout: header + question card fixed-width on
  // the left, answer area gets the full available height on the right —
  // same pattern applied to the other activity screens. Portrait is
  // unchanged.
  Widget _buildQuiz() {
    if (_questions.isEmpty) return const Center(child: Text('No questions available.'));
    final q = _questions[_questionIndex];
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final header = Column(children: [
      Row(children: [
        Text('Question ${_questionIndex + 1}/${_questions.length}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
        const Spacer(),
        Text('$_correct correct', style: const TextStyle(color: Colors.grey)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(borderRadius: BorderRadius.circular(6), child: LinearProgressIndicator(value: (_questionIndex + 1) / _questions.length, backgroundColor: Colors.grey[200], valueColor: const AlwaysStoppedAnimation(Color(0xFF2E7D32)), minHeight: 8)),
    ]);

    Widget questionCard({required bool compact}) => Container(
      width: double.infinity, padding: EdgeInsets.all(compact ? 12 : 16),
      decoration: BoxDecoration(color: const Color(0xFF2E7D32).withOpacity(0.08), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF2E7D32).withOpacity(0.3))),
      child: Text(q.prompt.split('§').first, style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: compact ? 15 : 18, fontWeight: FontWeight.w600, height: 1.5), textAlign: TextAlign.center),
    ).animate().fadeIn(duration: 300.ms);

    Widget answerArea() {
      if (q.type == QuestionType.ordering) return _buildOrderingWidget(q);
      if (q.type == QuestionType.wordMatch) return _buildWordMatchWidget(q);
      if (q.type == QuestionType.fillBank) return _buildFillBankWidget(q);
      return Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: q.options.asMap().entries.map((e) {
                final isSelected = _selectedAnswer == e.value;
                final isCorrect = e.value == q.correctAnswer;
                return OptionTile(
                  text: e.value,
                  index: e.key,
                  isSelected: isSelected,
                  isCorrect: _answered ? (isSelected ? isCorrect : null) : null,
                  onTap: () => _selectAnswer(e.value),
                ).animate().slideX(begin: 0.3, end: 0, delay: (e.key * 60).ms, duration: 300.ms);
              }).toList(),
            ),
          ),
        ),
        if (_answered) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: Text(_questionIndex < _questions.length - 1 ? 'ዝስዕብ ሕቶ - Next Question →' : 'ወድእ - Finish ✓', style: const TextStyle(fontSize: 16)),
            ),
          ).animate().fadeIn(duration: 300.ms),
        ],
      ]);
    }

    if (isLandscape) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SizedBox(
            width: 260,
            child: SingleChildScrollView(
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                header,
                const SizedBox(height: 10),
                questionCard(compact: true),
              ]),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(child: answerArea()),
        ]),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        header,
        const SizedBox(height: 16),
        questionCard(compact: false),
        const SizedBox(height: 16),
        Expanded(child: answerArea()),
      ]),
    );
  }

  // ─── Fill Bank Widget ────────────────────────────────────────────────────────

  Widget _buildFillBankWidget(Question q) {
    final answers = q.correctAnswer.split('|');
    final bank = List<String>.from(q.options);
    final used = _fillBankSelections.values.whereType<String>().toSet();
    final allFilled = answers.asMap().keys.every((i) => _fillBankSelections[i] != null);

    final sentences = q.prompt.contains('§')
        ? q.prompt.split('§').skip(1).toList()
        : List.generate(answers.length, (_) => '___');

    void checkFillBank() {
      if (_answered) return;
      int correct = 0;
      for (int i = 0; i < answers.length; i++) {
        if (_fillBankSelections[i] == answers[i]) correct++;
      }
      setState(() {
        _selectedAnswer = List.generate(answers.length, (i) => _fillBankSelections[i] ?? '').join('|');
        _answered = true;
        if (correct == answers.length) _correct++;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_answered)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text('ካብ ዝርዝር ቃላት ምረጽ - Choose from the word bank', style: TextStyle(color: Colors.grey[500], fontSize: 12), textAlign: TextAlign.center),
          ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...sentences.asMap().entries.map((entry) {
                final i = entry.key;
                final sentence = entry.value;
                final selected = _fillBankSelections[i];
                final correct = i < answers.length ? answers[i] : '';
                final parts = sentence.split('___');

                Color slotBg = Colors.grey[100]!;
                Color slotBorder = Colors.grey[300]!;
                if (selected != null && !_answered) { slotBg = const Color(0xFF2E7D32).withOpacity(0.08); slotBorder = const Color(0xFF2E7D32); }
                if (_answered) { slotBg = selected == correct ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1); slotBorder = selected == correct ? Colors.green : Colors.red; }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Container(
                        width: 22, height: 22,
                        decoration: BoxDecoration(color: const Color(0xFF2E7D32).withOpacity(0.1), shape: BoxShape.circle),
                        child: Center(child: Text('${i + 1}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)))),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 4, runSpacing: 6,
                              children: [
                                if (parts.isNotEmpty && parts[0].trim().isNotEmpty)
                                  Text(parts[0].trim(), style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 14, height: 1.6)),
                                GestureDetector(
                                  onTap: (!_answered && selected != null) ? () => setState(() => _fillBankSelections.remove(i)) : null,
                                  child: Container(
                                    constraints: const BoxConstraints(minWidth: 80),
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: slotBg, borderRadius: BorderRadius.circular(8), border: Border.all(color: slotBorder, width: 1.5)),
                                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                                      Text(selected ?? '  ____  ', style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 13, color: selected != null ? Colors.black87 : Colors.grey[400], fontWeight: selected != null ? FontWeight.bold : FontWeight.normal)),
                                      if (_answered) Padding(padding: const EdgeInsets.only(left: 4), child: Icon(selected == correct ? Icons.check_circle : Icons.cancel, color: selected == correct ? Colors.green : Colors.red, size: 14)),
                                      if (!_answered && selected != null) const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.close, size: 12, color: Colors.grey)),
                                    ]),
                                  ),
                                ),
                                if (parts.length > 1 && parts[1].trim().isNotEmpty)
                                  Text(parts[1].trim(), style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 14, height: 1.6)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                );
                }),
                // Fixed: this word-bank pool used to be a fixed sibling
                // BELOW this Expanded/scrollable region — fixed children in
                // a Column always get their full natural size regardless of
                // available space, so a question with many bank words had
                // nowhere for the excess height to go, producing overflow
                // and pushing the pool (the actual tappable answers) off
                // screen entirely. Moving it inside the same scroll area
                // means it scrolls together with the sentence list instead.
                if (!_answered) ...[
                  const Divider(height: 16),
                  Wrap(
                    spacing: 8, runSpacing: 8, alignment: WrapAlignment.center,
                    children: bank.map((word) {
                      final isUsed = used.contains(word);
                      return GestureDetector(
                        onTap: isUsed ? null : () {
                          final empty = List.generate(answers.length, (i) => i).firstWhere((i) => _fillBankSelections[i] == null, orElse: () => -1);
                          if (empty != -1) setState(() => _fillBankSelections[empty] = word);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isUsed ? Colors.grey[100] : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isUsed ? Colors.grey[300]! : const Color(0xFF2E7D32), width: isUsed ? 1 : 1.5),
                          ),
                          child: Text(word, style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 14, color: isUsed ? Colors.grey[400] : Colors.black87, decoration: isUsed ? TextDecoration.lineThrough : null)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),

        if (!_answered) const SizedBox(height: 10),

        if (!_answered)
          Row(children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: allFilled ? checkFillBank : null,
                icon: const Icon(Icons.check),
                label: const Text('ምርግጋጽ - Check Answers'),
                style: ElevatedButton.styleFrom(backgroundColor: allFilled ? const Color(0xFF2E7D32) : Colors.grey[300], foregroundColor: allFilled ? Colors.white : Colors.grey[600], padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _fillBankSelections.isEmpty ? null : () => setState(() => _fillBankSelections.clear()),
              icon: const Icon(Icons.clear_all),
              label: const Text('ኣጽርይዎ'),
              style: ElevatedButton.styleFrom(backgroundColor: _fillBankSelections.isEmpty ? Colors.grey[200] : Colors.red.shade400, foregroundColor: _fillBankSelections.isEmpty ? Colors.grey[400] : Colors.white, padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            ),
          ]),

        if (_answered) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: Text(_questionIndex < _questions.length - 1 ? 'ዝስዕብ ሕቶ - Next Question →' : 'ወድእ - Finish ✓', style: const TextStyle(fontSize: 16)),
            ),
          ).animate().fadeIn(duration: 300.ms),
        ],
      ],
    );
  }

  // ─── Word Match Widget ───────────────────────────────────────────────────────

  Widget _buildWordMatchWidget(Question q) {
    final pairs = q.correctAnswer.split('|').map((p) { final parts = p.split(':'); return MapEntry(parts[0], parts[1]); }).toList();
    final words = pairs.map((p) => p.key).toList();
    final antonyms = pairs.map((p) => p.value).toList();

    if (_orderingItems.isEmpty) _orderingItems = List<String>.from(antonyms)..shuffle();
    final pool = _orderingItems;
    final assigned = _wordMatchSelections.values.toSet();
    final allMatched = words.every((w) => _wordMatchSelections[w] != null);

    void checkWordMatch() {
      if (_answered) return;
      int correct = 0;
      for (final p in pairs) { if (_wordMatchSelections[p.key] == p.value) correct++; }
      setState(() { _selectedAnswer = words.map((w) => '$w:${_wordMatchSelections[w] ?? ''}').join('|'); _answered = true; if (correct == pairs.length) _correct++; });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_answered)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              _wordMatchTapped == null ? '① ቃል ምረጽ → ② ኣንጻሩ ምረጽ - Select a word, then its antonym' : '✅ "$_wordMatchTapped" ተሓርዩ — ሕጂ ኣንጻሩ ምረጽ - Now pick its antonym',
              style: TextStyle(color: _wordMatchTapped != null ? const Color(0xFF2E7D32) : Colors.grey[500], fontSize: 12, fontWeight: _wordMatchTapped != null ? FontWeight.bold : FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),

        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...words.asMap().entries.map((entry) {
                final i = entry.key;
                final word = entry.value;
                final correctAntonym = pairs[i].value;
                final selected = _wordMatchSelections[word];
                final isActive = _wordMatchTapped == word;

                Color wordBg = Colors.white;
                Color wordBorder = Colors.grey[300]!;
                if (isActive) { wordBg = const Color(0xFF2E7D32).withOpacity(0.15); wordBorder = const Color(0xFF2E7D32); }
                else if (selected != null && !_answered) { wordBg = const Color(0xFF2E7D32).withOpacity(0.05); wordBorder = const Color(0xFF2E7D32).withOpacity(0.4); }
                if (_answered) { wordBg = selected == correctAntonym ? Colors.green.withOpacity(0.08) : Colors.red.withOpacity(0.08); wordBorder = selected == correctAntonym ? Colors.green : Colors.red; }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _answered ? null : () => setState(() { _wordMatchTapped = (_wordMatchTapped == word) ? null : word; }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          decoration: BoxDecoration(color: wordBg, borderRadius: BorderRadius.circular(10), border: Border.all(color: wordBorder, width: 1.5)),
                          child: Text(word, style: TextStyle(fontFamily: 'AbyssinicaSIL', fontWeight: FontWeight.bold, fontSize: 14, color: isActive ? const Color(0xFF2E7D32) : Colors.black87), textAlign: TextAlign.center),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Icon(Icons.arrow_forward, color: Colors.grey[400], size: 14)),
                    Expanded(
                      child: GestureDetector(
                        onTap: (!_answered && selected != null) ? () => setState(() { _wordMatchSelections.remove(word); _wordMatchTapped = word; }) : null,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          decoration: BoxDecoration(
                            color: selected != null ? (_answered ? (selected == correctAntonym ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1)) : const Color(0xFF2E7D32).withOpacity(0.06)) : Colors.grey[100],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: _answered ? (selected == correctAntonym ? Colors.green : Colors.red) : (selected != null ? const Color(0xFF2E7D32).withOpacity(0.5) : Colors.grey[300]!), width: 1.5),
                          ),
                          child: Row(children: [
                            Expanded(child: Text(selected ?? '—', style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 14, color: selected != null ? Colors.black87 : Colors.grey[400]), textAlign: TextAlign.center)),
                            if (_answered) Icon(selected == correctAntonym ? Icons.check_circle : Icons.cancel, color: selected == correctAntonym ? Colors.green : Colors.red, size: 14),
                            if (!_answered && selected != null) Icon(Icons.close, size: 12, color: Colors.grey[400]),
                          ]),
                        ),
                      ),
                    ),
                  ]),
                );
                }),
                // Fixed: this antonym/plural pool used to be a fixed
                // sibling BELOW this Expanded/scrollable region — fixed
                // children in a Column always get their full natural size
                // regardless of available space, so a question with many
                // pairs (e.g. the 17-pair "ራድዮ" singular/plural set) had
                // nowhere for the excess pool height to go, causing
                // overflow and pushing the actual tappable answers off
                // screen. Moving it inside the same scroll area means it
                // scrolls together with the word-pair list instead.
                if (!_answered) ...[
                  const Divider(height: 16),
                  Wrap(
                    spacing: 8, runSpacing: 8, alignment: WrapAlignment.center,
                    children: pool.map((antonym) {
                      final isAssigned = assigned.contains(antonym);
                      final canTap = !isAssigned && _wordMatchTapped != null;
                      return GestureDetector(
                        onTap: canTap ? () => setState(() { _wordMatchSelections.removeWhere((k, v) => v == antonym); _wordMatchSelections[_wordMatchTapped!] = antonym; _wordMatchTapped = null; }) : null,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isAssigned ? Colors.grey[100] : (canTap ? const Color(0xFF2E7D32).withOpacity(0.12) : Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isAssigned ? Colors.grey[300]! : (canTap ? const Color(0xFF2E7D32) : Colors.grey[400]!), width: canTap ? 2 : 1),
                          ),
                          child: Text(antonym, style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 14, color: isAssigned ? Colors.grey[400] : Colors.black87, decoration: isAssigned ? TextDecoration.lineThrough : null)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ),

        if (!_answered) ...[
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: allMatched ? checkWordMatch : null,
                icon: const Icon(Icons.check), label: const Text('ምርግጋጽ - Check Answers'),
                style: ElevatedButton.styleFrom(backgroundColor: allMatched ? const Color(0xFF2E7D32) : Colors.grey[300], foregroundColor: allMatched ? Colors.white : Colors.grey[600], padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: _wordMatchSelections.isEmpty ? null : () => setState(() { _wordMatchSelections.clear(); _wordMatchTapped = null; }),
              icon: const Icon(Icons.clear_all), label: const Text('ጽሬት'),
              style: ElevatedButton.styleFrom(backgroundColor: _wordMatchSelections.isEmpty ? Colors.grey[200] : Colors.red.shade400, foregroundColor: _wordMatchSelections.isEmpty ? Colors.grey[400] : Colors.white, padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            ),
          ]),
        ],

        if (_answered) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _next,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              child: Text(_questionIndex < _questions.length - 1 ? 'ዝስዕብ ሕቶ - Next Question →' : 'ወድእ - Finish ✓', style: const TextStyle(fontSize: 16)),
            ),
          ).animate().fadeIn(duration: 300.ms),
        ],
      ],
    );
  }

  // ─── Ordering Widget ─────────────────────────────────────────────────────────

  Widget _buildOrderingWidget(Question q) {
    _initOrdering(q);
    final correctOrder = q.correctAnswer.split('|');
    final isCorrectOrder = _answered && _orderingItems.join('|') == q.correctAnswer;

    return Column(children: [
      if (!_answered)
        Padding(padding: const EdgeInsets.only(bottom: 8), child: Text('ጎተት ኣቢልካ ስርዓዮ - Drag to reorder', style: TextStyle(color: Colors.grey[500], fontSize: 12))),
      Expanded(
        child: ReorderableListView.builder(
          onReorder: _answered ? (_, __) {} : (oldIndex, newIndex) {
            setState(() { if (newIndex > oldIndex) newIndex--; final item = _orderingItems.removeAt(oldIndex); _orderingItems.insert(newIndex, item); });
          },
          proxyDecorator: (child, index, animation) => Material(elevation: 6, borderRadius: BorderRadius.circular(12), shadowColor: const Color(0xFF2E7D32).withOpacity(0.3), child: child),
          itemCount: _orderingItems.length,
          itemBuilder: (_, i) {
            final item = _orderingItems[i];
            Color? bg; Color? borderColor;
            if (_answered) { final cp = correctOrder.indexOf(item); bg = cp == i ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1); borderColor = cp == i ? Colors.green : Colors.red; }
            return Container(
              key: ValueKey(item),
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: bg ?? Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor ?? const Color(0xFF2E7D32).withOpacity(0.3)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
              child: Row(children: [
                Container(width: 24, height: 24, decoration: BoxDecoration(color: const Color(0xFF2E7D32).withOpacity(0.1), shape: BoxShape.circle), child: Center(child: Text('${i + 1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))))),
                const SizedBox(width: 10),
                Expanded(child: Text(item, style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 14))),
                if (!_answered) ReorderableDragStartListener(index: i, child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.drag_handle, color: Color(0xFF2E7D32), size: 24))),
                if (_answered) Icon(correctOrder.indexOf(item) == i ? Icons.check_circle : Icons.cancel, color: correctOrder.indexOf(item) == i ? Colors.green : Colors.red, size: 18),
              ]),
            );
          },
        ),
      ),
      if (!_answered)
        Padding(padding: const EdgeInsets.only(top: 8), child: SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _checkOrdering, icon: const Icon(Icons.check), label: const Text('ምርግጋጽ - Check Order'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)))))),
      if (_answered) ...[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Container(
            width: double.infinity, padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: isCorrectOrder ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: isCorrectOrder ? Colors.green : Colors.orange)),
            child: Text(isCorrectOrder ? '🎉 ቅደም ሰዓብ ቅኑዕ እዩ! - Correct order!' : '📋 ቅኑዕ ቅደም ሰዓብ ርአ - Green = correct position', textAlign: TextAlign.center, style: TextStyle(color: isCorrectOrder ? Colors.green[700] : Colors.orange[700], fontFamily: 'AbyssinicaSIL', fontSize: 13)),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _next,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E7D32), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            child: Text(_questionIndex < _questions.length - 1 ? 'ዝስዕብ ሕቶ - Next Question →' : 'ወድእ - Finish ✓', style: const TextStyle(fontSize: 16)),
          ),
        ).animate().fadeIn(duration: 300.ms),
      ],
    ]);
  }
}

// ─── Expandable Translation ───────────────────────────────────────────────────

class _ExpandableTranslation extends StatefulWidget {
  final String english;
  const _ExpandableTranslation({required this.english});
  @override
  State<_ExpandableTranslation> createState() => _ExpandableTranslationState();
}

class _ExpandableTranslationState extends State<_ExpandableTranslation> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        width: double.infinity, padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.translate, color: Color(0xFF2E7D32), size: 18),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('ትርጉም ብእንግሊዘኛ - English Translation',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2E7D32))),
            ),
            Icon(_expanded ? Icons.expand_less : Icons.expand_more, color: Colors.grey),
          ]),
          if (_expanded) ...[
            const SizedBox(height: 10),
            Text(widget.english, style: TextStyle(color: Colors.grey[700], fontSize: 14, height: 1.6)),
          ],
        ]),
      ),
    );
  }
}

// ─── Difficulty progress bar ──────────────────────────────────────────────────

class _DifficultyBar extends StatelessWidget {
  final String label;
  final double progress;
  final Color color;
  final bool unlocked;
  final String? lockMsg;
  const _DifficultyBar({required this.label, required this.progress, required this.color, required this.unlocked, this.lockMsg});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(unlocked ? Icons.lock_open : Icons.lock, size: 14, color: unlocked ? color : Colors.grey),
      const SizedBox(width: 6),
      SizedBox(width: 100, child: Text(label, style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 11, color: unlocked ? Colors.black87 : Colors.grey))),
      Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: unlocked ? progress : 0, backgroundColor: Colors.grey[200], valueColor: AlwaysStoppedAnimation(unlocked ? color : Colors.grey[300]!), minHeight: 8))),
      const SizedBox(width: 8),
      Text(unlocked ? '${(progress * 100).toInt()}%' : '🔒', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: unlocked ? color : Colors.grey)),
    ]);
  }
}