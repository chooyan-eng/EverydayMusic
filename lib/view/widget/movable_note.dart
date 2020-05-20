import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_everyday/constants.dart';
import 'package:music_everyday/model/note.dart';

class MovableNote extends StatelessWidget {
  final int index;
  final Note note;
  final Function(DragDownDetails) onPanDown;
  final Function(DragUpdateDetails) onPanUpdate;
  final Function(DragEndDetails) onPanEnd;

  const MovableNote({
    Key key,
    this.index,
    this.note,
    this.onPanDown,
    this.onPanUpdate,
    this.onPanEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: Constants.startLeft + Constants.marginLeft * index,
      bottom: _calcBottom(note.currentKind ?? NoteKind.e),
      child: GestureDetector(
        onPanDown: onPanDown,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        child: Container(
          color: Colors.blue.withAlpha(0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Transform.rotate(
              angle: NoteKind.values.indexOf(note.currentKind ?? NoteKind.e) >= 6
                  ? pi
                  : 0,
              child: Opacity(
                opacity: note.currentKind == null ? 0.1 : 1.0,
                child: Image.asset(
                  note.currentKind == NoteKind.c
                      ? 'assets/images/onpu_do.png'
                      : 'assets/images/onpu.png',
                  height: Constants.onpuHeight,
                  color: note.hasError
                      ? Colors.red.shade400
                      : note.isCorrect ? Colors.blue.shade400 : null,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calcBottom(NoteKind noteKind) {
    if (noteKind.index < 6) {
      return Constants.bottomBase + Constants.noteGap * noteKind.index;
    } else {
      return Constants.bottomBaseReverse +
          Constants.noteGap * (noteKind.index - 6) +
          Constants.bottomRotateGap;
    }
  }
}
