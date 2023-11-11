import 'dart:ui';

import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'circle_progress_indicator.dart';
import 'loading_text.dart';

class DownloadButton extends StatefulWidget {
  final Color baseColor;
  final Color firstIconColor;
  final Color secondIconColor;
  final double initLoading;
  final String svgPath;
  final double beginAnimation;
  final double endAnimation;

  const DownloadButton({
    required this.firstIconColor,
    required this.secondIconColor,
    required this.beginAnimation,
    required this.endAnimation,
    this.svgPath = 'assets/svg_files/download.svg',
    this.initLoading = 0.0,
    this.baseColor = const Color(0xFFf2f2f2),
    Key? key,
  }) : super(key: key);

  DownloadButtonPageState createState() => DownloadButtonPageState();
}

class DownloadButtonPageState extends State<DownloadButton>
    with SingleTickerProviderStateMixin {
  late double loading;
  late Color cloudColor;

  late final Animation<double> animation;
  late final AnimationController _controller;

  bool isPushed = false;

  @override
  void initState() {
    loading = widget.initLoading;
    cloudColor = widget.firstIconColor;

    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);

    animation =
        Tween<double>(begin: widget.beginAnimation, end: widget.endAnimation)
            .animate(_controller)
          ..addListener(() {
            setState(() {
              loading = animation.value * 100;
              if (loading >= 100.0) {
                cloudColor = widget.secondIconColor.withAlpha(90);
              }
            });
          });
    //_controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTapPushButton() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: widget.baseColor,
        child: Stack(
          children: [
            /// EXTERNAL CIRCLE
            Center(
              child: ClayContainer(
                  color: widget.baseColor,
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
                  color: widget.baseColor,
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
              child: Container(
                width: 260,
                height: 260,
                color: Colors.transparent,
                child: MyCircularProgressIndicator(
                  // animationDuration: const Duration(seconds: 2),
                  // beginAnimation: 0.0,
                  // endAnimation: 1.0,
                  animation: animation,
                  strokeWidth: 10,
                  glowColor: const Color(0xFFffff00).withAlpha(70),
                  progressColor: const Color(0xFFffcc00).withAlpha(50),
                  blur: ImageFilter.blur(
                    sigmaY: 6,
                    sigmaX: 6,
                  ),
                ),
              ),
            ),

            /// INNER CIRCLE
            Center(
              child: ClayContainer(
                  color: widget.baseColor,
                  height: 150,
                  width: 150,
                  borderRadius: 200,
                  curveType: !isPushed ? CurveType.convex : CurveType.concave,
                  spread: 1,
                  depth: 20,
                  emboss: true,
                  child: null),
            ),

            /// ICON
            Center(
              child: GestureDetector(
                onTapDown: (TapDownDetails details) {
                  setState(() {
                    isPushed = false;
                  });
                },
                onTapUp: (TapUpDetails details) {
                  setState(() {
                    isPushed = true;
                  });
                  onTapPushButton();
                },
                child: SvgPicture.asset(
                  widget.svgPath,
                  color: cloudColor,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),

            /// LOADING TEXT
            Align(
                alignment: const Alignment(0.0, 0.4),
                child: LoadingText(loadingValue: loading)),
          ],
        ),
      ),
    );
  }
}
