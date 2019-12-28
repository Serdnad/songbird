import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:songbird/models/lyric.dart';
import 'package:songbird/models/song.dart';
import 'package:songbird/screens/song.dart';
import 'package:songbird/widgets/song_card.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _box = Hive.box<Song>('songs');

  void _addSong() {
    _box.add(Song());
  }

  void _showSong(Song song) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SongPage(song: song)));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Songbird"),
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        child: WatchBoxBuilder(
          box: _box,
          builder: (context, box) {
            final songs = box.values.toList() as List<Song>;

            return GridView.count(
              crossAxisCount: 2,
              children: songs.map(
                (song) {
                  return GestureDetector(
                    onTap: () => _showSong(song),
                    child: SongCard(song),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSong,
        child: Icon(Icons.add),
      ),
    );
  }
}
