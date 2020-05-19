import 'package:flutter/material.dart';
import 'package:music_everyday/view/free_play_scene.dart';
import 'package:music_everyday/view/listen_sound_scene.dart';
import 'package:music_everyday/view/question_scene.dart';

class SelectModePage extends StatelessWidget {

  void _navigateToQuiz(BuildContext context, int mode) {
    switch(mode) {
      case 0: 
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionScene()));
        break;
      case 1: 
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListenSoundScene()));
        break;
      case 2: 
        Navigator.push(context, MaterialPageRoute(builder: (context) => FreePlayScene()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                'モードをえらんでください',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _buildLevelSelect('おんぷえらび', Colors.purple, () => _navigateToQuiz(context, 0)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 1,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _buildLevelSelect('おとあて', Colors.lightGreen, () => _navigateToQuiz(context, 1)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Container(
                  height: 1,
                  color: Colors.black12,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _buildLevelSelect('じゆうにならべる', Colors.blue, () => _navigateToQuiz(context, 2)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelSelect(String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
