// lib/screens/shared/quiz_screen.dart
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../models/question.dart';
import '../../models/paragraph.dart';
import '../../providers/progress_provider.dart';
import '../../data/paragraphs_data.dart';
import '../../widgets/widgets.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final int level;
  final List<Question> questions;

  const QuizScreen({super.key, required this.level, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _answered = false;
  late AnimationController _progressController;
  late AnimationController _shakeController;

  final Map<String, String?> _wordMatchSelections = {};
  String? _wordMatchTapped;
  List<String> _wordMatchPool = [];
  final Map<int, String?> _fillBankSelections = {};
  List<String> _orderingItems = [];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _shakeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _progressController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  Question get _current => widget.questions[_currentIndex];
  int get _total => widget.questions.length;

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOptionIndex = index;
      _answered = true;
    });
    final correct = _current.options[index] == _current.correctAnswer;
    if (correct) {
      _score++;
      _progressController.forward(from: 0);
    } else {
      _shakeController.forward(from: 0);
    }
  }

  void _next() {
    if (_currentIndex < _total - 1) {
      setState(() {
        _currentIndex++;
        _selectedOptionIndex = null;
        _answered = false;
        _wordMatchSelections.clear();
        _wordMatchTapped = null;
        _wordMatchPool = [];
        _fillBankSelections.clear();
        _orderingItems = [];
      });
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final percent = (_score / _total * 100).round();
    final progress = context.read<ProgressProvider>();
    switch (widget.level) {
      case 1: await progress.submitLevel1Quiz(percent); break;
      case 2: await progress.submitLevel2Quiz(percent); break;
      case 3: await progress.submitLevel3Quiz(percent); break;
      case 4: await progress.submitLevel4Quiz(percent); break;
    }
    if (mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => ResultScreen(
          score: percent,
          correct: _score,
          total: _total,
          level: widget.level,
          passed: percent >= 80,
        ),
      ));
    }
  }

  Paragraph? _findParagraph() {
    final ctx = _current.context;
    if (ctx == null || widget.level != 4) return null;
    try {
      return paragraphsData.firstWhere(
        (p) => p.title == ctx || p.title.contains(ctx) || ctx.contains(p.title),
      );
    } catch (_) {
      return null;
    }
  }

  void _openParagraph(Paragraph paragraph) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => _ParagraphPreviewScreen(paragraph: paragraph),
    ));
  }

  Color _levelColor(int level) {
    const colors = [
      Color(0xFF7C4DFF),
      Color(0xFF00BCD4),
      Color(0xFFFF7043),
      Color(0xFF2E7D32),
    ];
    return colors[(level - 1).clamp(0, 3)];
  }

  @override
  Widget build(BuildContext context) {
    final progressValue = (_currentIndex + 1) / _total;
    final paragraph = _findParagraph();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      // ── Nature background replaces the flat colour ──────────────────────
      body: Stack(
        children: [
          // Layer 1 — nature scene (full screen)
          const _NatureBackground(),

          // Layer 2 — quiz content
          SafeArea(
            child: Column(
              children: [
                // ── Top bar (progress + close) ──────────────────────────
                _buildTopBar(progressValue),

                // ── Main quiz content ────────────────────────────────────
                Expanded(
                  child: isLandscape
                      ? _buildLandscapeLayout(paragraph)
                      : _buildPortraitLayout(paragraph),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Top bar ──────────────────────────────────────────────────────────────
  Widget _buildTopBar(double progressValue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 4),
      child: Row(
        children: [
          // Close button — frosted circle
          _GlassCircle(
            size: 34,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.close, size: 16, color: Colors.black87),
              onPressed: _showExitDialog,
            ),
          ),
          const SizedBox(width: 10),
          // Progress bar
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.white.withOpacity(0.35),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Score badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$_score/$_total',
              style: TextStyle(
                color: _levelColor(widget.level),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Portrait layout ──────────────────────────────────────────────────────
  Widget _buildPortraitLayout(Paragraph? paragraph) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQuestionCard(compact: false),
          const SizedBox(height: 10),
          if (paragraph != null) _buildReadButton(paragraph),
          if (paragraph != null) const SizedBox(height: 10),
          Expanded(
            child: _current.type == QuestionType.wordMatch ||
                    _current.type == QuestionType.fillBank ||
                    _current.type == QuestionType.ordering
                ? _buildComplexQuestion()
                // Fixed: previously this was a Column ending in Spacer()
                // + the Next button. Spacer() can only ADD leftover space
                // — it can't shrink the 4 options when the question card
                // above (whose height varies a lot depending on whether
                // there's an image/emoji/context badge) leaves less room
                // than the options need. That produced a bottom overflow
                // right at the Next button. Wrapping the options in their
                // own Expanded + SingleChildScrollView means they scroll
                // if they don't fit, instead of overflowing — matching
                // the pattern the landscape layout already used correctly.
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: _current.options
                                .asMap()
                                .entries
                                .map((e) => _buildGlassOption(e.key, e.value)
                                    .animate()
                                    .slideX(
                                        begin: 0.2,
                                        delay: (e.key * 80).ms,
                                        duration: 300.ms))
                                .toList(),
                          ),
                        ),
                      ),
                      if (_answered)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: NextBtn(
                            label: _currentIndex < _total - 1
                                ? 'ዝስዕብ ሕቶ - Next Question'
                                : 'ውጽኢት ርኣዩ - See Results',
                            onTap: _next,
                            icon: _currentIndex < _total - 1
                                ? Icons.arrow_forward
                                : Icons.flag,
                          ),
                        ).animate().slideY(begin: 1, duration: 300.ms),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ── Landscape layout ─────────────────────────────────────────────────────
  Widget _buildLandscapeLayout(Paragraph? paragraph) {
    final isComplex = _current.type == QuestionType.wordMatch ||
        _current.type == QuestionType.fillBank ||
        _current.type == QuestionType.ordering;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildQuestionCard(compact: true),
                const SizedBox(height: 8),
                if (paragraph != null) _buildReadButton(paragraph),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: isComplex
                ? _buildComplexQuestion()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: _current.options
                                .asMap()
                                .entries
                                .map((e) => _buildGlassOption(e.key, e.value)
                                    .animate()
                                    .slideX(
                                        begin: 0.2,
                                        delay: (e.key * 60).ms,
                                        duration: 250.ms))
                                .toList(),
                          ),
                        ),
                      ),
                      if (_answered) ...[
                        const SizedBox(height: 8),
                        NextBtn(
                          label: _currentIndex < _total - 1
                              ? 'ዝስዕብ ሕቶ - Next Question'
                              : 'ውጽኢት ርኣዩ - See Results',
                          onTap: _next,
                          icon: _currentIndex < _total - 1
                              ? Icons.arrow_forward
                              : Icons.flag,
                        ).animate().slideY(begin: 1, duration: 300.ms),
                      ],
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // ── Glass-style option tile (replaces OptionTile for the nature theme) ───
  Widget _buildGlassOption(int index, String text) {
    final bool isSelected = _selectedOptionIndex == index;
    final bool isCorrectAnswer = text == _current.correctAnswer;

    Color bgColor = Colors.white.withOpacity(0.78);
    Color borderColor = Colors.white.withOpacity(0.55);
    Color letterBg = const Color(0xFFE8F5E9);
    Color letterColor = const Color(0xFF2E7D32);
    Color textColor = Colors.black87;
    Widget? trailingIcon;

    if (_answered) {
      if (isCorrectAnswer) {
        bgColor = const Color(0xFF2E7D32).withOpacity(0.18);
        borderColor = const Color(0xFF2E7D32).withOpacity(0.6);
        letterBg = const Color(0xFF2E7D32);
        letterColor = Colors.white;
        textColor = const Color(0xFF1B5E20);
        trailingIcon = const Icon(Icons.check_circle,
            color: Color(0xFF2E7D32), size: 18);
      } else if (isSelected) {
        bgColor = Colors.red.withOpacity(0.12);
        borderColor = Colors.red.withOpacity(0.5);
        letterBg = Colors.red.shade400;
        letterColor = Colors.white;
        textColor = Colors.red.shade800;
        trailingIcon =
            Icon(Icons.cancel, color: Colors.red.shade400, size: 18);
      } else {
        bgColor = Colors.white.withOpacity(0.40);
        borderColor = Colors.white.withOpacity(0.25);
        textColor = Colors.black45;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => _selectOption(index),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Row(
                children: [
                  // Letter badge
                  Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                        color: letterBg, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index), // A B C D
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: letterColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'AbyssinicaSIL',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ),
                  if (trailingIcon != null) trailingIcon,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Question card (frosted glass) ────────────────────────────────────────
  Widget _buildQuestionCard({required bool compact}) {
    final padding = compact ? 14.0 : 20.0;
    final questionFontSize = compact ? 15.0 : 18.0;
    final imageSize = compact ? 60.0 : 90.0;

    final promptText = _current.prompt.split('§').first;
    final emojiMatch = RegExp(
            r'^(\p{Emoji_Presentation}|\p{Extended_Pictographic})\s*',
            unicode: true)
        .firstMatch(promptText);
    final leadingEmoji = emojiMatch?.group(0)?.trim();
    final displayPrompt =
        (_current.imagePath != null && leadingEmoji != null)
            ? promptText.substring(emojiMatch!.end).trim()
            : promptText;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.82),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
                color: Colors.white.withOpacity(0.6), width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header row ─────────────────────────────────────────
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Q ${_currentIndex + 1}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                  ),
                  const Spacer(),
                  if (_current.audioPath != null)
                    AudioBtn(
                        audioPath: _current.audioPath,
                        size: compact ? 32 : 38),
                ],
              ),

              SizedBox(height: compact ? 8 : 12),

              // ── Context badge (Level 4) ────────────────────────────
              if (_current.context != null) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF2E7D32).withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.menu_book,
                          size: 14, color: Color(0xFF2E7D32)),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          _current.context!,
                          style: const TextStyle(
                            fontFamily: 'AbyssinicaSIL',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: compact ? 8 : 10),
              ],

              // ── Image or emoji visual ──────────────────────────────
              if (_current.imagePath != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    _current.imagePath!,
                    width: imageSize,
                    height: imageSize,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: Center(
                        child: Text(leadingEmoji ?? '🖼️',
                            style:
                                TextStyle(fontSize: imageSize * 0.55)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: compact ? 8 : 10),
              ] else if (leadingEmoji != null) ...[
                Text(leadingEmoji,
                    style: TextStyle(fontSize: imageSize * 0.6)),
                SizedBox(height: compact ? 6 : 8),
              ],

              // ── Prompt text ────────────────────────────────────────
              Text(
                displayPrompt,
                style: TextStyle(
                  fontFamily: 'AbyssinicaSIL',
                  fontSize: questionFontSize,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1B5E20),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Read paragraph button ────────────────────────────────────────────────
  Widget _buildReadButton(Paragraph paragraph) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: OutlinedButton.icon(
          onPressed: () => _openParagraph(paragraph),
          icon: const Icon(Icons.menu_book_outlined, size: 18),
          label: Text(
            'ሕጡበ ጽሑፍ ኣንብብ - Read: "${_current.context}"',
            style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.70),
            foregroundColor: const Color(0xFF2E7D32),
            side: const BorderSide(color: Color(0xFF2E7D32), width: 1.5),
            padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  // ── Complex question dispatcher ──────────────────────────────────────────
  Widget _buildComplexQuestion() {
    if (_current.type == QuestionType.wordMatch) return _buildWordMatch();
    if (_current.type == QuestionType.fillBank) return _buildFillBank();
    if (_current.type == QuestionType.ordering) return _buildOrdering();
    return const SizedBox.shrink();
  }

  // ── Word Match ──────────────────────────────────────────────────────────
  Widget _buildWordMatch() {
    final pairs = _current.correctAnswer.split('|').map((p) {
      final parts = p.split(':');
      return MapEntry(parts[0], parts[1]);
    }).toList();
    final words = pairs.map((p) => p.key).toList();
    final antonyms = pairs.map((p) => p.value).toList();

    if (_wordMatchPool.isEmpty) {
      _wordMatchPool = List<String>.from(antonyms)..shuffle();
    }
    final assigned = _wordMatchSelections.values.toSet();
    final allMatched = words.every((w) => _wordMatchSelections[w] != null);

    void check() {
      if (_answered) return;
      int correct = 0;
      for (final p in pairs) {
        if (_wordMatchSelections[p.key] == p.value) correct++;
      }
      setState(() {
        _answered = true;
        if (correct == pairs.length) _score++;
      });
    }

    return Column(children: [
      if (!_answered)
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            _wordMatchTapped == null
                ? '① ቃል ምረጽ → ② ኣንጻሩ ምረጽ'
                : '✅ "$_wordMatchTapped" — ሕጂ ኣንጻሩ ምረጽ',
            style: TextStyle(
                color: _wordMatchTapped != null
                    ? const Color(0xFF2E7D32)
                    : Colors.white70,
                fontSize: 12,
                fontWeight: _wordMatchTapped != null
                    ? FontWeight.bold
                    : FontWeight.normal),
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
              Color wordBg = Colors.white.withOpacity(0.78);
              Color wordBorder = Colors.white.withOpacity(0.5);
              if (isActive) {
                wordBg = const Color(0xFF2E7D32).withOpacity(0.2);
                wordBorder = const Color(0xFF2E7D32);
              } else if (selected != null && !_answered) {
                wordBg = const Color(0xFF2E7D32).withOpacity(0.1);
                wordBorder = const Color(0xFF2E7D32).withOpacity(0.4);
              }
              if (_answered) {
                wordBg = selected == correctAntonym
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.12);
                wordBorder = selected == correctAntonym
                    ? Colors.green
                    : Colors.red;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _answered
                          ? null
                          : () => setState(() {
                                _wordMatchTapped =
                                    (_wordMatchTapped == word) ? null : word;
                              }),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 9),
                            decoration: BoxDecoration(
                                color: wordBg,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: wordBorder, width: 1.5)),
                            child: Text(word,
                                style: TextStyle(
                                    fontFamily: 'AbyssinicaSIL',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: isActive
                                        ? const Color(0xFF2E7D32)
                                        : Colors.black87),
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(Icons.arrow_forward,
                          color: Colors.white70, size: 14)),
                  Expanded(
                    child: GestureDetector(
                      onTap: (!_answered && selected != null)
                          ? () => setState(() {
                                _wordMatchSelections.remove(word);
                                _wordMatchTapped = word;
                              })
                          : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 9),
                            decoration: BoxDecoration(
                              color: selected != null
                                  ? (_answered
                                      ? (selected == correctAntonym
                                          ? Colors.green.withOpacity(0.15)
                                          : Colors.red.withOpacity(0.12))
                                      : const Color(0xFF2E7D32)
                                          .withOpacity(0.08))
                                  : Colors.white.withOpacity(0.45),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: _answered
                                      ? (selected == correctAntonym
                                          ? Colors.green
                                          : Colors.red)
                                      : (selected != null
                                          ? const Color(0xFF2E7D32)
                                              .withOpacity(0.5)
                                          : Colors.white.withOpacity(0.4)),
                                  width: 1.5),
                            ),
                            child: Row(children: [
                              Expanded(
                                  child: Text(selected ?? '—',
                                      style: TextStyle(
                                          fontFamily: 'AbyssinicaSIL',
                                          fontSize: 13,
                                          color: selected != null
                                              ? Colors.black87
                                              : Colors.black45),
                                      textAlign: TextAlign.center)),
                              if (_answered)
                                Icon(
                                    selected == correctAntonym
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: selected == correctAntonym
                                        ? Colors.green
                                        : Colors.red,
                                    size: 14),
                              if (!_answered && selected != null)
                                Icon(Icons.close,
                                    size: 12, color: Colors.black38),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
              }),
              if (!_answered) ...[
                const Divider(height: 12, color: Colors.white38),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: _wordMatchPool.map((antonym) {
                    final isAssigned = assigned.contains(antonym);
                    final canTap = !isAssigned && _wordMatchTapped != null;
                    return GestureDetector(
                      onTap: canTap
                          ? () => setState(() {
                                _wordMatchSelections
                                    .removeWhere((k, v) => v == antonym);
                                _wordMatchSelections[_wordMatchTapped!] = antonym;
                                _wordMatchTapped = null;
                              })
                          : null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isAssigned
                              ? Colors.white.withOpacity(0.30)
                              : (canTap
                                  ? const Color(0xFF2E7D32).withOpacity(0.18)
                                  : Colors.white.withOpacity(0.65)),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: isAssigned
                                  ? Colors.white38
                                  : (canTap
                                      ? const Color(0xFF2E7D32)
                                      : Colors.white.withOpacity(0.5)),
                              width: canTap ? 2 : 1),
                        ),
                        child: Text(antonym,
                            style: TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                fontSize: 13,
                                color: isAssigned
                                    ? Colors.black38
                                    : Colors.black87,
                                decoration: isAssigned
                                    ? TextDecoration.lineThrough
                                    : null)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
      // Fixed: the antonym pool used to be a fixed sibling BELOW this
      // Expanded/scrollable region — fixed children in a Column always
      // get their full natural size regardless of available space, so a
      // question with many pairs had nowhere for the excess pool height
      // to go, causing overflow and pushing the tappable answers off
      // screen. It's now inside the same scroll area (above), so it
      // scrolls together with the word-pair list instead.
      if (!_answered) ...[
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: allMatched ? check : null,
              icon: const Icon(Icons.check, size: 16),
              label: const Text('ምርግጋጽ - Check'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: allMatched
                      ? const Color(0xFF2E7D32)
                      : Colors.white.withOpacity(0.4),
                  foregroundColor:
                      allMatched ? Colors.white : Colors.black45,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _wordMatchSelections.isEmpty
                ? null
                : () => setState(() {
                      _wordMatchSelections.clear();
                      _wordMatchTapped = null;
                    }),
            icon: const Icon(Icons.clear_all, size: 16),
            label: const Text('ጽሬት'),
            style: ElevatedButton.styleFrom(
                backgroundColor: _wordMatchSelections.isEmpty
                    ? Colors.white.withOpacity(0.35)
                    : Colors.red.shade400,
                foregroundColor: _wordMatchSelections.isEmpty
                    ? Colors.black38
                    : Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ]),
      ],
      if (_answered) ...[
        const SizedBox(height: 8),
        NextBtn(
            label: _currentIndex < _total - 1
                ? 'ዝስዕብ ሕቶ - Next Question'
                : 'ውጽኢት ርኣዩ - See Results',
            onTap: _next,
            icon: _currentIndex < _total - 1
                ? Icons.arrow_forward
                : Icons.flag),
      ],
    ]);
  }

  // ── Fill Bank ────────────────────────────────────────────────────────────
  Widget _buildFillBank() {
    final answers = _current.correctAnswer.split('|');
    final bank = List<String>.from(_current.options);
    final used =
        _fillBankSelections.values.whereType<String>().toSet();
    final allFilled = answers
        .asMap()
        .keys
        .every((i) => _fillBankSelections[i] != null);

    final sentences = _current.prompt.contains('§')
        ? _current.prompt.split('§').skip(1).toList()
        : List.generate(answers.length, (_) => '___');

    void check() {
      if (_answered) return;
      int correct = 0;
      for (int i = 0; i < answers.length; i++) {
        if (_fillBankSelections[i] == answers[i]) correct++;
      }
      setState(() {
        _answered = true;
        if (correct == answers.length) _score++;
      });
    }

    return Column(children: [
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
              Color slotBg = Colors.white.withOpacity(0.55);
              Color slotBorder = Colors.white.withOpacity(0.5);
              if (selected != null && !_answered) {
                slotBg = const Color(0xFF2E7D32).withOpacity(0.12);
                slotBorder = const Color(0xFF2E7D32);
              }
              if (_answered) {
                slotBg = selected == correct
                    ? Colors.green.withOpacity(0.15)
                    : Colors.red.withOpacity(0.12);
                slotBorder =
                    selected == correct ? Colors.green : Colors.red;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.55))),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF2E7D32)
                                        .withOpacity(0.15),
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text('${i + 1}',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2E7D32))))),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Wrap(
                                crossAxisAlignment:
                                    WrapCrossAlignment.center,
                                spacing: 4,
                                runSpacing: 4,
                                children: [
                                  if (parts.isNotEmpty &&
                                      parts[0].trim().isNotEmpty)
                                    Text(parts[0].trim(),
                                        style: const TextStyle(
                                            fontFamily: 'AbyssinicaSIL',
                                            fontSize: 13,
                                            height: 1.6,
                                            color: Colors.black87)),
                                  GestureDetector(
                                    onTap: (!_answered &&
                                            selected != null)
                                        ? () => setState(() =>
                                            _fillBankSelections
                                                .remove(i))
                                        : null,
                                    child: Container(
                                      constraints: const BoxConstraints(
                                          minWidth: 70),
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4),
                                      decoration: BoxDecoration(
                                          color: slotBg,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: slotBorder,
                                              width: 1.5)),
                                      child: Row(
                                          mainAxisSize:
                                              MainAxisSize.min,
                                          children: [
                                            Text(
                                                selected ?? ' ____ ',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'AbyssinicaSIL',
                                                    fontSize: 12,
                                                    color: selected !=
                                                            null
                                                        ? Colors.black87
                                                        : Colors
                                                            .black38,
                                                    fontWeight: selected !=
                                                            null
                                                        ? FontWeight.bold
                                                        : FontWeight
                                                            .normal)),
                                            if (_answered)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets
                                                          .only(
                                                          left: 2),
                                                  child: Icon(
                                                      selected ==
                                                              correct
                                                          ? Icons
                                                              .check_circle
                                                          : Icons
                                                              .cancel,
                                                      color: selected ==
                                                              correct
                                                          ? Colors
                                                              .green
                                                          : Colors.red,
                                                      size: 12)),
                                            if (!_answered &&
                                                selected != null)
                                              const Padding(
                                                  padding:
                                                      EdgeInsets.only(
                                                          left: 2),
                                                  child: Icon(
                                                      Icons.close,
                                                      size: 10,
                                                      color: Colors
                                                          .black38)),
                                          ]),
                                    ),
                                  ),
                                  if (parts.length > 1 &&
                                      parts[1].trim().isNotEmpty)
                                    Text(parts[1].trim(),
                                        style: const TextStyle(
                                            fontFamily: 'AbyssinicaSIL',
                                            fontSize: 13,
                                            height: 1.6,
                                            color: Colors.black87)),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              );
              }),
              if (!_answered) ...[
                const Divider(height: 12, color: Colors.white38),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  alignment: WrapAlignment.center,
                  children: bank.map((word) {
                    final isUsed = used.contains(word);
                    return GestureDetector(
                      onTap: isUsed
                          ? null
                          : () {
                              final empty = List.generate(answers.length, (i) => i)
                                  .firstWhere(
                                      (i) => _fillBankSelections[i] == null,
                                      orElse: () => -1);
                              if (empty != -1) {
                                setState(() => _fillBankSelections[empty] = word);
                              }
                            },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                            color: isUsed
                                ? Colors.white.withOpacity(0.30)
                                : Colors.white.withOpacity(0.78),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: isUsed
                                    ? Colors.white38
                                    : const Color(0xFF2E7D32),
                                width: isUsed ? 1 : 1.5)),
                        child: Text(word,
                            style: TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                fontSize: 13,
                                color: isUsed ? Colors.black38 : Colors.black87,
                                decoration: isUsed
                                    ? TextDecoration.lineThrough
                                    : null)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
      // Fixed: the word-bank pool used to be a fixed sibling BELOW this
      // Expanded/scrollable region — fixed children in a Column always get
      // their full natural size regardless of available space, so a
      // question with many bank words had nowhere for the excess pool
      // height to go, causing overflow and pushing the tappable answers
      // off screen. It's now inside the same scroll area (above).
      if (!_answered) ...[
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: allFilled ? check : null,
              icon: const Icon(Icons.check, size: 16),
              label: const Text('ምርግጋጽ - Check'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: allFilled
                      ? const Color(0xFF2E7D32)
                      : Colors.white.withOpacity(0.4),
                  foregroundColor:
                      allFilled ? Colors.white : Colors.black45,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: _fillBankSelections.isEmpty
                ? null
                : () => setState(() => _fillBankSelections.clear()),
            icon: const Icon(Icons.clear_all, size: 16),
            label: const Text('ኣጽርይዎ'),
            style: ElevatedButton.styleFrom(
                backgroundColor: _fillBankSelections.isEmpty
                    ? Colors.white.withOpacity(0.35)
                    : Colors.red.shade400,
                foregroundColor: _fillBankSelections.isEmpty
                    ? Colors.black38
                    : Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
        ]),
      ],
      if (_answered) ...[
        const SizedBox(height: 8),
        NextBtn(
            label: _currentIndex < _total - 1
                ? 'ዝስዕብ ሕቶ - Next Question'
                : 'ውጽኢት ርኣዩ - See Results',
            onTap: _next,
            icon: _currentIndex < _total - 1
                ? Icons.arrow_forward
                : Icons.flag),
      ],
    ]);
  }

  // ── Ordering ─────────────────────────────────────────────────────────────
  Widget _buildOrdering() {
    if (_orderingItems.isEmpty) {
      _orderingItems = List<String>.from(_current.options)..shuffle();
    }
    final correctOrder = _current.correctAnswer.split('|');
    final isCorrectOrder =
        _answered && _orderingItems.join('|') == _current.correctAnswer;

    void checkOrder() {
      if (_answered) return;
      final correct =
          _orderingItems.join('|') == _current.correctAnswer;
      setState(() {
        _answered = true;
        if (correct) _score++;
      });
    }

    return Column(children: [
      if (!_answered)
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text('ጎተት ኣቢልካ ስርዓዮ - Drag to reorder',
              style:
                  TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 12),
              textAlign: TextAlign.center),
        ),
      Expanded(
        child: ReorderableListView.builder(
          onReorder: _answered
              ? (_, __) {}
              : (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final item = _orderingItems.removeAt(oldIndex);
                    _orderingItems.insert(newIndex, item);
                  });
                },
          proxyDecorator: (child, index, animation) => Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            shadowColor: const Color(0xFF2E7D32).withOpacity(0.3),
            child: child,
          ),
          itemCount: _orderingItems.length,
          itemBuilder: (_, i) {
            final item = _orderingItems[i];
            Color? bg;
            Color? borderColor;
            if (_answered) {
              final cp = correctOrder.indexOf(item);
              bg = cp == i
                  ? Colors.green.withOpacity(0.15)
                  : Colors.red.withOpacity(0.12);
              borderColor = cp == i ? Colors.green : Colors.red;
            }
            return ClipRRect(
              key: ValueKey(item),
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: bg ?? Colors.white.withOpacity(0.78),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: borderColor ??
                            Colors.white.withOpacity(0.55),
                        width: 1.5),
                  ),
                  child: Row(children: [
                    Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.15),
                            shape: BoxShape.circle),
                        child: Center(
                            child: Text('${i + 1}',
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF2E7D32))))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(item,
                            style: const TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                fontSize: 14,
                                color: Colors.black87))),
                    if (!_answered)
                      ReorderableDragStartListener(
                        index: i,
                        child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(Icons.drag_handle,
                                color: Color(0xFF2E7D32), size: 24)),
                      ),
                    if (_answered)
                      Icon(
                        correctOrder.indexOf(item) == i
                            ? Icons.check_circle
                            : Icons.cancel,
                        color: correctOrder.indexOf(item) == i
                            ? Colors.green
                            : Colors.red,
                        size: 18,
                      ),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
      if (!_answered)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: checkOrder,
              icon: const Icon(Icons.check),
              label: const Text('ምርግጋጽ - Check Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ),
      if (_answered) ...[
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isCorrectOrder
                      ? Colors.green.withOpacity(0.18)
                      : Colors.orange.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isCorrectOrder
                          ? Colors.green
                          : Colors.orange),
                ),
                child: Text(
                  isCorrectOrder
                      ? '🎉 ቅደም ሰዓብ ቅኑዕ እዩ! - Correct order!'
                      : '📋 ቅኑዕ ቅደም ሰዓብ ርአ - Green = correct position',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: isCorrectOrder
                          ? Colors.green[800]
                          : Colors.orange[800],
                      fontFamily: 'AbyssinicaSIL',
                      fontSize: 13),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        NextBtn(
          label: _currentIndex < _total - 1
              ? 'ዝስዕብ ሕቶ - Next Question'
              : 'ውጽኢት ርኣዩ - See Results',
          onTap: _next,
          icon: _currentIndex < _total - 1
              ? Icons.arrow_forward
              : Icons.flag,
        ).animate().fadeIn(duration: 300.ms),
      ],
    ]);
  }

  // ── Exit dialog ──────────────────────────────────────────────────────────
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('ክትወጹ ትደልዩ፧'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ሕቶ ${_currentIndex + 1} ካብ $_total ተመሊሱ ኣሎ።'),
            const SizedBox(height: 6),
            Text('ነጥቢ: $_score ቅኑዕ.',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('ምስ ትወጹ ዝሰራሕኩምዎ ክድምሰስ እዩ።',
                style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 13,
                    fontFamily: 'AbyssinicaSIL')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('ቀጽሎ - Stay')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('ውጻእ - Exit',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// ─── Nature Background ────────────────────────────────────────────────────────

class _NatureBackground extends StatelessWidget {
  const _NatureBackground();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CustomPaint(painter: _NaturePainter()),
    );
  }
}

class _NaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // ── Sky ────────────────────────────────────────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = const Color(0xFF87CEEB),
    );

    // ── Sun ────────────────────────────────────────────────────────────────
    canvas.drawCircle(
      Offset(w * 0.80, h * 0.10),
      w * 0.065,
      Paint()..color = const Color(0xFFFDD835).withOpacity(0.88),
    );
    // Sun rays
    final rayPaint = Paint()
      ..color = const Color(0xFFFDD835).withOpacity(0.55)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;
    final sunCx = w * 0.80;
    final sunCy = h * 0.10;
    final r1 = w * 0.075;
    final r2 = w * 0.095;
    for (int i = 0; i < 8; i++) {
      final angle = i * 3.14159 / 4;
      canvas.drawLine(
        Offset(sunCx + r1 * _cos(angle), sunCy + r1 * _sin(angle)),
        Offset(sunCx + r2 * _cos(angle), sunCy + r2 * _sin(angle)),
        rayPaint,
      );
    }

    // ── Clouds ─────────────────────────────────────────────────────────────
    final cloudPaint = Paint()..color = Colors.white.withOpacity(0.80);
    _drawCloud(canvas, cloudPaint, Offset(w * 0.16, h * 0.09), w * 0.10);
    _drawCloud(canvas, cloudPaint, Offset(w * 0.55, h * 0.07), w * 0.08);
    _drawCloud(canvas, cloudPaint, Offset(w * 0.36, h * 0.13), w * 0.06);

    // ── Back hills ─────────────────────────────────────────────────────────
    final hillBack = Paint()..color = const Color(0xFF81C784);
    final hillBackPath = Path()
      ..moveTo(0, h * 0.60)
      ..quadraticBezierTo(w * 0.20, h * 0.42, w * 0.45, h * 0.54)
      ..quadraticBezierTo(w * 0.72, h * 0.64, w, h * 0.52)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hillBackPath, hillBack);

    // ── Mid hills ──────────────────────────────────────────────────────────
    final hillMid = Paint()..color = const Color(0xFF66BB6A);
    final hillMidPath = Path()
      ..moveTo(0, h * 0.68)
      ..quadraticBezierTo(w * 0.28, h * 0.54, w * 0.52, h * 0.64)
      ..quadraticBezierTo(w * 0.76, h * 0.74, w, h * 0.63)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hillMidPath, hillMid);

    // ── Front hill / ground ────────────────────────────────────────────────
    final hillFront = Paint()..color = const Color(0xFF4CAF50);
    final hillFrontPath = Path()
      ..moveTo(0, h * 0.76)
      ..quadraticBezierTo(w * 0.35, h * 0.64, w * 0.60, h * 0.72)
      ..quadraticBezierTo(w * 0.82, h * 0.80, w, h * 0.70)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();
    canvas.drawPath(hillFrontPath, hillFront);

    // Ground strip
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.84, w, h * 0.16),
      Paint()..color = const Color(0xFF388E3C),
    );

    // ── Trees ──────────────────────────────────────────────────────────────
    _drawTree(canvas, Offset(w * 0.06, h * 0.66), w * 0.038, 1.0);
    _drawTree(canvas, Offset(w * 0.90, h * 0.63), w * 0.038, 1.0);
    _drawTree(canvas, Offset(w * 0.38, h * 0.70), w * 0.028, 0.75);
    _drawTree(canvas, Offset(w * 0.62, h * 0.68), w * 0.030, 0.80);
    _drawTree(canvas, Offset(w * 0.20, h * 0.74), w * 0.022, 0.60);
    _drawTree(canvas, Offset(w * 0.78, h * 0.72), w * 0.024, 0.65);

    // ── Small wildflowers on ground ────────────────────────────────────────
    _drawFlower(canvas, Offset(w * 0.15, h * 0.87), w * 0.012);
    _drawFlower(canvas, Offset(w * 0.45, h * 0.90), w * 0.010);
    _drawFlower(canvas, Offset(w * 0.70, h * 0.88), w * 0.011);
    _drawFlower(canvas, Offset(w * 0.88, h * 0.92), w * 0.009);

    // ── Subtle white veil to keep UI readable ──────────────────────────────
    canvas.drawRect(
      Rect.fromLTWH(0, 0, w, h),
      Paint()..color = Colors.white.withOpacity(0.10),
    );
  }

  void _drawCloud(Canvas canvas, Paint p, Offset center, double r) {
    canvas.drawCircle(center, r, p);
    canvas.drawCircle(center.translate(-r * 0.75, r * 0.25), r * 0.72, p);
    canvas.drawCircle(center.translate(r * 0.75, r * 0.25), r * 0.68, p);
    canvas.drawCircle(center.translate(-r * 0.35, r * 0.35), r * 0.55, p);
    canvas.drawCircle(center.translate(r * 0.35, r * 0.35), r * 0.55, p);
  }

  void _drawTree(
      Canvas canvas, Offset base, double trunkW, double scale) {
    final trunkH = trunkW * 5.5 * scale;
    final crownR = trunkW * 3.8 * scale;

    // Trunk
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            base.dx - trunkW / 2, base.dy - trunkH, trunkW, trunkH),
        Radius.circular(trunkW * 0.4),
      ),
      Paint()..color = const Color(0xFF6D4C41),
    );

    // Crown layers (dark back, bright front)
    canvas.drawCircle(
        Offset(base.dx - crownR * 0.3, base.dy - trunkH - crownR * 0.2),
        crownR * 0.75,
        Paint()..color = const Color(0xFF1B5E20));
    canvas.drawCircle(
        Offset(base.dx + crownR * 0.3, base.dy - trunkH - crownR * 0.25),
        crownR * 0.72,
        Paint()..color = const Color(0xFF2E7D32));
    canvas.drawCircle(
        Offset(base.dx, base.dy - trunkH - crownR * 0.85),
        crownR,
        Paint()..color = const Color(0xFF388E3C));
  }

  void _drawFlower(Canvas canvas, Offset center, double r) {
    final stemPaint = Paint()
      ..color = const Color(0xFF2E7D32)
      ..strokeWidth = r * 0.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
        center, center.translate(0, r * 3), stemPaint);

    final petalPaint = Paint()..color = const Color(0xFFFFF176);
    canvas.drawCircle(center, r, petalPaint);
    canvas.drawCircle(center, r * 0.5,
        Paint()..color = const Color(0xFFFFB300));
  }

  double _cos(double a) => _cosTable(a);
  double _sin(double a) => _sinTable(a);

  double _cosTable(double a) {
    // Simple inline cos via dart:math
    return _mathCos(a);
  }

  double _sinTable(double a) {
    return _mathSin(a);
  }

  // Use dart:math indirectly through these helpers so the file stays
  // self-contained (dart:math is already available via flutter).
  static double _mathCos(double a) {
    // cos approximation good enough for 8 ray directions
    const table = [1.0, 0.7071, 0.0, -0.7071, -1.0, -0.7071, 0.0, 0.7071];
    final idx = ((a / (3.14159 / 4)) % 8).round() % 8;
    return table[idx];
  }

  static double _mathSin(double a) {
    const table = [0.0, 0.7071, 1.0, 0.7071, 0.0, -0.7071, -1.0, -0.7071];
    final idx = ((a / (3.14159 / 4)) % 8).round() % 8;
    return table[idx];
  }

  @override
  bool shouldRepaint(_NaturePainter old) => false;
}

// ─── Small frosted-glass circle helper ───────────────────────────────────────

class _GlassCircle extends StatelessWidget {
  final double size;
  final Widget child;
  const _GlassCircle({required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.70),
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white.withOpacity(0.55), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─── Paragraph Preview Screen ─────────────────────────────────────────────────

class _ParagraphPreviewScreen extends StatelessWidget {
  final Paragraph paragraph;
  const _ParagraphPreviewScreen({required this.paragraph});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: Text(paragraph.title,
            style: const TextStyle(fontFamily: 'AbyssinicaSIL')),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.quiz, size: 16, color: Colors.white),
              label: const Text('ናብ ፈተና',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'AbyssinicaSIL')),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 16),
            color: Colors.amber[100],
            child: const Row(children: [
              Icon(Icons.info_outline, size: 16, color: Colors.amber),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'ሕጡበ ጽሑፍ ኣንቢብካ ናብ ፈተና ተመለስ — Read then return to the quiz',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontFamily: 'AbyssinicaSIL'),
                ),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(
                      child: Text(paragraph.title,
                          style: const TextStyle(
                              fontFamily: 'AbyssinicaSIL',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20))),
                    ),
                    AudioBtn(
                        ttsText: paragraph.tigrigna,
                        audioPath: paragraph.audioPath,
                        size: 44,
                        color: const Color(0xFF2E7D32)),
                  ]),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: Text(paragraph.tigrigna,
                        style: const TextStyle(
                            fontFamily: 'AbyssinicaSIL',
                            fontSize: 18,
                            height: 2.0,
                            color: Color(0xFF1B5E20))),
                  ),
                  const SizedBox(height: 12),
                  _ExpandableTranslation(english: paragraph.english),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, -2))
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.quiz),
                label: const Text('ናብ ፈተና ተመለስ - Back to Quiz',
                    style: TextStyle(
                        fontFamily: 'AbyssinicaSIL', fontSize: 15)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Expandable Translation ───────────────────────────────────────────────────

class _ExpandableTranslation extends StatefulWidget {
  final String english;
  const _ExpandableTranslation({required this.english});
  @override
  State<_ExpandableTranslation> createState() =>
      _ExpandableTranslationState();
}

class _ExpandableTranslationState extends State<_ExpandableTranslation> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.translate,
                  color: Color(0xFF2E7D32), size: 18),
              const SizedBox(width: 8),
              const Text('ትርጉም ብእንግሊዘኛ - English Translation',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2E7D32))),
              const Spacer(),
              Icon(
                  _expanded
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: Colors.grey),
            ]),
            if (_expanded) ...[
              const SizedBox(height: 10),
              Text(widget.english,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      height: 1.6)),
            ],
          ],
        ),
      ),
    );
  }
}