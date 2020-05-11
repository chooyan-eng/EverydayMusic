import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_everyday/view/widget/line.dart';

class TopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lineHeight = 24.0;
    final onpuHeight = 96.0;
    final startLeft = 120.0;
    final startTop = 8.0;
    final topRotateGap = 2.0;
    final marginLeft = 80.0;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
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
                      Positioned(
                        left: startLeft,
                        top: startTop + lineHeight / 2,
                        child: Image.asset(('assets/images/onpu.png'), height: onpuHeight,),
                      ),
                      Positioned(
                        left: startLeft + marginLeft * 1,
                        top: startTop + lineHeight,
                        child: Image.asset(('assets/images/onpu.png'), height: onpuHeight,),
                      ),
                      Positioned(
                        left: startLeft + marginLeft * 2,
                        top: startTop + lineHeight * 2,
                        child: Image.asset(('assets/images/onpu.png'), height: onpuHeight,),
                      ),
                      Positioned(
                        left: startLeft + marginLeft * 3,
                        top: startTop + lineHeight * 2,
                        child: Opacity(
                          opacity: 0.1,
                          child: Image.asset(('assets/images/onpu.png'), height: onpuHeight),
                        ),
                      ),
                      Positioned(
                        left: startLeft + marginLeft * 4,
                        top: startTop + lineHeight * 3 - topRotateGap,
                        child: Transform.rotate(
                          angle: pi,
                          child: Opacity(
                            opacity: 1.0,
                            child: Image.asset(('assets/images/onpu.png'), height: onpuHeight),
                          ),
                        ),
                      ),
                      Positioned(
                        left: startLeft + marginLeft * 5,
                        top: startTop + lineHeight * 2.5 - topRotateGap,
                        child: Transform.rotate(
                          angle: pi,
                          child: Opacity(
                            opacity: 1.0,
                            child: Image.asset(('assets/images/onpu.png'), height: onpuHeight),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(width: 128),
                    Text('ラ', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 52),
                    Text('ソ', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 52),
                    Text('ミ', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 52),
                    Text('ド', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 52),
                    Text('シ', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 52),
                    Text('ド', style: TextStyle(fontSize: 24, color: Colors.blue)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}