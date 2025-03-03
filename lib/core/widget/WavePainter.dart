import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade800
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7); // Start at the bottom-left
    path.quadraticBezierTo(
      size.width * 0.25, size.height * 0.6, // Control point 1
      size.width * 0.5, size.height * 0.7, // End point 1
    );
    path.quadraticBezierTo(
      size.width * 0.75, size.height * 0.8, // Control point 2
      size.width, size.height * 0.7, // End point 2
    );
    path.lineTo(size.width, 0); // Draw to the top-right
    path.lineTo(0, 0); // Draw to the top-left
    path.close(); // Close the path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint unless the wave changes
  }
}