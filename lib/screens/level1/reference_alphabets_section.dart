// lib/screens/level1/reference_alphabets_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/progress_provider.dart';

// ─── Data model ───────────────────────────────────────────────────────────────

class _RefLetter {
  final String character;
  final String romanization;
  const _RefLetter(this.character, this.romanization);
}

class _RefSet {
  final String family;       // e.g. 's', 'h̃', 'ts'
  final String description;  // e.g. 'Sibilant s'
  final List<_RefLetter?> letters; // 7 slots, null = no character for that vowel
  const _RefSet({required this.family, required this.description, required this.letters});
}

// ─── Reference data from images ──────────────────────────────────────────────


final List<_RefSet> _refSets = [

  // ── Image 1 ──────────────────────────────────────────────────────────────

  // ሠ family (s) — distinct from ሰ
  _RefSet(family: 's', description: 'ሠ family',  letters: [
    _RefLetter('ሠ', 'se'), _RefLetter('ሡ', 'su'), _RefLetter('ሢ', 'si'),
    _RefLetter('ሣ', 'sa'), _RefLetter('ሤ', 'sē'), _RefLetter('ሥ', 's'),
    _RefLetter('ሦ', 'so'),
  ]),

  // ኀ family (h̃) — pharyngeal h
  _RefSet(family: 'h̃', description: 'ኀ family', letters: [
    _RefLetter('ኀ', 'h̃e'), _RefLetter('ኁ', 'h̃u'), _RefLetter('ኂ', 'h̃i'),
    _RefLetter('ኃ', 'h̃a'), _RefLetter('ኄ', 'h̃ē'), _RefLetter('ኅ', 'h̃'),
    _RefLetter('ኆ', 'h̃o'),
  ]),

  // ሐ family (ĥ) — emphatic h
  _RefSet(family: 'ĥ', description: 'ሐ family', letters: [
    _RefLetter('ሐ', 'ĥe'), _RefLetter('ሑ', 'ĥu'), _RefLetter('ሒ', 'ĥi'),
    _RefLetter('ሓ', 'ĥa'), _RefLetter('ሔ', 'ĥē'), _RefLetter('ሕ', 'ĥ'),
    _RefLetter('ሖ', 'ĥo'),
  ]),

  // ጸ family (ts)
  _RefSet(family: 'ts', description: 'ጸ family', letters: [
    _RefLetter('ጸ', 'tse'), _RefLetter('ጹ', 'tsu'), _RefLetter('ጺ', 'tsi'),
    _RefLetter('ጻ', 'tsa'), _RefLetter('ጼ', 'tsē'), _RefLetter('ጽ', 'ts'),
    _RefLetter('ጾ', 'tso'),
  ]),

  // ፀ family (ṕ / emphatic ts)
  _RefSet(family: 'ṕ', description: 'ፀ family', letters: [
    _RefLetter('ፀ', 'ṕe'), _RefLetter('ፁ', 'ṕu'), _RefLetter('ፂ', 'ṕi'),
    _RefLetter('ፃ', 'ṕa'), _RefLetter('ፄ', 'ṕē'), _RefLetter('ፅ', 'ṕ'),
    _RefLetter('ፆ', 'ṕo'),
  ]),

  // ── Image 2 — Labialized (rounded) consonants ─────────────────────────────

  // qʷ family
  _RefSet(family: 'qʷ', description: 'ቈ family (labialized q)', letters: [
    _RefLetter('ቈ', 'qʷe'), null, _RefLetter('ቊ', 'qʷu'),
    _RefLetter('ቋ', 'qʷa'), _RefLetter('ቌ', 'qʷē'), null, null,
  ]),

  // Qʰʷ family
  _RefSet(family: 'Qʰʷ', description: 'ቘ family (labialized Q)', letters: [
    _RefLetter('ቘ', 'Qʰʷe'), null, _RefLetter('ቚ', 'Qʰʷu'),
    _RefLetter('ቛ', 'Qʰʷa'), _RefLetter('ቜ', 'Qʰʷē'), null, null,
  ]),

  // Kʷ family
  _RefSet(family: 'Kʷ', description: 'ኰ family (labialized K)', letters: [
    _RefLetter('ኰ', 'Kʷe'), null, _RefLetter('ኲ', 'Kʷu'),
    _RefLetter('ኳ', 'Kʷa'), _RefLetter('ኴ', 'Kʷē'), null, null,
  ]),

  // Kˣʷ family
  _RefSet(family: 'Kˣʷ', description: 'ዀ family (labialized Kˣ)', letters: [
    _RefLetter('ዀ', 'Kˣʷe'), null, _RefLetter('ዂ', 'Kˣʷu'),
    _RefLetter('ዃ', 'Kˣʷa'), _RefLetter('ዄ', 'Kˣʷē'), null, null,
  ]),

  // Gʷ family
  _RefSet(family: 'Gʷ', description: 'ጐ family (labialized G)', letters: [
    _RefLetter('ጐ', 'Gʷe'), null, _RefLetter('ጒ', 'Gʷu'),
    _RefLetter('ጓ', 'Gʷa'), _RefLetter('ጔ', 'Gʷē'), null, null,
  ]),

  // ── Image 3 — Additional families ────────────────────────────────────────

  // ĥ full set (image 3 left column)
  _RefSet(family: 'ĥ²', description: 'ሐ full set', letters: [
    _RefLetter('ሐ', 'ĥe'), _RefLetter('ሑ', 'ĥu'), _RefLetter('ሒ', 'ĥi'),
    _RefLetter('ሓ', 'ĥa'), _RefLetter('ሔ', 'ĥē'), _RefLetter('ሕ', 'ĥ'),
    _RefLetter('ሖ', 'ĥo'),
  ]),

  // q family (ቀ)
  _RefSet(family: 'q', description: 'ቀ family', letters: [
    _RefLetter('ቀ', 'qe'), _RefLetter('ቁ', 'qu'), _RefLetter('ቂ', 'qi'),
    _RefLetter('ቃ', 'qa'), _RefLetter('ቄ', 'qē'), _RefLetter('ቅ', 'q'),
    _RefLetter('ቆ', 'qo'),
  ]),

  // -q family (ቐ emphatic)
  _RefSet(family: '-q', description: 'ቐ family (emphatic q)', letters: [
    _RefLetter('ቐ', 'q̈e'), _RefLetter('ቑ', 'q̈u'), _RefLetter('ቒ', 'q̈i'),
    _RefLetter('ቓ', 'q̈a'), _RefLetter('ቔ', 'q̈ē'), _RefLetter('ቕ', 'q̈'),
    _RefLetter('ቖ', 'q̈o'),
  ]),

  // ẗ family (ጠ)
  _RefSet(family: "ẗ", description: 'ጠ family (emphatic t)', letters: [
    _RefLetter('ጠ', 'ṫe'), _RefLetter('ጡ', 'ṫu'), _RefLetter('ጢ', 'ṫi'),
    _RefLetter('ጣ', 'ṫa'), _RefLetter('ጤ', 'ṫē'), _RefLetter('ጥ', 'ṫ'),
    _RefLetter('ጦ', 'ṫo'),
  ]),

  // čh family (ጨ)
  _RefSet(family: 'čh', description: 'ጨ family (emphatic ch)', letters: [
    _RefLetter('ጨ', 'čhe'), _RefLetter('ጩ', 'čhu'), _RefLetter('ጪ', 'čhi'),
    _RefLetter('ጫ', 'čha'), _RefLetter('ጬ', 'čhē'), _RefLetter('ጭ', 'čh'),
    _RefLetter('ጮ', 'čho'),
  ]),

  // ń family (ኘ)
  _RefSet(family: 'ń', description: 'ኘ family', letters: [
    _RefLetter('ኘ', 'ńe'), _RefLetter('ኙ', 'ńu'), _RefLetter('ኚ', 'ńi'),
    _RefLetter('ኛ', 'ńa'), _RefLetter('ኜ', 'ńē'), _RefLetter('ኝ', 'ń'),
    _RefLetter('ኞ', 'ńo'),
  ]),

  // ē / ዐ family (pharyngeal)
  _RefSet(family: 'ē', description: "ዐ family (pharyngeal 'e)", letters: [
    _RefLetter('ዐ', "'e"), _RefLetter('ዑ', "'u"), _RefLetter('ዒ', "'i"),
    _RefLetter('ዓ', "'a"), _RefLetter('ዔ', "'ē"), _RefLetter('ዕ', 'e'),
    _RefLetter('ዖ', "'o"),
  ]),

  // h full (ሀ) — right side of image 3
  _RefSet(family: 'h', description: 'ሀ family', letters: [
    _RefLetter('ሀ', 'he'), _RefLetter('ሁ', 'hu'), _RefLetter('ሂ', 'hi'),
    _RefLetter('ሃ', 'ha'), _RefLetter('ሄ', 'hē'), _RefLetter('ህ', 'h'),
    _RefLetter('ሆ', 'ho'),
  ]),

  // k family (ከ)
  _RefSet(family: 'k', description: 'ከ family', letters: [
    _RefLetter('ከ', 'ke'), _RefLetter('ኩ', 'ku'), _RefLetter('ኪ', 'ki'),
    _RefLetter('ካ', 'ka'), _RefLetter('ኬ', 'kē'), _RefLetter('ክ', 'k'),
    _RefLetter('ኮ', 'ko'),
  ]),

  // ḱ family (ኸ)
  _RefSet(family: 'ḱ', description: 'ኸ family', letters: [
    _RefLetter('ኸ', 'ḱe'), _RefLetter('ኹ', 'ḱu'), _RefLetter('ኺ', 'ḱi'),
    _RefLetter('ኻ', 'ḱa'), _RefLetter('ኼ', 'ḱē'), _RefLetter('ኽ', 'ḱh'),
    _RefLetter('ኾ', 'ḱo'),
  ]),

  // t family (ተ)
  _RefSet(family: 't', description: 'ተ family', letters: [
    _RefLetter('ተ', 'te'), _RefLetter('ቱ', 'tu'), _RefLetter('ቲ', 'ti'),
    _RefLetter('ታ', 'ta'), _RefLetter('ቴ', 'tē'), _RefLetter('ት', 't'),
    _RefLetter('ቶ', 'to'),
  ]),

  // ch family (ቸ)
  _RefSet(family: 'ch', description: 'ቸ family', letters: [
    _RefLetter('ቸ', 'che'), _RefLetter('ቹ', 'chu'), _RefLetter('ቺ', 'chi'),
    _RefLetter('ቻ', 'cha'), _RefLetter('ቼ', 'chē'), _RefLetter('ች', 'ch'),
    _RefLetter('ቾ', 'cho'),
  ]),

  // n family (ነ)
  _RefSet(family: 'n', description: 'ነ family', letters: [
    _RefLetter('ነ', 'ne'), _RefLetter('ኑ', 'nu'), _RefLetter('ኒ', 'ni'),
    _RefLetter('ና', 'na'), _RefLetter('ኔ', 'nē'), _RefLetter('ን', 'n'),
    _RefLetter('ኖ', 'no'),
  ]),

  // e / አ family
  _RefSet(family: 'e', description: 'አ family (vowels)', letters: [
    _RefLetter('አ', 'e'), _RefLetter('ኡ', 'u'), _RefLetter('ኢ', 'i'),
    _RefLetter('ኣ', 'a'), _RefLetter('ኤ', 'ē'), _RefLetter('እ', 'e'),
    _RefLetter('ኦ', 'o'),
  ]),
];

// ─── Widget ───────────────────────────────────────────────────────────────────

class ReferenceAlphabetsSection extends StatefulWidget {
  const ReferenceAlphabetsSection({super.key});

  @override
  State<ReferenceAlphabetsSection> createState() =>
      _ReferenceAlphabetsSectionState();
}

class _ReferenceAlphabetsSectionState
    extends State<ReferenceAlphabetsSection> {
  bool _expanded = false;

 @override
  Widget build(BuildContext context) {
    final viewed = context.watch<ProgressProvider>().referenceViewed;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: viewed
              ? const Color(0xFF4CAF50).withOpacity(0.5)
              : const Color(0xFF7C4DFF).withOpacity(0.2),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          // ── Header / toggle ──────────────────────────────────────────────
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: viewed
                          ? const Color(0xFF4CAF50).withOpacity(0.1)
                          : const Color(0xFF7C4DFF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(viewed ? '✅' : '📖',
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ተወሳኺ ፊደላት - Reference Alphabets',
                            style: TextStyle(
                                fontFamily: 'AbyssinicaSIL',
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        Text(
                            viewed ? 'Completed ✓' : 'Labialized & additional letter families',
                            style: TextStyle(
                                color: viewed ? Colors.green : Colors.grey,
                                fontSize: 11)),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded ? Icons.expand_less : Icons.expand_more,
                    color: viewed ? const Color(0xFF4CAF50) : const Color(0xFF7C4DFF),
                  ),
                ],
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          if (_expanded) ...[
            const Divider(height: 1),
            // Legend row also measures cellWidth so its column headings
            // ("e · u · i · a · ē · — · o") line up with the actual data
            // rows below, whatever width those end up being computed to.
            LayoutBuilder(builder: (ctx, constraints) {
              const familyLabelWidth = 40.0;
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: Row(
                  children: [
                    const SizedBox(
                      width: familyLabelWidth,
                      child: Text('Family',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
                    ),
                    const Expanded(
                      child: Text(
                          'e   ·   u   ·   i   ·   a   ·   ē   ·   —   ·   o',
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey)),
                    ),
                  ],
                ),
              );
            }),
            // Measures the actual available width for each row rather than
            // assuming a fixed 38px per cell fits. Fixed cell widths
            // summing to more than what was actually available (extra
            // padding from wherever this section is embedded on the parent
            // screen) is exactly what caused the repeated per-row
            // horizontal overflow. Computing cellWidth from real
            // constraints makes this immune to however the parent pads it.
            LayoutBuilder(builder: (ctx, constraints) {
              const familyLabelWidth = 40.0;
              const minCellWidth = 26.0;
              // The ListView below applies its own horizontal padding
              // (16 left + 16 right = 32) to its children. This
              // LayoutBuilder measures width OUTSIDE that padding, so it
              // must be subtracted here too — omitting it was exactly what
              // caused the reported 32px overflow on every row.
              const listPadding = 32.0;
              final rawCellWidth =
                  (constraints.maxWidth - listPadding - familyLabelWidth) / 7;
              final cellWidth =
                  rawCellWidth < minCellWidth ? minCellWidth : rawCellWidth;
              final rowWidth = familyLabelWidth + cellWidth * 7;
              final needsHorizontalScroll =
                  rowWidth > constraints.maxWidth - listPadding + 0.5;

              final list = ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                itemCount: _refSets.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, thickness: 0.5),
                itemBuilder: (ctx, i) =>
                    _RefSetRow(_refSets[i], cellWidth: cellWidth),
              );

              // Only true if even the clamped minimum cell width doesn't
              // fit — falls back to horizontal scroll rather than
              // overflowing, on very narrow layouts.
              return needsHorizontalScroll
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                      child: SizedBox(width: rowWidth, child: list),
                    )
                  : list;
            }),

            // Mark as reviewed button
            if (!viewed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        context.read<ProgressProvider>().markReferenceViewed(),
                    icon: const Icon(Icons.check_circle),
                    label: const Text('ተገምጊሙ - Mark as Reviewed ✓'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7C4DFF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ),

            if (viewed)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF4CAF50)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'ተገምጊሙ! - Reviewed! +20 XP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

// ─── Single row for one reference set ────────────────────────────────────────

class _RefSetRow extends StatelessWidget {
  final _RefSet refSet;
  final double cellWidth;
  const _RefSetRow(this.refSet, {required this.cellWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Family label
          SizedBox(
            width: 40,
            child: Text(
              refSet.family,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C4DFF)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // 7 letter cells — each sized to the computed cellWidth so the
          // row's total width always matches what was actually measured as
          // available, instead of a hardcoded assumption.
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: refSet.letters.map((l) {
                if (l == null) {
                  return SizedBox(
                    width: cellWidth,
                    child: const Center(
                        child: Text('—',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 12))),
                  );
                }
                return _LetterCell(l, cellWidth: cellWidth);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Single letter cell ───────────────────────────────────────────────────────

class _LetterCell extends StatelessWidget {
  final _RefLetter letter;
  final double cellWidth;
  const _LetterCell(this.letter, {required this.cellWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: cellWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              letter.character,
              style: const TextStyle(
                fontFamily: 'AbyssinicaSIL',
                fontSize: 20,
                color: Color(0xFF1A237E),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              letter.romanization,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}