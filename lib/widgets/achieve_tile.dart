// lib/widgets/achieve_tile.dart
import 'package:flutter/material.dart';
 
class AchieveTile extends StatelessWidget {
  final String id;
  final bool unlocked;
 
  const AchieveTile({super.key, required this.id, required this.unlocked});
 
  static const _meta = {
    'level1_complete': {
      'icon': '🔤',
      'title': 'መምህር ፊደላት - Alphabet Master',
      'desc': 'ደረጃ 1 ወዲእኩም - Completed Level 1'
    },
    'level2_complete': {
      'icon': '📝',
      'title': 'ናይ ቃላት ብልሓተኛ - Word Wizard',
      'desc': 'ደረጃ 2 ወዲእኩም - Completed Level 2'
    },
    'level3_complete': {
      'icon': '💬',
      'title': 'ናይ ምሉእ ሓሳባት ምኩር  - Sentence Sage',
      'desc': 'ደረጃ 3 ወዲእኩም - Completed Level 3'
    },
    'all_levels_complete': {
      'icon': '🏆',
      'title': 'Tigrigna Champion',
      'desc': 'ደረጃ 1 ወዲእኩም - Completed all levels!'
    },
    'xp_100': {'icon': '⭐', 'title': '100 XP', 'desc': '100 XP ኣኪብኩም - Earned 100 XP'},
    'xp_500': {'icon': '🌟', 'title': '500 XP', 'desc': '500 XP ኣኪብኩም - Earned 500 XP'},
    'xp_1000': {'icon': '💫', 'title': '1000 XP', 'desc': '1000 XP ኣኪብኩም - Earned 1000 XP'},
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
          border: Border.all(
              color: unlocked
                  ? const Color(0xFFFFD54F)
                  : Colors.grey[300]!),
        ),
        child: Row(
          children: [
            Text(m['icon']!, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m['title']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(m['desc']!,
                    style:
                        TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
            const Spacer(),
            if (unlocked)
              const Icon(Icons.check_circle, color: Color(0xFFFFD54F)),
          ],
        ),
      ),
    );
  }
}