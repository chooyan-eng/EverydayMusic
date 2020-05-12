import 'package:flutter/material.dart';
import 'package:music_everyday/bloc/question_bloc.dart';
import 'package:music_everyday/model/note.dart';
import 'package:music_everyday/view/question_page.dart';
import 'package:provider/provider.dart';

class QuestionScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => QuestionBloc()..reset([
          Note(correctKind: NoteKind.upperC, currentKind: null),
          Note(correctKind: NoteKind.c, currentKind: null),
          Note(correctKind: NoteKind.d, currentKind: null),
          Note(correctKind: NoteKind.f, currentKind: null),
          Note(correctKind: NoteKind.a, currentKind: null),
        ]),
        child: QuestionPage(),
      ),
    );
  }
}