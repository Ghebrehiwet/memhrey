// lib/screens/level2/word_search.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../models/word.dart';
import '../../data/words_data.dart';
import '../../providers/progress_provider.dart';
import '../../data/quiz_data.dart';
import '../shared/quiz_screen.dart';

// ─── Direction vectors ────────────────────────────────────────────────────────
const _dirs = [
  [0, 1], [1, 0], [1, 1], [1, -1],
  [0, -1], [-1, 0], [-1, -1], [-1, 1],
];

// ─── Placed word model ────────────────────────────────────────────────────────

class _PlacedWord {
  final Word      word;
  final String    letters;
  final int       startRow;
  final int       startCol;
  final List<int> dir;
  bool found = false;

  _PlacedWord({
    required this.word,
    required this.letters,
    required this.startRow,
    required this.startCol,
    required this.dir,
  });

  List<_Cell> get cells => List.generate(
      letters.length,
      (i) => _Cell(startRow + dir[0] * i, startCol + dir[1] * i));
}

class _Cell {
  final int row, col;
  const _Cell(this.row, this.col);
  @override
  bool operator ==(Object o) =>
      o is _Cell && o.row == row && o.col == col;
  @override
  int get hashCode => row * 1000 + col;
}

// ─── Grid builder ─────────────────────────────────────────────────────────────

const int _gridSize = 7;
const _fillerChars = [
  'ሀ','ለ','ሐ','መ','ረ','ሰ','ሸ','ቀ','በ','ተ','ቸ','ነ','አ','ከ','ወ','ዘ','የ','ደ','ጀ','ገ','ጠ','ጨ','ጸ','ፈ',
  'ሁ','ሉ','ሑ','ሙ','ሩ','ሱ','ሹ','ቁ','ቡ','ቱ','ቹ','ኑ','ኡ','ኩ','ዉ','ዙ','ዩ','ዱ','ጁ','ጉ','ጡ','ጩ','ጹ','ፉ',
  'ሂ','ሊ','ሒ','ሚ','ሪ','ሲ','ሺ','ቂ','ቢ','ቲ','ቺ','ኒ','ኢ','ኪ','ዊ','ዚ','ዪ','ዲ','ጂ','ጊ','ጢ','ጪ','ጺ','ፊ',
];

class _PuzzleGrid {
  final List<List<String>> grid;
  final List<_PlacedWord>  placed;
  const _PuzzleGrid({required this.grid, required this.placed});
}

_PuzzleGrid _buildPuzzle(List<Word> words, Random rng) {
  final grid   = List.generate(_gridSize, (_) => List.filled(_gridSize, ''));
  final placed = <_PlacedWord>[];

  for (final word in words) {
    final chars = word.tigrigna.characters.toList();
    if (chars.isEmpty || chars.length > _gridSize) continue;

    bool success = false;
    for (int attempt = 0; attempt < 50 && !success; attempt++) {
      final dir  = _dirs[rng.nextInt(_dirs.length)];
      final dr = dir[0], dc = dir[1];
      final len = chars.length;

      int minR = 0, maxR = _gridSize - 1;
      int minC = 0, maxC = _gridSize - 1;
      if (dr > 0) maxR = _gridSize - len;
      if (dr < 0) minR = len - 1;
      if (dc > 0) maxC = _gridSize - len;
      if (dc < 0) minC = len - 1;
      if (minR > maxR || minC > maxC) continue;

      final row = minR + rng.nextInt(maxR - minR + 1);
      final col = minC + rng.nextInt(maxC - minC + 1);

      bool valid = true;
      for (int i = 0; i < len; i++) {
        final existing = grid[row + dr * i][col + dc * i];
        if (existing.isNotEmpty && existing != chars[i]) {
          valid = false;
          break;
        }
      }
      if (valid) {
        for (int i = 0; i < len; i++) {
          grid[row + dr * i][col + dc * i] = chars[i];
        }
        placed.add(_PlacedWord(
          word: word,
          letters: chars.join(),
          startRow: row,
          startCol: col,
          dir: dir,
        ));
        success = true;
      }
    }
  }

  for (int r = 0; r < _gridSize; r++) {
    for (int c = 0; c < _gridSize; c++) {
      if (grid[r][c].isEmpty) {
        grid[r][c] = _fillerChars[rng.nextInt(_fillerChars.length)];
      }
    }
  }
  return _PuzzleGrid(grid: grid, placed: placed);
}

// ─── Main puzzle screen ───────────────────────────────────────────────────────

class WordSearchScreen extends StatefulWidget {
  final int puzzleIndex;
  const WordSearchScreen({super.key, required this.puzzleIndex});

  @override
  State<WordSearchScreen> createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  static const _accent         = Color(0xFF00BCD4);
  static const _wordsPerPuzzle = 5;

  late _PuzzleGrid _puzzle;
  late List<Word>  _puzzleWords;

  _Cell?      _dragStart;
  List<_Cell> _currentSelection = [];

  final List<({List<_Cell> cells, Color color})> _foundHighlights = [];
  final Set<int> _foundIndices = {};
  bool _completed = false;

  final _colors = [
    Colors.green.shade300, Colors.blue.shade300, Colors.orange.shade300,
    Colors.purple.shade300, Colors.pink.shade300, Colors.teal.shade300,
    Colors.red.shade300, Colors.amber.shade400, Colors.indigo.shade300,
    Colors.lime.shade500,
  ];

  @override
  void initState() {
    super.initState();
    _buildPuzzleData();
  }

  void _buildPuzzleData() {
    final rng = Random(widget.puzzleIndex * 137 + 13);
    final pool = List<Word>.from(wordsData)..shuffle(rng);
    _puzzleWords = pool.take(_wordsPerPuzzle).toList();
    _puzzle = _buildPuzzle(_puzzleWords, rng);
  }

  List<_Cell> _cellsBetween(_Cell a, _Cell b) {
    final dr = b.row - a.row, dc = b.col - a.col;
    if (dr != 0 && dc != 0 && dr.abs() != dc.abs()) return [];
    final steps = max(dr.abs(), dc.abs());
    if (steps == 0) return [a];
    final stepR = dr == 0 ? 0 : dr ~/ dr.abs();
    final stepC = dc == 0 ? 0 : dc ~/ dc.abs();
    return List.generate(
        steps + 1, (i) => _Cell(a.row + stepR * i, a.col + stepC * i));
  }

  void _onDragStart(_Cell cell) =>
      setState(() { _dragStart = cell; _currentSelection = [cell]; });

  void _onDragUpdate(_Cell cell) {
    if (_dragStart == null) return;
    setState(() { _currentSelection = _cellsBetween(_dragStart!, cell); });
  }

  void _onDragEnd() {
    if (_currentSelection.length < 2) {
      setState(() { _currentSelection = []; _dragStart = null; });
      return;
    }
    _checkSelection();
    setState(() { _currentSelection = []; _dragStart = null; });
  }

  void _checkSelection() {
    for (int i = 0; i < _puzzle.placed.length; i++) {
      if (_foundIndices.contains(i)) continue;
      final pw = _puzzle.placed[i];
      final selChars = _currentSelection.map((c) => _puzzle.grid[c.row][c.col]).join();
      if (selChars == pw.letters ||
          selChars == pw.letters.characters.toList().reversed.join()) {
        setState(() {
          _foundIndices.add(i);
          pw.found = true;
          _foundHighlights.add((cells: pw.cells, color: _colors[i % _colors.length]));
        });
        context.read<ProgressProvider>().markPuzzleWordFound(widget.puzzleIndex, pw.word.id);
        _checkComplete();
        return;
      }
    }
  }

  void _checkComplete() {
    if (_foundIndices.length == _puzzle.placed.length) {
      setState(() => _completed = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFF0FCFF),
      appBar: AppBar(
        title: Text('ምድላይ ቃላት - Puzzle ${widget.puzzleIndex + 1}/20',
            style: const TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: _accent,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text('${_foundIndices.length}/${_puzzle.placed.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
        ],
      ),
      body: isLandscape ? _buildLandscape() : _buildPortrait(),
    );
  }

  // ── Portrait: grid top (flex 5), word list middle (flex 3), footer ──────────
  Widget _buildPortrait() {
    return Column(children: [
      Expanded(flex: 5, child: _gridContainer()),
      Expanded(flex: 3, child: _wordListPanel()),
      _footer(),
    ]);
  }

  // ── Landscape: grid left, word list right, footer below ─────────────────────
  Widget _buildLandscape() {
    return Column(children: [
      Expanded(
        child: Row(children: [
          Expanded(flex: 5, child: _gridContainer()),
          Expanded(flex: 4, child: _wordListPanel(isLandscape: true)),
        ]),
      ),
      _footer(),
    ]);
  }

  Widget _gridContainer() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: _buildGrid(),
    );
  }

  Widget _wordListPanel({bool isLandscape = false}) {
    return Container(
      color: const Color(0xFFF0FCFF),
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          color: _accent.withOpacity(0.1),
          child: const Text('ቃላት ድለ - Find these words:',
              style: TextStyle(
                  fontFamily: 'AbyssinicaSIL',
                  fontWeight: FontWeight.bold,
                  fontSize: 13)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(6),
            itemCount: _puzzle.placed.length,
            itemBuilder: (_, i) {
              final pw    = _puzzle.placed[i];
              final found = _foundIndices.contains(i);
              return Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: found
                      ? _colors[i % _colors.length].withOpacity(0.25)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: found ? _colors[i % _colors.length] : Colors.grey[200]!,
                    width: found ? 1.5 : 1,
                  ),
                ),
                child: Row(children: [
                  found
                      ? Icon(Icons.check_circle,
                          size: 14, color: _colors[i % _colors.length])
                      : Container(
                          width: 14, height: 14,
                          decoration: BoxDecoration(
                            color: _colors[i % _colors.length].withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pw.word.tigrigna,
                            style: TextStyle(
                              fontFamily: 'AbyssinicaSIL',
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: found ? Colors.grey : Colors.black87,
                              decoration:
                                  found ? TextDecoration.lineThrough : null,
                            )),
                        Text(pw.word.english,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[500])),
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _footer() {
    return Consumer<ProgressProvider>(
      builder: (_, progress, __) {
        final canTake = progress.canTakeLevel2Quiz;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: canTake
              ? const Color(0xFF00838F)
              : const Color(0xFFE0F7FA),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            if (_completed) ...[
              const Row(children: [
                Text('🎉', style: TextStyle(fontSize: 20)),
                SizedBox(width: 8),
                Text('ኩሎም ቃላት ተረኺቦም!',
                    style: TextStyle(
                        fontFamily: 'AbyssinicaSIL',
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color(0xFF2E7D32))),
              ]),
              const SizedBox(height: 6),
            ],
            Row(children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: canTake
                      ? () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => QuizScreen(
                                  level: 2, questions: getQuizQuestions(2))))
                      : null,
                  icon: const Icon(Icons.quiz, size: 16),
                  label: Text(
                    canTake
                        ? 'ተዳሎ፥ ደረጃ 2 ፈተና ውሰድ →'
                        : 'Complete 10 puzzles ≥60% to unlock',
                    style: const TextStyle(
                        fontFamily: 'AbyssinicaSIL', fontSize: 13),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canTake ? const Color(0xFF00BCD4) : Colors.grey[300],
                    foregroundColor:
                        canTake ? Colors.white : Colors.grey[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              if (_completed) ...[
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('ንክትቅጽል ተመለስ',
                      style: TextStyle(
                          fontFamily: 'AbyssinicaSIL', fontSize: 13)),
                ),
              ],
            ]),
          ]),
        );
      },
    );
  }

  Widget _buildGrid() {
    return LayoutBuilder(builder: (ctx, constraints) {
      final cellSize = min(
        constraints.maxWidth  / _gridSize,
        constraints.maxHeight / _gridSize,
      );
      return GestureDetector(
        onPanStart:  (d) { final c = _offsetToCell(d.localPosition, cellSize); if (c != null) _onDragStart(c); },
        onPanUpdate: (d) { final c = _offsetToCell(d.localPosition, cellSize); if (c != null) _onDragUpdate(c); },
        onPanEnd:    (_) => _onDragEnd(),
        child: SizedBox(
          width:  cellSize * _gridSize,
          height: cellSize * _gridSize,
          child: CustomPaint(
            painter: _GridPainter(
              grid: _puzzle.grid,
              gridSize: _gridSize,
              cellSize: cellSize,
              selection: _currentSelection,
              foundHighlights: _foundHighlights,
            ),
          ),
        ),
      );
    });
  }

  _Cell? _offsetToCell(Offset pos, double cellSize) {
    final r = (pos.dy / cellSize).floor();
    final c = (pos.dx / cellSize).floor();
    if (r < 0 || r >= _gridSize || c < 0 || c >= _gridSize) return null;
    return _Cell(r, c);
  }
}

// ─── Grid painter ─────────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  final List<List<String>> grid;
  final int    gridSize;
  final double cellSize;
  final List<_Cell> selection;
  final List<({List<_Cell> cells, Color color})> foundHighlights;

  const _GridPainter({
    required this.grid,
    required this.gridSize,
    required this.cellSize,
    required this.selection,
    required this.foundHighlights,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Paint()..color = Colors.white);

    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (final h in foundHighlights) {
      _drawHighlight(canvas, h.cells, h.color.withOpacity(0.45));
    }
    if (selection.length > 1) {
      _drawHighlight(canvas, selection,
          const Color(0xFF00BCD4).withOpacity(0.35));
    }

    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        final rect = Rect.fromLTWH(
            c * cellSize, r * cellSize, cellSize, cellSize);
        canvas.drawRect(rect, gridPaint);

        final letter     = grid[r][c];
        if (letter.isEmpty) continue;
        final isSelected = selection.contains(_Cell(r, c));
        final isFound    = foundHighlights.any((h) => h.cells.contains(_Cell(r, c)));

        final tp = TextPainter(
          text: TextSpan(
            text: letter,
            style: TextStyle(
              fontFamily: 'AbyssinicaSIL',
              fontSize: cellSize * 0.55,
              fontWeight: isSelected || isFound
                  ? FontWeight.bold
                  : FontWeight.normal,
              color: isSelected
                  ? const Color(0xFF006064)
                  : (isFound ? const Color(0xFF1A237E) : Colors.black87),
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();

        tp.paint(canvas,
            Offset(rect.left + (cellSize - tp.width) / 2,
                   rect.top  + (cellSize - tp.height) / 2));
      }
    }
  }

  void _drawHighlight(Canvas canvas, List<_Cell> cells, Color color) {
    if (cells.isEmpty) return;
    final paint = Paint()..color = color..style = PaintingStyle.fill;

    if (cells.length == 1) {
      final r = cells.first;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(r.col * cellSize + 2, r.row * cellSize + 2,
              cellSize - 4, cellSize - 4),
          Radius.circular(cellSize / 2),
        ),
        paint,
      );
      return;
    }

    final first = cells.first, last = cells.last;
    final radius = cellSize / 2;
    final cx1 = first.col * cellSize + cellSize / 2;
    final cy1 = first.row * cellSize + cellSize / 2;
    final cx2 = last.col  * cellSize + cellSize / 2;
    final cy2 = last.row  * cellSize + cellSize / 2;
    final angle = atan2(cy2 - cy1, cx2 - cx1);
    final perpX = -sin(angle) * radius;
    final perpY =  cos(angle) * radius;

    canvas.drawPath(
      Path()
        ..moveTo(cx1 + perpX, cy1 + perpY)
        ..lineTo(cx2 + perpX, cy2 + perpY)
        ..arcToPoint(Offset(cx2 - perpX, cy2 - perpY),
            radius: Radius.circular(radius), clockwise: true)
        ..lineTo(cx1 - perpX, cy1 - perpY)
        ..arcToPoint(Offset(cx1 + perpX, cy1 + perpY),
            radius: Radius.circular(radius), clockwise: true)
        ..close(),
      paint,
    );
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.selection != selection || old.foundHighlights != foundHighlights;
}

// ─── Selector screen ──────────────────────────────────────────────────────────

class WordSearchSelectorScreen extends StatelessWidget {
  const WordSearchSelectorScreen({super.key});
  static const _accent = Color(0xFF00BCD4);

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: const Color(0xFFF0FCFF),
      appBar: AppBar(
        title: const Text('ምድላይ ቃላት - Word Search',
            style: TextStyle(fontFamily: 'AbyssinicaSIL')),
        backgroundColor: _accent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(isLandscape ? 10 : 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header card — compact in BOTH orientations now. Portrait
            // used to run a 36px icon + 20px title + a full two-line
            // subtitle + spacing + progress row, all fixed and always
            // shown — costing enough vertical space that only one row of
            // puzzle tiles was visible. Trimmed to a single descriptive
            // line + inline progress bar, freeing significantly more room
            // for "Choose a Puzzle" below.
            Consumer<ProgressProvider>(
              builder: (_, progress, __) {
                int qualified = 0;
                for (int i = 0; i < 20; i++) {
                  if (progress.getPuzzleFoundCount(i) >= 3) qualified++;
                }
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(isLandscape ? 10 : 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF00BCD4), Color(0xFF0097A7)]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: isLandscape
                      // ── Landscape: single compact row ────────────────────
                      ? Row(children: [
                          const Text('🔍',
                              style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '20 ምድላይ ቃላት ፓዝል - 20 Word Search Puzzles  ·  5 words per 7×7 grid',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: SizedBox(
                                  width: 120,
                                  child: LinearProgressIndicator(
                                    value: qualified / 10,
                                    minHeight: 8,
                                    backgroundColor: Colors.white24,
                                    valueColor: AlwaysStoppedAnimation(
                                        qualified >= 10
                                            ? Colors.greenAccent
                                            : Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('$qualified/10 puzzles',
                                  style: TextStyle(
                                      color: qualified >= 10
                                          ? Colors.greenAccent
                                          : Colors.white70,
                                      fontSize: 11)),
                            ],
                          ),
                        ])
                      // ── Portrait: same single-row compact layout as
                      // landscape's approach, adapted to a slightly taller
                      // two-line stack (title, then progress) since
                      // portrait has a narrower width to work with.
                      : Row(children: [
                          const Text('🔍', style: TextStyle(fontSize: 26)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  '20 ምድላይ ቃላት ፓዝል - Word Search Puzzles',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Row(children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: qualified / 10,
                                        minHeight: 7,
                                        backgroundColor: Colors.white24,
                                        valueColor: AlwaysStoppedAnimation(
                                            qualified >= 10
                                                ? Colors.greenAccent
                                                : Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text('$qualified/10',
                                      style: TextStyle(
                                          color: qualified >= 10
                                              ? Colors.greenAccent
                                              : Colors.white70,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold)),
                                ]),
                              ],
                            ),
                          ),
                        ]),
                );
              },
            ).animate().fadeIn(duration: 400.ms),

            SizedBox(height: isLandscape ? 8 : 10),

            Text('ፓዝልካ ምረጽ - Choose a Puzzle',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isLandscape ? 13 : 14,
                    fontFamily: 'AbyssinicaSIL')),
            SizedBox(height: isLandscape ? 6 : 8),

            // ── Puzzle grid — always fills remaining space ───────────────────
            // aspectRatio is now computed from measured width and an
            // estimated tile height, rather than a fixed guessed constant.
            // The previous fixed 2.6 (landscape) / 1.6 (portrait) values
            // made cells too short for the tile's 3 lines of content
            // (icon/checkmark + "Puzzle N" + "X/5 words") plus the bottom
            // progress bar overlay, causing a consistent bottom overflow
            // on every tile in landscape's narrower 5-column layout.
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                final crossAxisCount = isLandscape ? 5 : 3;
                const spacing = 10.0;
                const estimatedTileHeight = 78.0;
                final itemWidth = (constraints.maxWidth -
                        spacing * (crossAxisCount - 1)) /
                    crossAxisCount;
                final aspectRatio = itemWidth / estimatedTileHeight;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: spacing,
                    mainAxisSpacing: spacing,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: 20,
                  itemBuilder: (ctx, i) => _PuzzleTile(index: i)
                      .animate()
                      .fadeIn(delay: (i * 40).ms, duration: 250.ms)
                      .scale(delay: (i * 40).ms),
                );
              }),
            ),
          ],
        ),
      ),
      // ── Sticky quiz button footer ──────────────────────────────────────────
      bottomNavigationBar: Consumer<ProgressProvider>(
        builder: (_, progress, __) {
          final canTake = progress.canTakeLevel2Quiz;
          return Container(
            color: canTake ? const Color(0xFF00838F) : const Color(0xFFE0F7FA),
            padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isLandscape ? 6 : 10),
            child: SafeArea(
              top: false,
              child: ElevatedButton.icon(
                onPressed: canTake
                    ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => QuizScreen(
                                level: 2, questions: getQuizQuestions(2))))
                    : null,
                icon: const Icon(Icons.quiz, size: 16),
                label: Text(
                  canTake
                      ? 'ተዳሎ፥ ደረጃ 2 ፈተና ውሰድ →'
                      : 'Complete 10 puzzles ≥60% to unlock quiz',
                  style: const TextStyle(
                      fontFamily: 'AbyssinicaSIL', fontSize: 13),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      canTake ? const Color(0xFF00BCD4) : Colors.grey[300],
                  foregroundColor:
                      canTake ? Colors.white : Colors.grey[600],
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  final int index;
  const _PuzzleTile({required this.index});
  static const _accent = Color(0xFF00BCD4);

  @override
  Widget build(BuildContext context) {
    final rawFound  = context.watch<ProgressProvider>().getPuzzleFoundCount(index);
    final found     = rawFound.clamp(0, 5);
    final qualified = found >= 3;
    final completed = found >= 5;

    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(
              builder: (_) => WordSearchScreen(puzzleIndex: index))),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: completed
                ? [Colors.green.shade400, Colors.green.shade700]
                : qualified
                    ? [const Color(0xFF00BCD4), const Color(0xFF00838F)]
                    : [_accent.withOpacity(0.6),
                       const Color(0xFF0097A7).withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: (completed ? Colors.green : _accent).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Stack(children: [
          Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(completed ? '✅' : '🔍',
                  style: const TextStyle(fontSize: 14)),
              Text('Puzzle ${index + 1}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11)),
              Text('$found/5 words',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.85), fontSize: 9)),
            ]),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16)),
              child: LinearProgressIndicator(
                value: found / 5,
                minHeight: 4,
                backgroundColor: Colors.white24,
                valueColor: AlwaysStoppedAnimation(
                    completed ? Colors.white : Colors.white70),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}