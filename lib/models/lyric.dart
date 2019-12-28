import 'package:hive/hive.dart';

class Lyric extends HiveObject {
  String type;
  String body;
  String chords;

  Lyric([this.type = "", this.body = "", this.chords = ""]) {
    Hive.box<Lyric>('lyrics').add(this);
  }
}

class LyricAdapter extends TypeAdapter<Lyric> {
  @override
  Lyric read(BinaryReader reader) {
    return Lyric()
      ..type = reader.readString()
      ..body = reader.readString()
      ..chords = reader.readString();
  }

  @override
  void write(BinaryWriter writer, Lyric obj) {
    writer.writeString(obj.type);
    writer.writeString(obj.body);
    writer.writeString(obj.chords);
  }
}
