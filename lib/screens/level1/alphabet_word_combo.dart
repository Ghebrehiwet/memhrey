// lib/screens/level1/alphabet_word_combo.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/alphabet_data.dart';
import '../../providers/progress_provider.dart';
import '../../widgets/widgets.dart';

class AlphabetWordComboScreen extends StatefulWidget {
  final int setIndex;
  final AlphabetSet set;

  const AlphabetWordComboScreen({
    super.key,
    required this.setIndex,
    required this.set,
  });

  @override
  State<AlphabetWordComboScreen> createState() =>
      _AlphabetWordComboScreenState();
}

class _AlphabetWordComboScreenState extends State<AlphabetWordComboScreen> {
  static const _accent = Color(0xFF7C4DFF);

  @override
  Widget build(BuildContext context) {
    final letters = widget.set.letters;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F0FF),
      appBar: AppBar(
        title: Text(
          'ፊደልን ቃልን - Set ${widget.setIndex + 1}',
          style: const TextStyle(fontFamily: 'AbyssinicaSIL'),
        ),
        backgroundColor: _accent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Header row ────────────────────────────────────────────────────
          Container(
            color: _accent.withOpacity(0.08),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                _headerCell('ፊደል', flex: 2),
                _headerCell('ቃል', flex: 3),
                _headerCell('ስእሊ', flex: 2),
                _headerCell('ድምጺ', flex: 2),
              ],
            ),
          ),
          const Divider(height: 1),

          // ── Letter rows ───────────────────────────────────────────────────
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: letters.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey[200]),
              itemBuilder: (ctx, i) => _LetterRow(letter: letters[i]),
            ),
          ),

          // ── Complete button ───────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _complete,
                icon: const Icon(Icons.check_rounded),
                label: const Text('ተወዲኡ! - Complete!'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String label, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'AbyssinicaSIL',
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Color(0xFF7C4DFF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<void> _complete() async {
    await context.read<ProgressProvider>().markAlphabetActivity(
      widget.setIndex,
      'combo',
    );
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 ፊደልን ቃልን ተወዲኡ! +10 XP'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}

// ─── Single letter row ────────────────────────────────────────────────────────

class _LetterRow extends StatelessWidget {
  final AlphabetLetter letter;
  const _LetterRow({required this.letter});

  static const _accent = Color(0xFF7C4DFF);

  @override
  Widget build(BuildContext context) {
    final hasWord = letter.wordText.isNotEmpty;
    final hasImage = letter.imagePath.isNotEmpty;
    final hasAudio = letter.wordAudio.isNotEmpty;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Col 1: Letter ─────────────────────────────────────────────────
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                // width: 48, height: 48,
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _accent.withOpacity(0.3)),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        letter.character,
                        style: const TextStyle(
                          fontFamily: 'AbyssinicaSIL',
                          fontSize: 24,
                          color: Color(0xFF7C4DFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        letter.romanization,
                        style: TextStyle(fontSize: 9, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Col 2: Word ───────────────────────────────────────────────────────────────
          Expanded(
            flex: 3,
            child: Center(
              child: hasWord
                  ? _HighlightedWord(
                      word: letter.wordText,
                      target: letter.character,
                    )
                  : Text(
                      '—',
                      style: TextStyle(color: Colors.grey[300], fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),

          // ── Col 3: Image ──────────────────────────────────────────────────
          Expanded(
            flex: 2,
            child: Center(
              // child: hasImage
              //     ? ClipRRect(
              //         borderRadius: BorderRadius.circular(8),
              //         child: Image.asset(
              //           letter.imagePath,
              //           width: 52, height: 44,
              //           fit: BoxFit.cover,
              //           errorBuilder: (_, __, ___) =>
              //               Icon(Icons.image_not_supported,
              //                   color: Colors.grey[300], size: 28),
              //         ),
              //       )
              //     : Text('—',
              //         style: TextStyle(color: Colors.grey[300], fontSize: 18),
              //         textAlign: TextAlign.center),
              child: hasImage
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        letter.imagePath,
                        width: 52,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            letter.wordEmoji.isNotEmpty
                            ? Text(
                                letter.wordEmoji,
                                style: const TextStyle(fontSize: 32),
                                textAlign: TextAlign.center,
                              )
                            : Text(
                                '—',
                                style: TextStyle(
                                  color: Colors.grey[300],
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    )
                  : letter.wordEmoji.isNotEmpty
                  ? Text(
                      letter.wordEmoji,
                      style: const TextStyle(fontSize: 32),
                      textAlign: TextAlign.center,
                    )
                  : Text(
                      '—',
                      style: TextStyle(color: Colors.grey[300], fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),

          // ── Col 4: Audio ──────────────────────────────────────────────────
          Expanded(
            flex: 2,
            child: Center(
              child: hasAudio
                  ? AudioBtn(
                      audioPath: letter.wordAudio,
                      size: 36,
                      color: _accent,
                    )
                  : Text(
                      '—',
                      style: TextStyle(color: Colors.grey[300], fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Highlighted word widget ──────────────────────────────────────────────────

class _HighlightedWord extends StatelessWidget {
  final String word;
  final String target;
  const _HighlightedWord({required this.word, required this.target});

  static const _accent = Color(0xFF7C4DFF);

  @override
  Widget build(BuildContext context) {
    final idx = word.indexOf(target);

    const plain = TextStyle(
      fontFamily: 'AbyssinicaSIL',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    );

    if (idx == -1) {
      return Text(word, style: plain, textAlign: TextAlign.center);
    }

    final before = word.substring(0, idx);
    final match = word.substring(idx, idx + 1);
    final after = word.substring(idx + 1);

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (before.isNotEmpty) Text(before, style: plain),

        Text(
          match,
          style: plain.copyWith(
            color: _accent,
            fontSize: 20,
            decoration: TextDecoration.underline,
            decorationColor: _accent,
            decorationThickness: 2.5,
          ),
        ),

        if (after.isNotEmpty) Text(after, style: plain),
      ],
    );
  }
}
