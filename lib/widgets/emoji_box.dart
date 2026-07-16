// lib/widgets/emoji_box.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
 
class EmojiBox extends StatefulWidget {
  final String character;
  final String? romanization;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback? onTap;
  final double size;
 
  const EmojiBox({
    super.key,
    required this.character,
    this.romanization,
    this.isSelected = false,
    this.isCorrect = false,
    this.onTap,
    this.size = 80,
  });
 
  @override
  State<EmojiBox> createState() => _EmojiBoxState();
}
 
class _EmojiBoxState extends State<EmojiBox> with SingleTickerProviderStateMixin {
  late AnimationController _bounceController;
 
  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
  }
 
  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    Color boxColor;
    Color borderColor;
    if (widget.isSelected && widget.isCorrect) {
      boxColor = const Color(0xFF4CAF50).withOpacity(0.2);
      borderColor = const Color(0xFF4CAF50);
    } else if (widget.isSelected && !widget.isCorrect) {
      boxColor = const Color(0xFFF44336).withOpacity(0.2);
      borderColor = const Color(0xFFF44336);
    } else if (widget.isSelected) {
      boxColor = const Color(0xFF2196F3).withOpacity(0.2);
      borderColor = const Color(0xFF2196F3);
    } else {
      boxColor = Colors.white;
      borderColor = const Color(0xFFE0E0E0);
    }
 
    return GestureDetector(
      onTap: () {
        _bounceController.forward().then((_) => _bounceController.reverse());
        widget.onTap?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: borderColor.withOpacity(0.3),
              blurRadius: widget.isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.character,
              style: TextStyle(
                fontSize: widget.size * 0.45,
                fontFamily: 'AbyssinicaSIL',
                height: 1.2,
              ),
            ),
            if (widget.romanization != null)
              Text(
                widget.romanization!,
                style: TextStyle(
                  fontSize: widget.size * 0.14,
                  color: Colors.grey[600],
                  letterSpacing: 0.5,
                ),
              ),
          ],
        ),
      ),
    ).animate(target: widget.isSelected ? 1 : 0)
        .scaleXY(end: 1.05, curve: Curves.easeOut, duration: 150.ms);
  }
}