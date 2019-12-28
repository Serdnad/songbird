import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:songbird/models/lyric.dart';
import 'package:songbird/models/song.dart';
import 'package:songbird/widgets/lyric_card.dart';

class SongPage extends StatefulWidget {
  SongPage({Key key, this.song}) : super(key: key);

  final Song song;

  @override
  State<StatefulWidget> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  void _reorder(oldIndex, newIndex) {
    final tmp = widget.song.lyrics[oldIndex];
    widget.song.lyrics.removeAt(oldIndex);

    if (newIndex <= oldIndex)
      widget.song.lyrics.insert(newIndex, tmp);
    else
      widget.song.lyrics.insert(newIndex + 1, tmp);
  }

  @override
  Widget build(BuildContext context) {
    return FocusWatcher(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.song.title),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: WatchBoxBuilder(
            box: Hive.box<Lyric>('lyrics'),
            builder: (context, box) {
              final lyrics = widget.song.lyrics;

              return ListView(
                //onReorder: _reorder,
                children: lyrics.map((lyric) {
                  return LyricCard(
                      key: ValueKey(lyric), song: widget.song, lyric: lyric);
                }).toList(),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => widget.song.lyrics.add(Lyric()),
        ),
      ),
    );
  }
}
