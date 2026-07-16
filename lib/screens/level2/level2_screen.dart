// lib/screens/level2/level2_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../providers/progress_provider.dart';
import '../../data/words_data.dart';
import '../../data/quiz_data.dart';
import '../../widgets/widgets.dart';
import '../../models/word.dart';
import '../shared/quiz_screen.dart';
import 'word_audio.dart';
import 'word_image_match.dart';
import 'word_fill_blank.dart';
import 'word_search.dart';

class Level2Screen extends StatefulWidget {
  const Level2Screen({super.key});
  @override
  State<Level2Screen> createState() => _Level2ScreenState();
}

class _Level2ScreenState extends State<Level2Screen> {
  final _searchCtrl = TextEditingController();
  String _search = '';
  String _filter = 'All';
  static const _accent = Color(0xFF00BCD4);
  static const _pageSize = 20;
  int _currentPage = 0;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress    = context.watch<ProgressProvider>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final allWords = wordsData.where((w) {
      final ms = _search.isEmpty ||
          w.tigrigna.contains(_search) ||
          w.english.toLowerCase().contains(_search.toLowerCase()) ||
          w.transliteration.toLowerCase().contains(_search.toLowerCase());
      final mf = _filter == 'Done'
          ? progress.isWordDone(w.id)
          : _filter == 'Todo'
              ? !progress.isWordDone(w.id)
              : true;
      return ms && mf;
    }).toList();

    final totalPages =
        (allWords.length / _pageSize).ceil().clamp(1, 999);
    final safePage  = _currentPage.clamp(0, totalPages - 1);
    final start     = safePage * _pageSize;
    final end       = (start + _pageSize).clamp(0, allWords.length);
    final words     = allWords.sublist(start, end);

    final doneCount =
        wordsData.where((w) => progress.isWordDone(w.id)).length;
    final pct = (progress.wordLevelProgress * 100).toInt();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF0FCFF),
      appBar: AppBar(
        title: const Text('ቃላት - Words',
            style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress.wordLevelProgress,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
            minHeight: 4,
          ),
        ),
      ),
      body: Column(children: [

        // ── Stats bar — tightened padding on both axes; this and every
        // other fixed section below is compacted to give the word list
        // (the actual content) as much of the screen as possible. The
        // decorative "Words & Activities" section header that used to sit
        // here has been removed entirely — it only duplicated the app bar
        // title and cost ~40px of permanent vertical space for no
        // functional benefit.
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 12, vertical: isLandscape ? 3 : 5),
          color: _accent.withOpacity(0.07),
          child: Row(children: [
            _StatChip(
                icon: Icons.check_circle,
                label: '$doneCount done',
                color: Colors.green),
            const SizedBox(width: 6),
            _StatChip(
                icon: Icons.hourglass_bottom,
                label: '${wordsData.length - doneCount} ተሪፉ - left',
                color: Colors.orange),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                  color: _accent,
                  borderRadius: BorderRadius.circular(20)),
              child: Text('$pct%',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
          ]),
        ),

        // ── Quiz banner — compact / hidden in landscape ───────────────────
        if (progress.canTakeLevel2Quiz)
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => QuizScreen(
                        level: 2,
                        questions: getQuizQuestions(2)))),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(
                  12, isLandscape ? 3 : 6, 12, 0),
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isLandscape ? 5 : 9),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xFF00BCD4), Color(0xFF0097A7)]),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: _accent.withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 4))
                ],
              ),
              child: const Row(children: [
                Icon(Icons.quiz, color: Colors.white, size: 18),
                SizedBox(width: 8),
                Expanded(
                    child: Text('ተዳሎ፥ ደረጃ 2 ፈተና ውሰድ →',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13))),
                Icon(Icons.arrow_forward_ios,
                    color: Colors.white70, size: 13),
              ]),
            ),
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),

        // ── Search + filter — tightened padding, always dense ────────────
        Padding(
          padding: EdgeInsets.fromLTRB(
              12, isLandscape ? 3 : 6, 12, 2),
          child: Row(children: [
            Expanded(
              child: TextField(
                controller: _searchCtrl,
                enabled: true,
                decoration: InputDecoration(
                  hintText: 'ቃላት ድለዩ ... Search words...',
                  hintStyle: const TextStyle(fontSize: 12),
                  prefixIcon: const Icon(Icons.search, size: 18),
                  suffixIcon: _search.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 16),
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() => _search = '');
                          })
                      : null,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 14),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                ),
                onChanged: (v) =>
                    setState(() { _search = v; _currentPage = 0; }),
              ),
            ),
            const SizedBox(width: 6),
            _FilterBtn(
                label: 'All',
                active: _filter == 'All',
                onTap: () => setState(
                    () { _filter = 'All'; _currentPage = 0; })),
            const SizedBox(width: 4),
            _FilterBtn(
                label: '✓',
                active: _filter == 'Done',
                onTap: () => setState(
                    () { _filter = 'Done'; _currentPage = 0; })),
            const SizedBox(width: 4),
            _FilterBtn(
                label: '…',
                active: _filter == 'Todo',
                onTap: () => setState(
                    () { _filter = 'Todo'; _currentPage = 0; })),
          ]),
        ),

        // Word count + page indicator — hidden in landscape (redundant
        // with the pagination widget itself, and every bit of vertical
        // space matters more there); unchanged in portrait.
        if (!isLandscape)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
            child: Row(children: [
              Text('${allWords.length} words',
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: 10)),
              const Spacer(),
              Text('Page ${safePage + 1} of $totalPages',
                  style: TextStyle(
                      color: Colors.grey[500], fontSize: 10)),
            ]),
          ),

        // ── Word list — ALWAYS gets remaining space ────────────────────────
        // Landscape uses a multi-column grid instead of a single-column
        // list: landscape has width to spare but very little height, so
        // trading unused width for column count roughly doubles (or more,
        // on wider screens) how many words are visible without needing
        // more vertical space. Portrait keeps the original single-column
        // list untouched.
        Expanded(
          child: words.isEmpty
              ? Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    const Text('😕',
                        style: TextStyle(fontSize: 40)),
                    const SizedBox(height: 8),
                    Text('ዝሳማማዕ ቃል ኣይተረኽበን - No words found',
                        style:
                            TextStyle(color: Colors.grey[500])),
                  ]))
              : isLandscape
                  ? LayoutBuilder(builder: (context, constraints) {
                      const horizontalPadding = 12.0;
                      const crossAxisSpacing = 8.0;
                      // Bumped from 58 to 70: the previous estimate didn't
                      // fully account for the tile's 6px bottom margin plus
                      // the taller line-height Ethiopic/Ge'ez script
                      // actually renders at (AbyssinicaSIL glyphs have
                      // noticeably taller ascenders/descenders than Latin
                      // text at the same font size). Since this value
                      // directly determines the grid's fixed cell height via
                      // childAspectRatio, underestimating it meant every
                      // tile was squeezed into a cell shorter than its real
                      // content — producing the same ~9px overflow on every
                      // single tile.
                      const estimatedTileHeight = 70.0;
                      // Measure real available width rather than assuming
                      // a fixed column count, so this adapts correctly
                      // across different phone/tablet widths.
                      final crossAxisCount = ((constraints.maxWidth -
                                  horizontalPadding * 2) /
                              260)
                          .floor()
                          .clamp(2, 4);
                      final itemWidth = (constraints.maxWidth -
                              horizontalPadding * 2 -
                              crossAxisSpacing * (crossAxisCount - 1)) /
                          crossAxisCount;
                      final aspectRatio = itemWidth / estimatedTileHeight;
                      return GridView.builder(
                        padding: EdgeInsets.fromLTRB(horizontalPadding, 2,
                            horizontalPadding,
                            MediaQuery.of(context).viewInsets.bottom + 2),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: crossAxisSpacing,
                          childAspectRatio: aspectRatio,
                        ),
                        itemCount: words.length,
                        itemBuilder: (ctx, i) => _WordTile(word: words[i])
                            .animate()
                            .fadeIn(delay: (i * 15).ms, duration: 180.ms),
                      );
                    })
                  : ListView.builder(
                      padding: EdgeInsets.fromLTRB(12, 2, 12, MediaQuery.of(context).viewInsets.bottom + 2),
                      itemCount: words.length,
                      itemBuilder: (ctx, i) => _WordTile(word: words[i])
                          .animate()
                          .fadeIn(
                              delay: (i * 25).ms, duration: 200.ms)
                          .slideX(begin: 0.1, end: 0),
                    ),
        ),

        // ── Word Search banner — hidden in landscape ───────────────────────
        // This was the single biggest fixed-space cost after the word
        // list itself. In landscape (where vertical space is scarce) it's
        // hidden; portrait — which already looks good — keeps it exactly
        // as before.
        if (!isLandscape)
        Consumer<ProgressProvider>(
          builder: (_, progress, __) {
            final unlocked = progress.wordLevelProgress >= 0.8;
            return GestureDetector(
              onTap: unlocked
                  ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              const WordSearchSelectorScreen()))
                  : null,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(12, 6, 12, 0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: unlocked
                          ? [
                              const Color(0xFF00897B),
                              const Color(0xFF00695C)
                            ]
                          : [
                              Colors.grey.shade400,
                              Colors.grey.shade500
                            ]),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: (unlocked
                                ? Colors.teal
                                : Colors.grey)
                            .withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 3))
                  ],
                ),
                child: Row(children: [
                  Text(unlocked ? '🔍' : '🔒',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      unlocked
                          ? 'ምድላይ ቃላት - Word Search'
                          : 'ምድላይ ቃላት - Word Search (80% required)',
                      style: const TextStyle(
                          fontFamily: 'AbyssinicaSIL',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                      unlocked
                          ? Icons.arrow_forward_ios
                          : Icons.lock,
                      color: Colors.white70,
                      size: 14),
                ]),
              ),
            );
          },
        ).animate().fadeIn(duration: 300.ms),

        // ── Pagination — tighter vertical padding ──────────────────────────
        if (allWords.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: isLandscape ? 2 : 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.grey[200]!)),
            ),
            child: Row(children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: safePage > 0
                    ? () => setState(
                        () => _currentPage = safePage - 1)
                    : null,
                icon: const Icon(Icons.chevron_left),
                style: IconButton.styleFrom(
                  backgroundColor: safePage > 0
                      ? _accent.withOpacity(0.1)
                      : Colors.grey[100],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(totalPages, (i) {
                      final isActive = i == safePage;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _currentPage = i),
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 3),
                          width: isActive ? 30 : 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isActive
                                ? _accent
                                : Colors.grey[100],
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text('${i + 1}',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isActive
                                        ? Colors.white
                                        : Colors.grey[600])),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: safePage < totalPages - 1
                    ? () => setState(
                        () => _currentPage = safePage + 1)
                    : null,
                icon: const Icon(Icons.chevron_right),
                style: IconButton.styleFrom(
                  backgroundColor: safePage < totalPages - 1
                      ? _accent.withOpacity(0.1)
                      : Colors.grey[100],
                ),
              ),
            ]),
          ),
      ]),
    );
  }
}

// ─── Compact word tile ────────────────────────────────────────────────────────

class _WordTile extends StatelessWidget {
  final Word word;
  const _WordTile({required this.word});
  static const _accent = Color(0xFF00BCD4);

  @override
  Widget build(BuildContext context) {
    final done =
        context.watch<ProgressProvider>().isWordDone(word.id);
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: done ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: done
                ? const Color(0xFFA5D6A7)
                : Colors.grey[200]!,
            width: 1.2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 4,
              offset: const Offset(0, 2))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _showSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),
            child: Row(children: [
              Stack(
                children: [
                  AudioBtn(
                      ttsText: word.tigrigna,
                      audioPath: word.audioPath,
                      size: 34,
                      color: _accent),
                  if (done)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.check,
                            color: Colors.white, size: 10),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    Text(word.tigrigna,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                            fontFamily: 'AbyssinicaSIL',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.2)),
                    Text(word.transliteration,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 11)),
                  ])),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: _accent.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(word.english,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00838F))),
              ),
              const SizedBox(width: 6),
              Icon(Icons.chevron_right,
                  color: Colors.grey[400], size: 18),
            ]),
          ),
        ),
      ),
    );
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ActivitySheet(word: word),
    );
  }
}

// ─── Activity bottom sheet ────────────────────────────────────────────────────

class _ActivitySheet extends StatelessWidget {
  final Word word;
  const _ActivitySheet({required this.word});
  static const _accent = Color(0xFF00BCD4);

  @override
  Widget build(BuildContext context) {
    final done =
        context.watch<ProgressProvider>().isWordDone(word.id);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom + 24),
      // Wrapped in SingleChildScrollView: the sheet's content (header, word
      // row, completed badge, divider, 3 activity options) has a fixed
      // intrinsic height that doesn't shrink to fit. A modal bottom sheet
      // is always capped at the screen height, so on a short landscape
      // viewport the content could exceed that cap with nowhere to go —
      // producing a bottom overflow that clipped the last option. Scrolling
      // fixes this regardless of screen size/orientation.
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
        const SizedBox(height: 12),
        Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),

        // Word header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  color: _accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                  child: Text(word.emoji,
                      style: const TextStyle(fontSize: 34))),
            ),
            const SizedBox(width: 14),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(word.tigrigna,
                      style: const TextStyle(
                          fontFamily: 'AbyssinicaSIL',
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  Text(word.transliteration,
                      style: TextStyle(
                          color: Colors.grey[500], fontSize: 13)),
                  Text(word.english,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF00838F))),
                ])),
            AudioBtn(
                ttsText: word.tigrigna,
                audioPath: word.audioPath,
                size: 44,
                color: _accent),
          ]),
        ),

        if (done) ...[
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10)),
            child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle,
                      color: Colors.green, size: 16),
                  SizedBox(width: 6),
                  Text('Completed!',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 13)),
                ]),
          ),
        ],

        const SizedBox(height: 16),
        const Divider(height: 1),

        _ActivityOption(
          icon: Icons.headphones,
          color: const Color(0xFF5C6BC0),
          title: 'Listen & Repeat',
          subtitle:
              'ቃል 3 ግዜ ሰሚዕካ ድገም - Hear the word 3 times and repeat',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        WordAudioScreen(word: word)));
          },
        ),
        _ActivityOption(
          icon: Icons.image,
          color: const Color(0xFF26A69A),
          title: 'ምስ ስእሊ ኣሰማምዕ - Image Match',
          subtitle:
              'ነቲ ስእሊ ቅኑዕ ቃል ምረጽ - Pick the correct word for the image',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        WordImageMatchScreen(word: word)));
          },
        ),
        _ActivityOption(
          icon: Icons.edit,
          color: const Color(0xFFEF6C00),
          title: 'ባዶ ቦታ ምላእ - Fill in the Blank',
          subtitle:
              'ፋሕ ፋሕ ኢሎም ዘለው ቃላት ኣማዓራሪ - Arrange the scrambled words',
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        WordFillBlankScreen(word: word)));
          },
        ),
        const SizedBox(height: 8),
      ]),
      ),
    );
  }
}

class _ActivityOption extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle;
  final VoidCallback onTap;
  const _ActivityOption(
      {required this.icon,
      required this.color,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 12),
        child: Row(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 14)),
            Text(subtitle,
                style: TextStyle(
                    color: Colors.grey[500], fontSize: 12)),
          ])),
          Icon(Icons.arrow_forward_ios,
              size: 14, color: Colors.grey[400]),
        ]),
      ),
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _StatChip(
      {required this.icon,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(label,
            style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class _FilterBtn extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _FilterBtn(
      {required this.label,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFF00BCD4)
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: active
                    ? Colors.white
                    : Colors.grey[600])),
      ),
    );
  }
}