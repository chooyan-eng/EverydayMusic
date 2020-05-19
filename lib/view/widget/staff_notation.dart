import 'package:flutter/material.dart';
import 'package:music_everyday/constants.dart';
import 'package:music_everyday/view/widget/line.dart';

class StafNotation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 40),
        Line(),
        SizedBox(height: Constants.lineHeight),
        Line(),
        SizedBox(height: Constants.lineHeight),
        Line(),
        SizedBox(height: Constants.lineHeight),
        Line(),
        SizedBox(height: Constants.lineHeight),
        Line(),
      ],
    );
  }
}