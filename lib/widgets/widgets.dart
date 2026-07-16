// lib/widgets/level_card.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/level_meta.dart';
 
 
// lib/widgets/widgets.dart - barrel export
export 'audio_btn.dart';
export 'next_btn.dart';
export 'stroke_painter.dart';
export 'level_card.dart';
export 'option_tile.dart';
export 'stat_badge.dart';
export 'achieve_tile.dart';
export 'emoji_box.dart';


// lib/widgets/next_btn.dart

class NextBtn extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isEnabled;
  final IconData icon;

  const NextBtn({
    super.key,
    this.label = 'Next',
    this.onTap,
    this.isEnabled = true,
    this.icon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.4,
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton.icon(
        onPressed: isEnabled ? onTap : null,
        icon: Icon(icon, size: 20),
        label: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5C6BC0),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
      ),
    );
  }
}



class LevelCard extends StatelessWidget {
  final LevelMeta level;
  final VoidCallback? onTap;

  const LevelCard({super.key, required this.level, this.onTap});

  @override
  Widget build(BuildContext context) {
    final unlocked = level.isUnlocked;
    return GestureDetector(
      onTap: unlocked ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: unlocked
              ? LinearGradient(
                  colors: [_levelColor(level.levelNumber).withOpacity(0.85),
                           _levelColor(level.levelNumber)],
                  begin: Alignment.topLeft, end: Alignment.bottomRight)
              : null,
          color: unlocked ? null : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
          boxShadow: unlocked ? [
            BoxShadow(
              color: _levelColor(level.levelNumber).withOpacity(0.35),
              blurRadius: 12, offset: const Offset(0, 5))
          ] : [],
        ),
        child: Row(
          children: [
            Container(
              width: 60, height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(level.icon, style: const TextStyle(fontSize: 30)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Level ${level.levelNumber}',
                          style: TextStyle(
                            color: unlocked ? Colors.white70 : Colors.grey[600],
                            fontSize: 12, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      if (level.isCompleted) ...[
                        const Icon(Icons.check_circle, color: Colors.white, size: 18),
                        const SizedBox(width: 4),
                      ],
                      if (level.stars > 0)
                        Row(children: List.generate(level.stars, (_) =>
                          const Icon(Icons.star, color: Colors.amber, size: 16))),
                    ],
                  ),
                  Text(level.title,
                      style: TextStyle(
                        fontFamily: 'AbyssinicaSIL',
                        color: unlocked ? Colors.white : Colors.grey[700],
                        fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(level.description,
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: unlocked ? Colors.white70 : Colors.grey[500],
                        fontSize: 12)),
                  const SizedBox(height: 8),
                  LinearPercentIndicator(
                    lineHeight: 8,
                    percent: level.progressPercent.clamp(0.0, 1.0),
                    backgroundColor: Colors.white.withOpacity(0.3),
                    progressColor: Colors.white,
                    barRadius: const Radius.circular(4),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 2),
                  Text('${(level.progressPercent * 100).toInt()}% complete',
                      style: TextStyle(
                        color: unlocked ? Colors.white70 : Colors.grey[500],
                        fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              unlocked ? Icons.arrow_forward_ios : Icons.lock_outline,
              color: unlocked ? Colors.white : Colors.grey[400],
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Color _levelColor(int level) {
    const colors = [
      Color(0xFF7C4DFF), Color(0xFF00BCD4),
      Color(0xFFFF7043), Color(0xFF2E7D32),
    ];
    return colors[(level - 1).clamp(0, 3)];
  }
}

// lib/widgets/option_tile.dart
class OptionTile extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool? isCorrect;
  final VoidCallback onTap;
  final int index;

  const OptionTile({
    super.key,
    required this.text,
    required this.isSelected,
    this.isCorrect,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.white;
    Color border = const Color(0xFFE0E0E0);
    Color textColor = Colors.black87;
    if (isSelected) {
      if (isCorrect == true) { bg = const Color(0xFFE8F5E9); border = const Color(0xFF4CAF50); textColor = const Color(0xFF2E7D32); }
      else if (isCorrect == false) { bg = const Color(0xFFFFEBEE); border = const Color(0xFFF44336); textColor = const Color(0xFFC62828); }
      else { bg = const Color(0xFFE3F2FD); border = const Color(0xFF2196F3); textColor = const Color(0xFF1565C0); }
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 2),
          boxShadow: [BoxShadow(color: border.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: border.withOpacity(0.15), shape: BoxShape.circle),
              child: Center(child: Text(
                ['A', 'B', 'C', 'D'][index],
                style: TextStyle(color: border, fontWeight: FontWeight.bold, fontSize: 14),
              )),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text(text,
              style: TextStyle(fontFamily: 'AbyssinicaSIL', fontSize: 18, color: textColor, fontWeight: FontWeight.w500))),
            if (isSelected)
              Icon(isCorrect == true ? Icons.check_circle : (isCorrect == false ? Icons.cancel : Icons.check_circle),
                color: border, size: 22),
          ],
        ),
      ),
    );
  }
}

// lib/widgets/stat_badge.dart
class StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const StatBadge({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 2),
          Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: TextStyle(color: color.withOpacity(0.7), fontSize: 10)),
        ],
      ),
    );
  }
}

// lib/widgets/achieve_tile.dart
class AchieveTile extends StatelessWidget {
  final String id;
  final bool unlocked;

  const AchieveTile({super.key, required this.id, required this.unlocked});

  static const _meta = {
    'level1_complete': {'icon': '🔤', 'title': 'መምህር ፊደላት - Alphabet Master', 'desc': 'ደረጃ 1 ወዲእኩም - Completed Level 1'},
    'level2_complete': {'icon': '📝', 'title': 'ናይ ቃላት ብልሓተኛ - Word Wizard', 'desc': 'ደረጃ 2 ወዲእኩም - Completed Level 2'},
    'level3_complete': {'icon': '💬', 'title': 'ናይ ምሉእ ሓሳባት ምኩር  - Sentence Sage', 'desc': 'ደረጃ 3 ወዲእኩም - Completed Level 3'},
    'all_levels_complete': {'icon': '🏆', 'title': 'ጎብለል ትግርኛ - Tigrigna Champion', 'desc': 'ኩሎም ደረጃታት ወዲእኩም - Completed all levels!'},
    'xp_100': {'icon': '⭐', 'title': '100 XP', 'desc': '100 XP ኣኪብኩም - Earned 100 XP'},
    'xp_500': {'icon': '🌟', 'title': '500 XP', 'desc': '500 XP ኣኪብኩም - Earned 500 XP'},
    'xp_1000': {'icon': '💫', 'title': '1000 XP', 'desc': '100 XP ኣኪብኩም - Earned 1000 XP'},
  };

  @override
  Widget build(BuildContext context) {
    final m = _meta[id] ?? {'icon': '🎯', 'title': id, 'desc': ''};
    return Opacity(
      opacity: unlocked ? 1.0 : 0.35,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: unlocked ? const Color(0xFFFFF9C4) : Colors.grey[100],
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: unlocked ? const Color(0xFFFFD54F) : Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Text(m['icon']!, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(m['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text(m['desc']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Spacer(),
            if (unlocked) const Icon(Icons.check_circle, color: Color(0xFFFFD54F)),
          ],
        ),
      ),
    );
  }
}

// lib/widgets/stroke_painter.dart
class StrokePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final Color color;
  final double strokeWidth;

  const StrokePainter({
    required this.strokes,
    this.color = const Color(0xFF5C6BC0),
    this.strokeWidth = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.length < 2) continue;
      final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(StrokePainter old) =>
      old.strokes != strokes || old.color != color;
}
