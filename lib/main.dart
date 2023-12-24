import 'package:flutter/material.dart';

import 'download_button_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Download Button',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),
        useMaterial3: true,
      ),
      home: const Scaffold(
        backgroundColor: Color(0xFFf2f2f2),
        body: DownloadButtonPage(filename: "Star_Wars_Rogue_One.rar"),
      ),
    );
  }
}
