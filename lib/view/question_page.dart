import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_everyday/bloc/question_bloc.dart';
import 'package:music_everyday/model/note.dart';
import 'package:music_everyday/view/widget/line.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatelessWidget {
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
        return Scaffold(
          appBar: AppBar(),
          body: Stack(
            children: <Widget>[
              SafeArea(
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
                                        bloc.noteList[index].hasError = false;
                                        bloc.noteList[index].isCorrect = false;
                                        bloc.panDownY = details.localPosition.dy;
                                        bloc.initialIndex = NoteKind.values.indexOf(bloc.noteList[index].currentKind);
                                      },
                                      onPanUpdate: (details) => bloc.updateDy(index, details.localPosition.dy),
                                      onPanEnd: (details) {
                                        bloc.soundCurrent(index);
                                      },
                                      child: Transform.rotate(
                                        angle: NoteKind.values.indexOf(bloc.noteList[index].currentKind ?? NoteKind.e) >= 6 ? pi : 0,
                                        child: Opacity(
                                          opacity: bloc.noteList[index].currentKind == null ? 0.1 : 1.0,
                                          child: Image.asset(
                                            bloc.noteList[index].currentKind == NoteKind.c ? 'assets/images/onpu_do.png' : 'assets/images/onpu.png', 
                                            height: onpuHeight,
                                            color: bloc.noteList[index].hasError ? Colors.red.shade400 : bloc.noteList[index].isCorrect ? Colors.blue.shade400 : null,
                                          ),
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
                                  width: 72,
                                  child: Center(child: Text(bloc.noteList[index].correctKind.toKatakana(), style: TextStyle(fontSize: 24))),
                                ),
                                const SizedBox(width: 8),
                              ];
                            }).toList()
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FloatingActionButton.extended(
              onPressed: bloc.isAnswerable ? () async {
                await bloc.soundAll();
                if (bloc.noteList.every((element) => element.isCorrect)) {
                  await Future.delayed(const Duration(milliseconds: 300));
                  bloc.reset(
                    List.generate(8, (index) => Note.random()),
                  );
                }
              } : null,
              label: Center(
                child: Container(
                  width: 100,
                  child: Text('こたえあわせ', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              icon: Icon(Icons.check, color: Colors.white),
              backgroundColor: bloc.isAnswerable ? Colors.green : Colors.grey,
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