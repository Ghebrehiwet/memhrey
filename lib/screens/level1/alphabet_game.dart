// lib/screens/level1/alphabet_game.dart

import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/alphabet_data.dart';
import '../../providers/progress_provider.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────

class _FallingLetter {
  final int id;
  final String character;
  final String romanization;
  final String audioPath;
  double x;
  double y;
  final double speed;
  bool hit = false;
  bool missed = false;

  _FallingLetter({
    required this.id,
    required this.character,
    required this.romanization,
    required this.audioPath,
    required this.x,
    required this.y,
    required this.speed,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// GAME SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class AlphabetGameScreen extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;
  const AlphabetGameScreen(
      {super.key, required this.setIndex, required this.set});

  @override
  State<AlphabetGameScreen> createState() => _AlphabetGameScreenState();
}

class _AlphabetGameScreenState extends State<AlphabetGameScreen> {
  static const int _totalRounds = 3;
  static const int _tickMs = 16;
  static const double _tileSize = 64;
  static const double _baseSpeed = 2.2;

  final AudioPlayer _player = AudioPlayer();
  final Random _rng = Random();
  int _nextId = 0;

  bool _started = false;
  bool _roundComplete = false;
  bool _gameOver = false;
  int _round = 1;
  int _score = 0;
  int _hits = 0;
  int _totalTargets = 0;

  AlphabetLetter? _target;
  List<AlphabetLetter> _queue = [];
  List<_FallingLetter> _fallers = [];

  String? _feedbackText;
  Color _feedbackColor = Colors.green;

  Timer? _tickTimer;
  Timer? _nextTimer;

  double _screenW = 400;
  double _screenH = 700;

  @override
  void dispose() {
    _tickTimer?.cancel();
    _nextTimer?.cancel();
    _player.dispose();
    super.dispose();
  }

  void _startRound() {
    _tickTimer?.cancel();
    _nextTimer?.cancel();
    setState(() {
      _started = true;
      _roundComplete = false;
      _fallers.clear();
      _target = null;
      _queue = List.from(widget.set.letters)..shuffle();
      _totalTargets += _queue.length;
    });
    _tickTimer =
        Timer.periodic(Duration(milliseconds: _tickMs), (_) => _tick());
    Future.delayed(const Duration(milliseconds: 500), _announceNext);
  }

  // Restarts the tick timer if it isn't already running. Used both by
  // _startRound (fresh round) and by the Back-button "Continue" path
  // (resuming after the tick timer was paused for the confirmation dialog).
  void _resumeTicking() {
    if (_tickTimer != null && _tickTimer!.isActive) return;
    _tickTimer =
        Timer.periodic(Duration(milliseconds: _tickMs), (_) => _tick());
  }

  void _tick() {
    if (!mounted) return;
    setState(() {
      for (final f in _fallers) {
        if (!f.hit && !f.missed) {
          f.y += f.speed;
          if (f.y > _screenH + _tileSize) {
            f.missed = true;
            if (_target != null && f.character == _target!.character) {
              _feedback('Missed!  ${_target!.character}', Colors.orange);
              _scheduleNext(1600);
            }
          }
        }
      }
      _fallers.removeWhere(
          (f) => f.missed && f.y > _screenH + _tileSize * 2);
    });
  }

  Future<void> _playAudio(String audioPath) async {
    try {
      await _player.stop();
      await _player.play(AssetSource(audioPath.replaceFirst('assets/', '')));
    } catch (e) {
      debugPrint('Game audio error: $e');
    }
  }

  void _announceNext() {
    if (!mounted) return;
    if (_queue.isEmpty) { _finishRound(); return; }

    final letter = _queue.removeAt(0);
    setState(() {
      _target = letter;
      _fallers.clear();
    });
    _playAudio(letter.audioPath);

    final letters = List<AlphabetLetter>.from(widget.set.letters)..shuffle();
    final double spacing = (_screenW - _tileSize) / (letters.length - 1);

    // Speed is scaled by the SHORTER of width/height, not by height alone.
    // Height swaps between orientations (tall in portrait, short in
    // landscape), so scaling off height alone made portrait sit near the
    // 1.0 speed clamp (near-max speed) while landscape sat much lower —
    // bubbles visibly fell faster in portrait than landscape on the same
    // device. The shorter dimension stays roughly constant across
    // rotation (portrait width ≈ landscape height), so this keeps fall
    // speed consistent regardless of orientation.
    const double referenceDim = 600.0;
    final double shortDimension =
        _screenW < _screenH ? _screenW : _screenH;
    final double speedScale = (shortDimension / referenceDim).clamp(0.35, 1.0);
    final double effectiveBase = _baseSpeed * speedScale;
    final double effectiveJitter = 0.8 * speedScale;
    final int staggerMs = _screenH < 350 ? 340 : 220;

    for (int i = 0; i < letters.length; i++) {
      Future.delayed(Duration(milliseconds: i * staggerMs), () {
        if (!mounted) return;
        final double baseX = spacing * i + _rng.nextDouble() * 20 - 10;
        final double clampedX = baseX.clamp(4, _screenW - _tileSize - 4);
        setState(() {
          _fallers.add(_FallingLetter(
            id: _nextId++,
            character: letters[i].character,
            romanization: letters[i].romanization,
            audioPath: letters[i].audioPath,
            x: clampedX,
            y: -_tileSize - _rng.nextDouble() * 40,
            speed: effectiveBase + _rng.nextDouble() * effectiveJitter,
          ));
        });
      });
    }
  }

  void _scheduleNext(int delayMs) {
    _nextTimer?.cancel();
    _nextTimer = Timer(Duration(milliseconds: delayMs), () {
      if (!mounted) return;
      setState(() => _fallers.clear());
      _announceNext();
    });
  }

  void _finishRound() {
    _tickTimer?.cancel();
    if (_round < _totalRounds) {
      setState(() { _roundComplete = true; _round++; });
    } else {
      setState(() => _gameOver = true);
    }
  }

  void _onTap(_FallingLetter f) {
    if (f.hit || f.missed || _target == null) return;
    final correct = f.character == _target!.character;
    setState(() {
      f.hit = true;
      if (correct) {
        _hits++;
        _score += 10;
        _feedback('✓  ${f.character}', Colors.green);
        _playAudio(f.audioPath);
        _scheduleNext(1400);
      } else {
        _score = max(0, _score - 3);
        _feedback('✗  Try: ${_target!.romanization}', Colors.red);
        Future.delayed(const Duration(milliseconds: 700), () {
          if (mounted && _target != null) _playAudio(_target!.audioPath);
        });
      }
    });
  }

  void _feedback(String text, Color color) {
    setState(() { _feedbackText = text; _feedbackColor = color; });
    Future.delayed(const Duration(milliseconds: 1100), () {
      if (mounted) setState(() => _feedbackText = null);
    });
  }

  Future<void> _saveAndExit() async {
    _tickTimer?.cancel();
    _nextTimer?.cancel();
    await context
        .read<ProgressProvider>()
        .markAlphabetActivity(widget.setIndex, 'game');
    if (mounted) Navigator.pop(context);
  }

  // Shows the exit-confirmation dialog. Only the tick timer is paused for
  // the duration of the prompt (freezing the falling-letter animation so it
  // doesn't visually churn behind the dialog) — _nextTimer is left running.
  // Previously BOTH timers were cancelled before the dialog, but only the
  // "Exit" branch ever restarted anything; choosing "Continue" left the
  // game permanently frozen with no timer driving it. Now "Continue"
  // explicitly resumes ticking, and _nextTimer (which schedules things like
  // "show the next letter after a hit/miss") was never touched, so any
  // transition that was pending continues normally once ticking resumes.
  Future<void> _confirmExit() async {
    _tickTimer?.cancel();
    final exit = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A2A3A),
        title: const Text('ጌም ግደፍ?', style: TextStyle(color: Colors.white)),
        content: const Text(
            'ናብ ድሕሪ ምምላስ ምርጫ ምግባር ይፈቀደልካ - Progress will be saved.',
            style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('ቀጽሉ - Continue',
                style: TextStyle(color: Colors.amber)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('ውጻእ - Exit', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (exit == true) {
      if (mounted) await _saveAndExit();
    } else if (mounted && !_gameOver && !_roundComplete) {
      _resumeTicking();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_gameOver) return _buildGameOver();
    if (!_started) return _buildIntro();
    if (_roundComplete) return _buildRoundComplete();
    return _buildGame();
  }

  Widget _buildIntro() {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final titleFontSize = isLandscape ? 26.0 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B2A),
        foregroundColor: Colors.white70,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.set.letters.map((l) => l.character).join('  '),
          style: TextStyle(
            fontFamily: 'AbyssinicaSIL',
            fontSize: titleFontSize,
            color: Colors.amber,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text('🎮', style: TextStyle(fontSize: 64))
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 16),
              const Text('ነታ ፊደል ሓዝዋ! - Catch the Letter!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)
                  .animate()
                  .fadeIn(delay: 300.ms),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(children: [
                  _Row(emoji: '🔊', text: 'ንዝቃላሕ ድምጺ ስምዑ - Listen to the letter announced'),
                  SizedBox(height: 10),
                  _Row(emoji: '👆', text: 'ምስ\'ቲ ዝሰማዕክምዎ ድምጺ ትዛመድ ፊደል ህረሙ - Tap the matching falling letter'),
                  SizedBox(height: 10),
                  _Row(emoji: '🔁', text: '3 ዙርያ ፡ ነፍስ ወከፍ ፊደል 7 ግዜ === 3 rounds — all 7 letters each round'),
                  SizedBox(height: 10),
                  _Row(emoji: '⭐', text: '+10 correct   −3 wrong'),
                ]),
              ).animate().fadeIn(delay: 400.ms),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startRound,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 8,
                  ),
                  child: const Text('ጌም ጀምሩ! - Start Game!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ).animate().scale(delay: 600.ms, duration: 400.ms, curve: Curves.elasticOut),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGame() {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: Column(children: [
          Container(
            color: const Color(0xFF1A2A3A),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              GestureDetector(
                onTap: _confirmExit,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.arrow_back_ios_new, color: Colors.white70, size: 14),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ]),
                ),
              ),
              const SizedBox(width: 10),
              Text('Round $_round / $_totalRounds',
                  style: const TextStyle(color: Colors.white60, fontSize: 13)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('⭐  $_score',
                    style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () {
              if (_target != null) _playAudio(_target!.audioPath);
            },
            child: Container(
              width: double.infinity,
              color: const Color(0xFF142030),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _target == null
                  ? const Center(
                      child: Text('Get ready…',
                          style: TextStyle(color: Colors.white30, fontSize: 13)))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.volume_up, color: Colors.amber, size: 18),
                        const SizedBox(width: 8),
                        const Text('ሓዝዋ: - Catch: ',
                            style: TextStyle(color: Colors.white54, fontSize: 14)),
                        Text(_target!.romanization,
                            style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        const Text('(tap to replay)',
                            style: TextStyle(color: Colors.white24, fontSize: 11)),
                      ],
                    ),
            ),
          ),
          Expanded(
            child: LayoutBuilder(builder: (ctx, constraints) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_screenW != constraints.maxWidth ||
                    _screenH != constraints.maxHeight) {
                  _screenW = constraints.maxWidth;
                  _screenH = constraints.maxHeight;
                }
              });

              return Stack(clipBehavior: Clip.hardEdge, children: [
                const Positioned.fill(child: _Starfield()),
                for (final f in _fallers)
                  if (!f.missed)
                    Positioned(
                      left: f.x,
                      top: f.y,
                      child: GestureDetector(
                        onTap: () => _onTap(f),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 150),
                          opacity: f.hit ? 0 : 1,
                          child: Container(
                            width: _tileSize,
                            height: _tileSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: f.hit
                                    ? [Colors.green, Colors.green.shade800]
                                    : [const Color(0xFF7C4DFF), const Color(0xFF4A2CC0)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: (f.hit ? Colors.green : const Color(0xFF7C4DFF))
                                      .withValues(alpha: 0.55),
                                  blurRadius: 14,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Center(
                              child: Text(f.character,
                                  style: const TextStyle(
                                    fontFamily: 'AbyssinicaSIL',
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                if (_feedbackText != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                      decoration: BoxDecoration(
                        color: _feedbackColor.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: _feedbackColor.withValues(alpha: 0.45),
                              blurRadius: 18)
                        ],
                      ),
                      child: Text(_feedbackText!,
                          style: const TextStyle(
                              fontFamily: 'AbyssinicaSIL',
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                    ).animate().scale(duration: 180.ms, curve: Curves.elasticOut),
                  ),
              ]);
            }),
          ),
        ]),
      ),
    );
  }

  Widget _buildRoundComplete() {
    final acc = _totalTargets > 0 ? (_hits / _totalTargets * 100).toInt() : 0;
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                'ዙርያ ${_round - 1} ተወዲኡ! - Round ${_round - 1} Complete!',
                style: const TextStyle(
                    color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ).animate().fadeIn(),
              const SizedBox(height: 24),
              _Stat(label: 'ነጥቢ - Score', value: '$_score ⭐'),
              const SizedBox(height: 8),
              _Stat(label: 'ልክዕነት - Accuracy', value: '$acc%'),
              const SizedBox(height: 8),
              _Stat(label: 'ዝተሃርሙ - Hits', value: '$_hits / $_totalTargets'),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _startRound,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'ዙር $_round - Round $_round →',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ).animate().scale(delay: 300.ms, curve: Curves.elasticOut),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOver() {
    final acc = _totalTargets > 0 ? (_hits / _totalTargets * 100).toInt() : 0;
    final stars = acc >= 90 ? 3 : acc >= 70 ? 2 : acc >= 50 ? 1 : 0;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(stars >= 2 ? '🏆' : '🎮',
                      style: const TextStyle(fontSize: 64))
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut),
              const SizedBox(height: 12),
              Text(
                stars == 3
                    ? 'ጽቡቕ! - Perfect!'
                    : stars == 2
                        ? 'ዓቢ ስራሕ! - Great Job!'
                        : stars == 1
                            ? 'ጽቡቕ ፈተነ - Good Try!'
                            : 'ልምምድ ቀጽሉ! - Keep Practicing!',
                style: const TextStyle(
                    color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 8),
              Text('⭐' * stars + '☆' * (3 - stars),
                      style: const TextStyle(fontSize: 36))
                  .animate()
                  .fadeIn(delay: 400.ms),
              const SizedBox(height: 20),
              // Stats card — flexible layout prevents overflow
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.07),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(children: [
                  _Stat(label: 'Final Score', value: '$_score ⭐'),
                  const SizedBox(height: 8),
                  _Stat(label: 'Accuracy', value: '$acc%'),
                  const SizedBox(height: 8),
                  _Stat(label: 'Correct Catches', value: '$_hits / $_totalTargets'),
                  const SizedBox(height: 8),
                  _Stat(label: 'Rounds', value: '$_totalRounds completed'),
                ]),
              ).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 24),
              // Buttons — smaller text, flexible width
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() {
                      _round = 1;
                      _score = 0;
                      _hits = 0;
                      _totalTargets = 0;
                      _gameOver = false;
                      _started = false;
                      _fallers.clear();
                      _target = null;
                    }),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: const BorderSide(color: Colors.white30),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Play Again',
                        style: TextStyle(fontSize: 13),
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _saveAndExit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text(
                      'Save & Continue ✓',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]).animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HELPER WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class _Row extends StatelessWidget {
  final String emoji, text;
  const _Row({required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) => Row(children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 12),
        Expanded(
            child: Text(text,
                style: const TextStyle(color: Colors.white70, fontSize: 13))),
      ]);
}

class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(color: Colors.white54, fontSize: 13)),
          ),
          const SizedBox(width: 8),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ],
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// STARFIELD
// ─────────────────────────────────────────────────────────────────────────────

class _Starfield extends StatefulWidget {
  const _Starfield();

  @override
  State<_Starfield> createState() => _StarfieldState();
}

class _StarfieldState extends State<_Starfield>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _rng = Random(7);
  late List<_StarDot> _stars;

  @override
  void initState() {
    super.initState();
    _stars = List.generate(
        55,
        (_) => _StarDot(
              x: _rng.nextDouble(),
              y: _rng.nextDouble(),
              r: 0.8 + _rng.nextDouble() * 1.8,
              base: 0.25 + _rng.nextDouble() * 0.55,
              phase: _rng.nextDouble() * 2 * pi,
            ));
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 3))
      ..repeat();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) => CustomPaint(
          painter: _StarPainter(_stars, _ctrl.value),
          child: const SizedBox.expand(),
        ),
      );
}

class _StarDot {
  final double x, y, r, base, phase;
  const _StarDot(
      {required this.x,
      required this.y,
      required this.r,
      required this.base,
      required this.phase});
}

class _StarPainter extends CustomPainter {
  final List<_StarDot> stars;
  final double t;
  const _StarPainter(this.stars, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final s in stars) {
      final blink = (sin(t * 2 * pi + s.phase) + 1) / 2;
      paint.color = Colors.white.withValues(alpha: s.base * (0.4 + 0.6 * blink));
      canvas.drawCircle(
          Offset(s.x * size.width, s.y * size.height), s.r, paint);
    }
  }

  @override
  bool shouldRepaint(_StarPainter o) => o.t != t;
}