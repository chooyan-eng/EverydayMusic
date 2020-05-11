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
        NoteKind.upperC: 'ど',
        NoteKind.upperD: 'れ',
        NoteKind.upperE: 'み',
        NoteKind.upperF: 'ふぁ',
        NoteKind.upperG: 'そ',
      }[this];

  String toKatakana() => <NoteKind, String>{
        NoteKind.c: 'ド',
        NoteKind.d: 'レ',
        NoteKind.e: 'ミ',
        NoteKind.f: 'ファ',
        NoteKind.g: 'ソ',
        NoteKind.a: 'ラ',
        NoteKind.h: 'シ',
        NoteKind.upperC: 'ど',
        NoteKind.upperD: 'れ',
        NoteKind.upperE: 'み',
        NoteKind.upperF: 'ふぁ',
        NoteKind.upperG: 'そ',
      }[this];
}

class Note {
  final NoteKind correctKind;
  NoteKind currentKind;

  Note({
    this.correctKind,
    this.currentKind,
  });
}
