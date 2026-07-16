// lib/screens/level3/sentence_image_match.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../models/sentence.dart';
import '../../data/sentences_data.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

class SentenceImageMatchScreen extends StatefulWidget {
  final Sentence sentence;
  const SentenceImageMatchScreen({super.key, required this.sentence});

  @override
  State<SentenceImageMatchScreen> createState() =>
      _SentenceImageMatchScreenState();
}

class _SentenceImageMatchScreenState
    extends State<SentenceImageMatchScreen> {
  late List<Sentence> _options;
  String? _selectedId;
  bool _answered = false;

  // ── Celebration ────────────────────────────────────────────────────────────
  late ConfettiController _confettiCenter;
  late ConfettiController _confettiLeft;
  late ConfettiController _confettiRight;
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const List<Color> _confettiColors = [
    Color(0xFFFF7043),
    Color(0xFF4CAF50),
    Colors.amber,
    Colors.pink,
    Colors.deepPurple,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();
    _confettiCenter = ConfettiController(duration: const Duration(seconds: 4));
    _confettiLeft   = ConfettiController(duration: const Duration(seconds: 4));
    _confettiRight  = ConfettiController(duration: const Duration(seconds: 4));
    _buildOptions();
  }

  @override
  void dispose() {
    _confettiCenter.dispose();
    _confettiLeft.dispose();
    _confettiRight.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  // ── Game logic ─────────────────────────────────────────────────────────────

  void _buildOptions() {
    final others =
        sentencesData.where((s) => s.id != widget.sentence.id).toList()
          ..shuffle();
    _options = [widget.sentence, ...others.take(3)]..shuffle();
  }

  void _onSelect(String id) {
    if (_answered) return;
    setState(() { _selectedId = id; _answered = true; });
    if (id == widget.sentence.id) _celebrate();
  }

  void _celebrate() {
    _confettiCenter.play();
    _confettiLeft.play();
    _confettiRight.play();
    _audioPlayer.play(AssetSource('audio/success_chime.mp3'));
  }

  Future<void> _next() async {
    if (_selectedId == widget.sentence.id) {
      await context
          .read<ProgressProvider>()
          .markSentenceDone(widget.sentence.id);
    }
    if (mounted) Navigator.pop(context);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Stack(
      children: [
        // ── Main scaffold ──────────────────────────────────────────────────
        Scaffold(
          backgroundColor: const Color(0xFFFFF3E0),
          appBar: AppBar(
            title: const Text('ምዝማድ ምሉእ ሓሳብ - Sentence Match',
                style: TextStyle(fontFamily: 'AbyssinicaSIL')),
            backgroundColor: const Color(0xFFFF7043),
            foregroundColor: Colors.white,
          ),
          // Landscape gets a genuinely different, side-by-side layout
          // instead of the same vertical stack squeezed smaller. Stacking
          // image+instructions above the options list means that fixed
          // block eats almost the entire (short) landscape height before
          // the options even get a turn — that's what produced both the
          // overflow and the near-invisible option list. Putting the image
          // beside the options instead uses landscape's spare WIDTH rather
          // than fighting over its scarce height. Portrait is untouched.
          body: isLandscape ? _buildLandscape() : _buildPortrait(),
        ),

        // ── Confetti cannons ───────────────────────────────────────────────

        // Top-center: explosive burst
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiCenter,
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 35,
            maxBlastForce: 35,
            minBlastForce: 12,
            emissionFrequency: 0.04,
            gravity: 0.25,
            colors: _confettiColors,
          ),
        ),

        // Top-left: shoots toward center-right (~30°)
        Align(
          alignment: Alignment.topLeft,
          child: ConfettiWidget(
            confettiController: _confettiLeft,
            blastDirection: 0.5,
            numberOfParticles: 20,
            maxBlastForce: 28,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: _confettiColors,
          ),
        ),

        // Top-right: shoots toward center-left (~150°)
        Align(
          alignment: Alignment.topRight,
          child: ConfettiWidget(
            confettiController: _confettiRight,
            blastDirection: 2.6,
            numberOfParticles: 20,
            maxBlastForce: 28,
            minBlastForce: 10,
            emissionFrequency: 0.05,
            gravity: 0.3,
            colors: _confettiColors,
          ),
        ),
      ],
    );
  }

  // ── Portrait: original vertical stack, unchanged ────────────────────────
  Widget _buildPortrait() {
    final s = widget.sentence;
    final correct = _selectedId == s.id;

    return Column(children: [
      // ── Fixed top: image + audio ──────────────────────────────────
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
        child: Column(children: [
          const Text(
            'ምስዚ ምስሊ ዝመሳሰል ምሉእ ሓሳብ - Which sentence matches this scene?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              s.imagePath ?? '',
              width: double.infinity,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF7043).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(s.emoji, style: const TextStyle(fontSize: 80)),
                ),
              ),
            ),
          ).animate().fadeIn(duration: 300.ms),
          const SizedBox(height: 10),
          Row(children: [
            const Text('ስማዕ - Listen:',
                style: TextStyle(color: Colors.black54, fontSize: 13)),
            const SizedBox(width: 10),
            AudioBtn(
                ttsText: s.tigrigna,
                audioPath: s.audioPath,
                size: 36,
                color: const Color(0xFFFF7043)),
          ]),
          const SizedBox(height: 10),
        ]),
      ),

      // ── Answer options ────────────────────────────────────────────
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          itemCount: _options.length,
          itemBuilder: (ctx, i) => _optionTile(i, compact: false),
        ),
      ),

      // ── Feedback + Continue ───────────────────────────────────────
      if (_answered) _feedbackAndContinue(correct, compact: false),
    ]);
  }

  // ── Landscape: image/audio on the left (fixed width), options + feedback
  // on the right (gets all the available height). ─────────────────────────
  Widget _buildLandscape() {
    final s = widget.sentence;
    final correct = _selectedId == s.id;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 220,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
            // Wrapped in SingleChildScrollView: this column's height is
            // bounded (stretched to match the Row), but its content
            // (instruction text — which can wrap to 3 lines at this
            // narrower 220px width — plus the image and audio row) could
            // be taller than some landscape viewports actually provide.
            // Scrolling is the safety net; the size trims below reduce how
            // often it's actually needed.
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'ምስዚ ምስሊ ዝመሳሰል ምሉእ ሓሳብ - Which sentence matches this scene?',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      s.imagePath ?? '',
                      width: double.infinity,
                      height: 110,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7043).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Text(s.emoji,
                              style: const TextStyle(fontSize: 48)),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(duration: 300.ms),
                  const SizedBox(height: 8),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text('ስማዕ:',
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                    const SizedBox(width: 8),
                    AudioBtn(
                        ttsText: s.tigrigna,
                        audioPath: s.audioPath,
                        size: 32,
                        color: const Color(0xFFFF7043)),
                  ]),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 12, 16, 4),
                itemCount: _options.length,
                itemBuilder: (ctx, i) => _optionTile(i, compact: true),
              ),
            ),
            if (_answered)
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 16, 8),
                child: _feedbackAndContinueContent(correct, compact: true),
              ),
          ]),
        ),
      ],
    );
  }

  // ── Shared option tile builder ───────────────────────────────────────────
  Widget _optionTile(int i, {required bool compact}) {
    final s = widget.sentence;
    final opt = _options[i];
    final isSelected = _selectedId == opt.id;
    final isCorrect = opt.id == s.id;
    Color bg = Colors.white;
    Color border = Colors.grey[300]!;
    if (_answered && isSelected) {
      bg = isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE);
      border = isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336);
    } else if (_answered && isCorrect) {
      bg = const Color(0xFFE8F5E9);
      border = const Color(0xFF4CAF50);
    }
    return GestureDetector(
      onTap: () => _onSelect(opt.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: EdgeInsets.only(bottom: compact ? 6 : 10),
        padding: EdgeInsets.all(compact ? 10 : 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 2),
          boxShadow: (_answered && isCorrect)
              ? [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.25),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : [
                  BoxShadow(
                    color: border.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(children: [
          Container(
            width: 28,
            height: 28,
            decoration:
                BoxDecoration(color: border.withOpacity(0.15), shape: BoxShape.circle),
            child: Center(
              child: Text(['A', 'B', 'C', 'D'][i],
                  style: TextStyle(
                      color: border, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(opt.tigrigna,
                    style: TextStyle(
                        fontFamily: 'AbyssinicaSIL',
                        fontSize: compact ? 14 : 17,
                        fontWeight: FontWeight.w600)),
                Text(opt.english,
                    style: TextStyle(color: Colors.grey[500], fontSize: 11)),
              ],
            ),
          ),
          if (_answered && isSelected)
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: isCorrect ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
            ),
        ]),
      ),
    ).animate().slideX(begin: 0.3, end: 0, delay: (i * 60).ms, duration: 300.ms);
  }

  // ── Portrait wrapper (adds outer padding matching the old layout) ───────
  Widget _feedbackAndContinue(bool correct, {required bool compact}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: _feedbackAndContinueContent(correct, compact: compact),
    );
  }

  // ── Shared feedback banner + continue button ─────────────────────────────
  Widget _feedbackAndContinueContent(bool correct, {required bool compact}) {
    final s = widget.sentence;
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: compact ? 8 : 12),
        decoration: BoxDecoration(
          color: correct ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: correct ? const Color(0xFF4CAF50) : const Color(0xFFF44336),
            width: 1.5,
          ),
          boxShadow: correct
              ? [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.25),
                    blurRadius: 12,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Row(children: [
          Text(correct ? '🎉' : '❌',
              style: TextStyle(fontSize: compact ? 18 : 20)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              correct ? 'ቅኑዕ - Correct!' : 'መልሲ: ${s.tigrigna}',
              style: TextStyle(
                fontFamily: 'AbyssinicaSIL',
                color: correct
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFC62828),
                fontWeight: FontWeight.bold,
                fontSize: compact ? 13 : 15,
              ),
            ),
          ),
        ]),
      ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.2, end: 0),
      const SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _next,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                correct ? const Color(0xFF4CAF50) : const Color(0xFFFF7043),
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: compact ? 8 : 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          child: Text(
            correct ? 'ጹቡቕ ቀጽል! - Great, Continue! →' : 'ቀጽል - Continue',
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ).animate().fadeIn(duration: 250.ms),
    ]);
  }
}