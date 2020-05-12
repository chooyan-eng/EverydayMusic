import 'dart:math';

enum NoteKind {
  c,
  d,
  e,
  f,
  g,
  a,
  h,
  upperC,
  upperD,
  upperE,
  upperF,
  upperG,
}

extension NoteKindLetter on NoteKind {
  String toHiragana() => <NoteKind, String>{
    NoteKind.c: 'ど',
    NoteKind.d: 'れ',
    NoteKind.e: 'み',
    NoteKind.f: 'ふぁ',
    NoteKind.g: 'そ',
    NoteKind.a: 'ら',
    NoteKind.h: 'し',
    NoteKind.upperC: 'ど↑',
    NoteKind.upperD: 'れ↑',
    NoteKind.upperE: 'み↑',
    NoteKind.upperF: 'ふぁ↑',
    NoteKind.upperG: 'そ↑',
  }[this];

  String toKatakana() => <NoteKind, String>{
    NoteKind.c: 'ド',
    NoteKind.d: 'レ',
    NoteKind.e: 'ミ',
    NoteKind.f: 'ファ',
    NoteKind.g: 'ソ',
    NoteKind.a: 'ラ',
    NoteKind.h: 'シ',
    NoteKind.upperC: 'ド↑',
    NoteKind.upperD: 'レ↑',
    NoteKind.upperE: 'ミ↑',
    NoteKind.upperF: 'ファ↑',
    NoteKind.upperG: 'ソ↑',
  }[this];
}

extension NoteKindSound on NoteKind {
  String toSoundFileName() => <NoteKind, String>{
    NoteKind.c: 'c4',
    NoteKind.d: 'd4',
    NoteKind.e: 'e4',
    NoteKind.f: 'f4',
    NoteKind.g: 'g4',
    NoteKind.a: 'a4',
    NoteKind.h: 'b4',
    NoteKind.upperC: 'c5',
    NoteKind.upperD: 'd5',
    NoteKind.upperE: 'e5',
    NoteKind.upperF: 'f5',
    NoteKind.upperG: 'g5',
  }[this];
}

class Note {
  final NoteKind correctKind;
  NoteKind currentKind;
  bool isCorrect;
  bool hasError;

  Note({
    this.correctKind,
    this.currentKind,
    this.isCorrect = false,
    this.hasError = false,
  });

  factory Note.random() {
    return Note(
      correctKind: NoteKind.values[Random().nextInt(NoteKind.values.length - 1)],
    );
  }
}
