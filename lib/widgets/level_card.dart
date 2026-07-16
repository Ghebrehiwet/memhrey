// lib/widgets/level_card.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/level_meta.dart';
 
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
                        Row(
    children: List.generate(
        level.stars,
        (_) => const Text('⭐', style: TextStyle(fontSize: 14)))),
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
              unlocked ? Icons.arrow_forward_ios_rounded : Icons.lock_outline_rounded,
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