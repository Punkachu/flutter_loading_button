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
          title: const Text('Simulated Progress'),
        ),
        body: const Center(
          child: DownloadProgressWidget(),
        ),
      ),
    );
  }
}

class DownloadProgressWidget extends StatelessWidget {
  const DownloadProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<int>(
        stream: simulateProgress(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              "${snapshot.data!} %",
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Text(
              'Waiting for progress...',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
            );
          }
        },
      ),
    );
  }

  Stream<int> simulateProgress() async* {
    Random random = Random();
    for (int i = 0; i <= 100; i += random.nextInt(12) + 2) {
      final int milliseconds = random.nextInt(1500) + 200;
      await Future.delayed(Duration(milliseconds: milliseconds));
      yield i;
    }
    yield 100;
  }
}
