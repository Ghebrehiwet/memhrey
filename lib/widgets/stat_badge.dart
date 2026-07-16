// lib/widgets/stat_badge.dart
import 'package:flutter/material.dart';
 
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
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label,
              style: TextStyle(color: color.withOpacity(0.7), fontSize: 10)),
        ],
      ),
    );
  }
}