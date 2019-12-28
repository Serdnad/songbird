import 'package:hive/hive.dart';

import 'lyric.dart';

class Song extends HiveObject {
  String title;
  HiveList<Lyric> lyrics;

  Song([this.title = "Untitled"]) {
    // Initialize Lyrics hive list with initial lyric
    final initialLyric = Lyric();
    final box = Hive.box<Lyric>('lyrics');
    box.add(initialLyric);

    this.lyrics = HiveList<Lyric>(box, objects: [initialLyric]);
  }
}

class SongAdapter extends TypeAdapter<Song> {
  @override
  Song read(BinaryReader reader) {
    return Song()
      ..title = reader.readString()
      ..lyrics = reader.readHiveList();
  }

  @override
  void write(BinaryWriter writer, Song obj) {
    writer.writeString(obj.title);
    writer.writeHiveList(obj.lyrics);
  }
}
