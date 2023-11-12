import 'dart:ui';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../painter/circle_progress_painter.dart';
import 'loading_text.dart';

class DownloadButton extends StatelessWidget {
  final double progress;

  final Color baseColor;
  final Color firstIconColor;
  final Color secondIconColor;

  final String svgPath;

  final String filename;

  const DownloadButton(
      {required this.progress,
      required this.filename,
      required this.firstIconColor,
      required this.secondIconColor,
      this.svgPath = 'assets/svg_files/download.svg',
      this.baseColor = const Color(0xFFf2f2f2),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress / 100),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        final Color cloudColor =
            progress >= 100 ? secondIconColor.withAlpha(90) : firstIconColor;
        final bool isPushed = progress > 0.1 ? true : false;

        return Center(
          child: Container(
            color: baseColor,
            child: Stack(
              children: [
                /// TITLE
                Align(
                  alignment: const Alignment(0.0, -0.6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ClayText(
                      "DOWNLOADING: $filename",
                      emboss: true,
                      size: 27,
                      textColor: const Color(0xff797676)
                          .withAlpha(50)
                          .withOpacity(0.5),
                      //parentColor: Colors.grey[300],
                      //color: const Color(0xFFffcc00).withOpacity(0.1),
                      //depth: 4,
                      //spread: 3,
                    ),
                  ),
                ),

                /// EXTERNAL CIRCLE
                Center(
                  child: ClayContainer(
                      color: baseColor,
                      surfaceColor: Colors.grey[400],
                      height: 260,
                      width: 260,
                      borderRadius: 200,
                      curveType: CurveType.concave,
                      spread: 10,
                      depth: 20,
                      emboss: false,
                      child: null),
                ),

                /// CENTRAL BUTTON
                Center(
                  child: ClayContainer(
                      color: baseColor,
                      height: 240,
                      width: 240,
                      borderRadius: 200,
                      curveType: CurveType.convex,
                      spread: 30,
                      depth: 50,
                      child: null),
                ),

                /// Circular slider
                Center(
                  child: CustomPaint(
                    size: const Size(260, 260),
                    painter: CircularProgressPainter(
                      progress: value,
                      strokeWidth: 10,
                      glowColor: const Color(0xFFffff00).withAlpha(70),
                      progressColor: const Color(0xFFffcc00).withAlpha(50),
                      blur: ImageFilter.blur(
                        sigmaY: 16,
                        sigmaX: 16,
                      ),
                    ),
                  ),
                ),

                /// INNER CIRCLE
                Center(
                  child: ClayContainer(
                      color: baseColor,
                      height: 150,
                      width: 150,
                      borderRadius: 200,
                      curveType:
                          !isPushed ? CurveType.convex : CurveType.concave,
                      spread: 1,
                      depth: 20,
                      emboss: true,
                      child: null),
                ),

                /// ICON
                Center(
                  child: GestureDetector(
                    // onTapDown: (TapDownDetails details) {
                    //   setState(() {
                    //     isPushed = false;
                    //   });
                    // },
                    // onTapUp: (TapUpDetails details) {
                    //   setState(() {
                    //     isPushed = true;
                    //   });
                    //   onTapPushButton();
                    // },
                    child: SvgPicture.asset(
                      svgPath,
                      color: cloudColor,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),

                /// LOADING TEXT
                Align(
                    alignment: const Alignment(0.0, 0.4),
                    child: LoadingText(loadingValue: value * 100)),
              ],
            ),
          ),
        );
      },
    );
  }
}
