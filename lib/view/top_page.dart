import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_everyday/bloc/question_bloc.dart';
import 'package:music_everyday/model/note.dart';
import 'package:music_everyday/view/widget/line.dart';
import 'package:provider/provider.dart';

class TopPage extends StatelessWidget {
  final lineHeight = 24.0;
  final onpuHeight = 96.0;
  final startLeft = 120.0;
  final marginLeft = 80.0;

  /// 下からの位置計算用（上むき音符）
  final bottomBase = 24.0;
  final noteGap = 12.0;

  /// 下からの位置計算用（上むき音符）
  final bottomBaseReverse = 24.0;
  final bottomRotateGap = 2.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionBloc>(
      builder: (context, bloc, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 40),
                            Line(),
                            SizedBox(height: lineHeight),
                            Line(),
                            SizedBox(height: lineHeight),
                            Line(),
                            SizedBox(height: lineHeight),
                            Line(),
                            SizedBox(height: lineHeight),
                            Line(),
                          ],
                        ),
                        Positioned(
                          left: -40,
                          child: Image.asset(('assets/images/toonkigou.png'), height: 192,),
                        ),
                        ...bloc.noteList.expand((note) {
                          final index = bloc.noteList.indexOf(note);
                          return [
                            Positioned(
                              left: startLeft + marginLeft * index,
                              bottom: _calcBottom(bloc.noteList[index].currentKind ?? NoteKind.e),
                              child: GestureDetector(
                                onPanDown: (details) {
                                  if (bloc.noteList[index].currentKind == null) {
                                    bloc.updateCurrentKind(index, NoteKind.e);
                                  }
                                  bloc.panDownY = details.localPosition.dy;
                                  bloc.initialIndex = NoteKind.values.indexOf(bloc.noteList[index].currentKind);
                                },
                                onPanUpdate: (details) {
                                  bloc.updateDy(index, details.localPosition.dy);
                                },
                                child: Transform.rotate(
                                  angle: NoteKind.values.indexOf(bloc.noteList[index].currentKind ?? NoteKind.e) >= 6 ? pi : 0,
                                  child: Opacity(
                                    opacity: bloc.noteList[index].currentKind == null ? 0.1 : 1.0,
                                    child: Image.asset(bloc.noteList[index].currentKind == NoteKind.c ? 'assets/images/onpu_do.png' : 'assets/images/onpu.png', height: onpuHeight),
                                  ),
                                ),
                              ),
                            ),
                          ];
                        }).toList(),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 112),
                      ...bloc.noteList.expand((note) {
                        final index = bloc.noteList.indexOf(note);
                        return [
                          Container(
                            width: 60,
                            child: Center(child: Text(bloc.noteList[index].correctKind.toHiragana(), style: TextStyle(fontSize: 24))),
                          ),
                          const SizedBox(width: 21),
                        ];
                      }).toList()
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  double _calcBottom(NoteKind noteKind) {
    final noteIndex = NoteKind.values.indexOf(noteKind);
    if (noteIndex < 6) {
      return bottomBase + noteGap * noteIndex;
    } else {
      return bottomBaseReverse + noteGap * (noteIndex - 6) + bottomRotateGap;
    }
  }
}