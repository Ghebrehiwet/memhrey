// lib/widgets/option_tile.dart
import 'package:flutter/material.dart';
 
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
      if (isCorrect == true) {
        bg = const Color(0xFFE8F5E9);
        border = const Color(0xFF4CAF50);
        textColor = const Color(0xFF2E7D32);
      } else if (isCorrect == false) {
        bg = const Color(0xFFFFEBEE);
        border = const Color(0xFFF44336);
        textColor = const Color(0xFFC62828);
      } else {
        bg = const Color(0xFFE3F2FD);
        border = const Color(0xFF2196F3);
        textColor = const Color(0xFF1565C0);
      }
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
          boxShadow: [
            BoxShadow(
                color: border.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                  color: border.withOpacity(0.15), shape: BoxShape.circle),
              child: Center(
                  child: Text(
                ['A', 'B', 'C', 'D'][index],
                style: TextStyle(
                    color: border,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              )),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Text(text,
                    style: TextStyle(
                        fontFamily: 'AbyssinicaSIL',
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.w500))),
            if (isSelected)
              Icon(
                  isCorrect == true
                      ? Icons.check_circle
                      : (isCorrect == false
                          ? Icons.cancel
                          : Icons.radio_button_checked),
                  color: border,
                  size: 22),
          ],
        ),
      ),
    );
  }
}