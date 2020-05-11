import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_everyday/model/note.dart';

class QuestionBloc extends ChangeNotifier {
  final noteList = <Note>[];
  double panDownY = -1;
  int initialIndex = -1;

  void updateCurrentKind(int index, NoteKind to) {
    noteList[index].currentKind = to;
    notifyListeners();
  }

  void updateDy(int index, double dy) {
    int noteGap = (panDownY - dy) ~/ 12.0;
    final nextNoteIndex = max(0, min(initialIndex + noteGap, NoteKind.values.length -1));
    noteList[index].currentKind = NoteKind.values[nextNoteIndex];
    notifyListeners();
  }
}