import 'package:flutter/material.dart';
import 'package:music_everyday/bloc/question_bloc.dart';
import 'package:music_everyday/model/note.dart';
import 'package:music_everyday/view/widget/movable_note.dart';
import 'package:music_everyday/view/widget/staff_notation.dart';
import 'package:provider/provider.dart';

class QuestionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionBloc>(
      builder: (context, bloc, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('おんぷえらび'),
          ),
          body: Stack(
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 800,
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              StafNotation(),
                              Positioned(
                                left: -40,
                                child: Image.asset(('assets/images/toonkigou.png'), height: 192,),
                              ),
                              ...bloc.noteList.expand((note) {
                                final index = bloc.noteList.indexOf(note);
                                return [
                                  MovableNote(
                                    note: bloc.noteList[index],
                                    index: index,
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
                                    onPanEnd: (details) => bloc.soundCurrent(index),
                                  ),
                                ];
                              }).toList(),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(width: 64),
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
                await bloc.soundAll(shouldUpdateState: true);
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
}