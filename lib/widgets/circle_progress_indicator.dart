import 'dart:ui';

import 'package:flutter/material.dart';

import 'circle_progress_painter.dart';

class MyCircularProgressIndicator extends StatelessWidget {
  final Color glowColor;
  final Color progressColor;
  final ImageFilter? blur;
  final double? strokeWidth;
  final double? strokeShadowWidth;
  final Animation<double> animation;
  const MyCircularProgressIndicator(
      {required this.glowColor,
      required this.progressColor,
      required this.animation,
      this.blur,
      this.strokeShadowWidth,
      this.strokeWidth,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      willChange: true,
      painter: CircularProgressPainter(
        animation: animation,
        glowColor: glowColor,
        progressColor: progressColor,
        blur: blur,
        strokeWidth: strokeWidth ?? 5,
        strokeShadowWidth: strokeShadowWidth,
      ),
    );
  }
}
