// lib/widgets/stroke_painter.dart
import 'package:flutter/material.dart';
 
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