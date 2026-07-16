// lib/screens/level3/listening_challenge_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math';
import '../../data/sentences_data.dart';
import '../../models/sentence.dart';
import '../../widgets/audio_btn.dart';

class ListeningChallengeScreen extends StatefulWidget {
  const ListeningChallengeScreen({super.key});

  @override
  State<ListeningChallengeScreen> createState() =>
      _ListeningChallengeScreenState();
}

class _ListeningChallengeScreenState extends State<ListeningChallengeScreen>
    with TickerProviderStateMixin {
  static const int _totalRounds = 50;
  static const int _optionsCount = 4;
  static const Color _orange = Color(0xFFFF7043);

  late List<Sentence> _gamePool;   // 50 random sentences for this session
  int _round = 0;
  int _score = 0;
  int? _selectedIndex;
  bool _answered = false;
  bool _started = false;          // show intro screen first

  late Sentence _current;
  late List<Sentence> _options;   // 4 choices for current round

  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _buildPool();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  void _buildPool() {
    final all = List<Sentence>.from(sentencesData)..shuffle(Random());
    _gamePool = all.take(_totalRounds).toList();
    _loadRound();
  }

  void _loadRound() {
    _current = _gamePool[_round];
    // Pick 3 random wrong sentences (different from current)
    final others = sentencesData.where((s) => s.id != _current.id).toList()
      ..shuffle(Random());
    final wrong = others.take(_optionsCount - 1).toList();
    _options = [...wrong, _current]..shuffle(Random());
    _selectedIndex = null;
    _answered = false;
  }

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (_options[index].id == _current.id) _score++;
    });
  }

  void _next() {
    if (_round < _totalRounds - 1) {
      setState(() {
        _round++;
        _loadRound();
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    final pct = (_score / _totalRounds * 100).round();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.all(28),
        // Fixed: the dialog content (52px emoji + 64px percentage + score
        // line + message + button row, inside 28px padding) is fixed-size
        // and doesn't shrink. On landscape's short viewport that's taller
        // than the dialog actually has room for, with nowhere for the
        // excess to go — same overflow pattern fixed elsewhere in this
        // screen, now applied here too via SingleChildScrollView.
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(pct >= 80 ? '🎉' : pct >= 50 ? '👍' : '💪',
              style: const TextStyle(fontSize: 52)),
          const SizedBox(height: 8),
          Text('$pct%',
              style: const TextStyle(
                  fontSize: 64, fontWeight: FontWeight.bold, color: _orange, height: 1)),
          const SizedBox(height: 4),
          Text('$_score / $_totalRounds ቅኑዕ - correct',
              style: TextStyle(color: Colors.grey[600], fontSize: 15)),
          const SizedBox(height: 16),
          Text(
            pct >= 80
                ? '🏆 ጽቡቕ ሰሚዕካ! Excellent listening!'
                : pct >= 50
                    ? '👂 ቀጽል ትለምድ! Keep practicing!'
                    : '🔄 ደጊምካ ፈትን! Try again!',
            style: const TextStyle(
                fontFamily: 'AbyssinicaSIL',
                fontSize: 15,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _round = 0;
                    _score = 0;
                    _buildPool();
                    _started = true;
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text('ደጊም - Play Again'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _orange,
                  side: const BorderSide(color: _orange),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.home),
                label: const Text('ወጻእ - Exit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ]),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text('👂 ምስማዕ ምጽዋት - Listening Challenge',
            style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 16)),
        backgroundColor: _orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _started ? _buildGame() : _buildIntro(),
    );
  }

  // ── Intro Screen ─────────────────────────────────────────────────────────────
  // Fixed: this used to be a plain Center → fixed Column with
  // mainAxisAlignment.center. Centering only works when the content
  // (80px icon + title + subtitle + 3 rule cards + spacing + Start button)
  // actually fits — it can't shrink content taller than the screen. On a
  // landscape viewport (much shorter) that produced a huge overflow
  // (390px), and even portrait had a smaller but real overflow (100px) on
  // this device. Wrapping in SingleChildScrollView + ConstrainedBox
  // (minHeight) keeps the same centered look when it fits, but scrolls
  // instead of overflowing when it doesn't — same fix applied earlier to
  // the quiz result screen.
  Widget _buildIntro() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight - 56),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('👂', style: TextStyle(fontSize: 80))
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              const Text('ምስማዕ ምጽዋት',
                  style: TextStyle(
                      fontFamily: 'AbyssinicaSIL',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: _orange)),
              const Text('Listening Challenge',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 32),
              _ruleCard(Icons.volume_up_rounded,
                  'ድምጺ ስማዕ', 'Listen to the audio'),
              const SizedBox(height: 10),
              _ruleCard(Icons.touch_app_rounded,
                  'ቅኑዕ ምሉእ ሓሳብ ምረጽ', 'Pick the correct sentence'),
              const SizedBox(height: 10),
              _ruleCard(Icons.format_list_numbered_rounded,
                  '50 ሕቶ', '50 random sentences each game'),
              const SizedBox(height: 36),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => setState(() => _started = true),
                  icon: const Icon(Icons.play_arrow_rounded, size: 26),
                  label: const Text('ጀምር - Start',
                      style: TextStyle(
                          fontFamily: 'AbyssinicaSIL', fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 4,
                  ),
                ),
              ).animate().slideY(begin: 0.5, duration: 500.ms),
            ],
          ),
        ),
      );
    });
  }

  Widget _ruleCard(IconData icon, String tigrigna, String english) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _orange.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
              color: _orange.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Row(children: [
        Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
              color: _orange.withOpacity(0.12), shape: BoxShape.circle),
          child: Icon(icon, color: _orange, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(tigrigna,
                style: const TextStyle(
                    fontFamily: 'AbyssinicaSIL',
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            Text(english,
                style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ]),
        ),
      ]),
    );
  }

  // ── Game Screen ───────────────────────────────────────────────────────────────
  // Fixed: the audio card (32px padding, 80px icon, title, subtitle, 64px
  // play button) used to sit stacked ABOVE the answer options in one
  // scrollable column. In portrait that pushed option A almost entirely off
  // the initial view; in landscape (much shorter viewport) it filled the
  // ENTIRE screen with zero options visible at all. The card is now
  // significantly more compact, and landscape uses a side-by-side layout
  // (card fixed-width on the left, options get the full available height on
  // the right) instead of fighting over the same scarce vertical space —
  // same fix pattern applied earlier to sentence_image_match.dart.
  Widget _buildGame() {
    final progress = (_round + 1) / _totalRounds;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(children: [
      // Top progress strip
      Container(
        padding: EdgeInsets.fromLTRB(16, isLandscape ? 6 : 10, 16, isLandscape ? 8 : 12),
        color: _orange.withOpacity(0.08),
        child: Column(children: [
          Row(children: [
            Text('ሕቶ ${_round + 1} / $_totalRounds',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: _orange, fontSize: 13)),
            const Spacer(),
            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
            const SizedBox(width: 4),
            Text('$_score',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation(_orange),
              minHeight: 8,
            ),
          ),
        ]),
      ),

      Expanded(
        child: isLandscape
            ? Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SizedBox(
                  width: 220,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12),
                    child: _audioCard(compact: true),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
                    child: Column(children: [
                      ..._optionTiles(),
                      const SizedBox(height: 4),
                      if (_answered) _nextButton(),
                    ]),
                  ),
                ),
              ])
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  _audioCard(compact: false),
                  const SizedBox(height: 16),
                  ..._optionTiles(),
                  const SizedBox(height: 8),
                  if (_answered) _nextButton(),
                ]),
              ),
      ),
    ]);
  }

  // ── Audio play card — sized much smaller than before, with a compact
  // variant used in landscape's narrower left column. ─────────────────────
  Widget _audioCard({required bool compact}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: compact ? 14 : 18, horizontal: compact ? 12 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_orange.withOpacity(0.12), _orange.withOpacity(0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _orange.withOpacity(0.25), width: 1.5),
      ),
      child: Column(children: [
        // Pulsing ear icon
        AnimatedBuilder(
          animation: _pulseCtrl,
          builder: (_, __) => Transform.scale(
            scale: 1.0 + _pulseCtrl.value * 0.12,
            child: Container(
              width: compact ? 48 : 56,
              height: compact ? 48 : 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _orange.withOpacity(0.15 + _pulseCtrl.value * 0.08),
              ),
              child: Icon(Icons.hearing_rounded,
                  color: _orange, size: compact ? 26 : 30),
            ),
          ),
        ),
        SizedBox(height: compact ? 10 : 12),
        Text('ድምጺ ስማዕ',
            style: TextStyle(
                fontFamily: 'AbyssinicaSIL',
                fontSize: compact ? 15 : 17,
                fontWeight: FontWeight.bold,
                color: _orange)),
        if (!compact) ...[
          const SizedBox(height: 2),
          const Text('Listen and choose the correct sentence',
              style: TextStyle(color: Colors.grey, fontSize: 11),
              textAlign: TextAlign.center),
        ],
        SizedBox(height: compact ? 10 : 12),
        AudioBtn(
          audioPath: _current.audioPath,
          ttsText: _current.tigrigna,
          size: compact ? 44 : 52,
          color: _orange,
        ),
        if (_answered) ...[
          SizedBox(height: compact ? 10 : 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _orange.withOpacity(0.3)),
            ),
            child: Text(
              _current.tigrigna,
              style: TextStyle(
                  fontFamily: 'AbyssinicaSIL',
                  fontSize: compact ? 14 : 16,
                  fontWeight: FontWeight.bold,
                  color: _orange),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3),
          const SizedBox(height: 3),
          Text(_current.english,
                  style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  textAlign: TextAlign.center)
              .animate()
              .fadeIn(delay: 100.ms),
        ],
      ]),
    ).animate().scale(
        duration: 400.ms,
        curve: Curves.easeOut,
        begin: const Offset(0.95, 0.95),
        end: const Offset(1, 1));
  }

  // ── Answer option tiles — shared by both layouts ─────────────────────────
  List<Widget> _optionTiles() {
    return List.generate(_optionsCount, (i) {
      final option = _options[i];
      final isCorrect = option.id == _current.id;
      final isSelected = _selectedIndex == i;

      Color bg = Colors.white;
      Color border = Colors.grey[200]!;
      Color textColor = Colors.black87;
      Widget? trailingIcon;

      if (_answered) {
        if (isCorrect) {
          bg = Colors.green.withOpacity(0.1);
          border = Colors.green;
          textColor = Colors.green[800]!;
          trailingIcon = const Icon(Icons.check_circle_rounded,
              color: Colors.green, size: 22);
        } else if (isSelected) {
          bg = Colors.red.withOpacity(0.08);
          border = Colors.red;
          textColor = Colors.red[800]!;
          trailingIcon =
              const Icon(Icons.cancel_rounded, color: Colors.red, size: 22);
        }
      } else if (isSelected) {
        bg = _orange.withOpacity(0.1);
        border = _orange;
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: GestureDetector(
          onTap: () => _selectOption(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: border, width: 1.8),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2))
              ],
            ),
            child: Row(children: [
              // Option letter badge
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _answered
                      ? (isCorrect
                          ? Colors.green.withOpacity(0.15)
                          : isSelected
                              ? Colors.red.withOpacity(0.12)
                              : Colors.grey[100])
                      : _orange.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + i), // A B C D
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _answered
                            ? (isCorrect
                                ? Colors.green[700]
                                : isSelected
                                    ? Colors.red[700]
                                    : Colors.grey[500])
                            : _orange),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(option.tigrigna,
                        style: TextStyle(
                            fontFamily: 'AbyssinicaSIL',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor)),
                    Text(option.english,
                        style: TextStyle(
                            fontSize: 11,
                            color: _answered
                                ? textColor.withOpacity(0.7)
                                : Colors.grey[500])),
                  ],
                ),
              ),
              if (trailingIcon != null) trailingIcon,
            ]),
          ),
        ).animate().slideX(
            begin: 0.15, delay: (i * 60).ms, duration: 300.ms, curve: Curves.easeOut),
      );
    });
  }

  // ── Next / See Results button — shared by both layouts ───────────────────
  Widget _nextButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _next,
        icon: Icon(_round < _totalRounds - 1
            ? Icons.arrow_forward_rounded
            : Icons.flag_rounded),
        label: Text(
          _round < _totalRounds - 1 ? 'ዝስዕብ - Next' : 'ውጽኢት ርኣዩ - See Results',
          style: const TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: _orange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    ).animate().slideY(begin: 0.5, duration: 300.ms);
  }
}