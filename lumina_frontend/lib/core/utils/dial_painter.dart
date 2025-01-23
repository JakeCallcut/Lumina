import 'package:flutter/material.dart';
import 'dart:math';

import 'package:lumina_frontend/core/themes/main_theme.dart';


///Class to paint the sweeping portion of a dial used in various places in our app
///
///Parameters:
///
///portion: The portion of the dial to be painted
///
///radius: The radius of the dial
class DialPainter extends CustomPainter {
  final Color color;
  final double portion;
  final double radius;

  DialPainter(this.portion, this.radius, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final sweepAngle = 2 * -pi * portion;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
