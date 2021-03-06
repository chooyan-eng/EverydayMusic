import 'package:flutter/material.dart';
import 'package:music_everyday/bloc/question_bloc.dart';
import 'package:music_everyday/model/note.dart';
import 'package:music_everyday/view/free_play_page.dart';
import 'package:provider/provider.dart';

class FreePlayScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionBloc()..reset(
        List.generate(8, (index) => Note.random()),
      ),
      child: FreePlayPage(),
    );
  }
}