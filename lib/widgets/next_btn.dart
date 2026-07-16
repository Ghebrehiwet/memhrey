// lib/widgets/next_btn.dart
import 'package:flutter/material.dart';
 
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
    this.icon = Icons.arrow_forward_rounded,
  });
 
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.4,
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton.icon(
        onPressed: isEnabled ? onTap : null,
        icon: Icon(icon, size: 20),
        label: Text(label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5C6BC0),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 4,
        ),
      ),
    );
  }
}