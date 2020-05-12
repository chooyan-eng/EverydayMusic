import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_everyday/model/note.dart';
import 'package:soundpool/soundpool.dart';

class QuestionBloc extends ChangeNotifier {
  final noteList = <Note>[];
  final soundKeyList = <NoteKind, int>{};
  double panDownY = -1;
  int initialIndex = -1;
  final pool = Soundpool(streamType: StreamType.notification);

  Future<void> reset(List<Note> notes) async {
    noteList.clear();
    noteList.addAll(notes);
    for (NoteKind noteKind in NoteKind.values) {
      if (!soundKeyList.containsKey(noteKind)) {
        final soundData = await rootBundle.load('assets/sounds/${noteKind.toSoundFileName()}.mp3');
        int soundId = await pool.load(soundData);
        soundKeyList[noteKind] = soundId;
      }
    }
    notifyListeners();
  }

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

  Future<void> soundCurrent(int index) async {
    await pool.play(soundKeyList[noteList[index].currentKind]);
  }

  void updateState(int index) {
    noteList[index].hasError = noteList[index].correctKind != noteList[index].currentKind;
    noteList[index].isCorrect = noteList[index].correctKind == noteList[index].currentKind;
    notifyListeners();
  }
}