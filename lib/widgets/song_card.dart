import 'package:flutter/material.dart';
import 'package:songbird/models/song.dart';

class SongCard extends StatelessWidget {
  SongCard(this.song);

  final Song song;

  @override
  Widget build(BuildContext context) {
    final lyricPreview =
        song.lyrics.toList().map((lyric) => lyric.body).join("\n\n");

    return Card(
      color: Colors.green,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              song.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
            ),
            Divider(),
            Text(lyricPreview)
          ],
        ),
      ),
    );
  }
}
