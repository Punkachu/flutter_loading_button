import 'dart:async';
import 'dart:math';

import 'package:fancy_loading_button/widgets/download_button.dart';
import 'package:flutter/material.dart';

class DownloadButtonPage extends StatefulWidget {
  @override
  _DownloadButtonPageState createState() => _DownloadButtonPageState();
}

class _DownloadButtonPageState extends State<DownloadButtonPage> {
  late StreamController<double> _progressStreamController;
  late Stream<double> _progressStream;

  @override
  void initState() {
    super.initState();

    _progressStreamController = StreamController<double>();
    _progressStream = _progressStreamController.stream;

    // Simulate progress updates
    simulateProgress();
  }

  // Simulates progress updates and adds values to the stream
  void simulateProgress() async {
    for (int i = 0; i <= 100; i += 10) {
      Random random = Random();
      final int milisec = random.nextInt(1500) + 200;
      await Future.delayed(Duration(milliseconds: milisec));
      _progressStreamController.add(i + (i * 0.3));
    }
    _progressStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _progressStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DownloadButton(
            filename: "Star_Wars_Rogue_One.rar",
            progress: snapshot.data!,
            firstIconColor: Colors.black45,
            secondIconColor: const Color(0xFFffd11a).withOpacity(0.9),
            baseColor: const Color(0xFFf2f2f2),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return DownloadButton(
            filename: "Star_Wars_Rogue_One.rar",
            progress: 0,
            firstIconColor: Colors.black45,
            secondIconColor:
                const Color(0xFFffd11a).withAlpha(255).withOpacity(0.9),
            baseColor: const Color(0xFFf2f2f2),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _progressStreamController.close();
    super.dispose();
  }
}
