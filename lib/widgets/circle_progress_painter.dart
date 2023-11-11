import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPainter extends CustomPainter {
  final Animation<double> animation;
  final Color glowColor;
  final Color progressColor;
  final ImageFilter? blur;
  final double strokeWidth;
  final double? strokeShadowWidth;

  CircularProgressPainter({
    required this.animation,
    required this.glowColor,
    required this.progressColor,
    this.strokeWidth = 5,
    this.strokeShadowWidth,
    this.blur,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final glowPaint = Paint()
      ..color = glowColor
      ..imageFilter = blur ??
          ImageFilter.blur(
            sigmaY: 7,
            sigmaX: 7,
          )
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = strokeShadowWidth ?? (strokeWidth + 4);

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 5;

    final progress = (animation.value) * 2 * pi;

    // Draw the neon glow
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progress,
      false,
      glowPaint,
    );

    // Draw the progress indicator over the glow
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
