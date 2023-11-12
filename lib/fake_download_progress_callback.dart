import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fake Download Progress'),
        ),
        body: Center(
          child: ExternalProgressWidget(),
        ),
      ),
    );
  }
}

class ExternalProgressWidget extends StatefulWidget {
  @override
  _ExternalProgressWidgetState createState() => _ExternalProgressWidgetState();
}

class _ExternalProgressWidgetState extends State<ExternalProgressWidget> {
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
      Random random = Random();
      final int milliseconds = random.nextInt(1500) + 200;
      await Future.delayed(Duration(milliseconds: milliseconds));
      _progressStreamController.add(i);
    }
    _progressStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: _progressStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text("${snapshot.data!} %");
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Text('Waiting for progress...');
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _progressStreamController.close();
    super.dispose();
  }
}
