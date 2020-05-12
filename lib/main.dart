import 'package:flutter/material.dart';
import 'package:music_everyday/view/question_scene.dart';
import 'package:music_everyday/view/select_mode_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SelectModePage(),
    );
  }
}