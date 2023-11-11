import 'dart:async';

import 'package:fancy_loading_button/widgets/download_button.dart';
import 'package:flutter/material.dart';

class DownloadButtonPage extends StatefulWidget {
  @override
  _DownloadButtonPageState createState() => _DownloadButtonPageState();
}

class _DownloadButtonPageState extends State<DownloadButtonPage> {
  late StreamController<int> _progressStreamController;
  late Stream<int> _progressStream;

  @override
  void initState() {
    super.initState();

    _progressStreamController = StreamController<int>();
    _progressStream = _progressStreamController.stream;

    // Simulate progress updates
    simulateProgress();
  }

  // Simulates progress updates and adds values to the stream
  void simulateProgress() async {
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(Duration(milliseconds: i * 50));
      _progressStreamController.add(i);
    }
    _progressStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _progressStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DownloadButton(
            progress: snapshot.data!,
            firstIconColor: Colors.black45,
            secondIconColor: const Color(0xFFffd11a).withOpacity(0.9),
            baseColor: const Color(0xFFf2f2f2),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Waiting for progress...');
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
