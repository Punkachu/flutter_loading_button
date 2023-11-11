import 'package:clay_containers/widgets/clay_text.dart';
import 'package:flutter/material.dart';

class LoadingText extends StatelessWidget {
  final double loadingValue;
  final double textSize;
  final Color? textColor;

  const LoadingText({
    required this.loadingValue,
    this.textSize = 27,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClayText(
      loadingValue < 100
          ? "${loadingValue.roundToDouble()}% Downloading..."
          : 'COMPLETE',
      emboss: true,
      size: textSize,
      textColor: textColor ?? Color(0xFFffcc00).withOpacity(0.5),
      //parentColor: Colors.grey[300],
      //color: const Color(0xFFffcc00).withOpacity(0.1),
      //depth: 4,
      //spread: 3,
    );
  }
}
