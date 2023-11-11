import 'package:fancy_loading_button/widgets/download_button.dart';
import 'package:flutter/material.dart';

class DownloadButtonPage extends StatelessWidget {
  const DownloadButtonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      body: DownloadButton(
        firstIconColor: Colors.black45,
        secondIconColor: const Color(0xFFffd11a).withOpacity(0.9),
        baseColor: const Color(0xFFf2f2f2),
        beginAnimation: 0.0,
        endAnimation: 1.0,
      ),
    );
  }
}
