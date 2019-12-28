import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songbird/helpers/alert.dart';
import 'package:songbird/models/lyric.dart';
import 'package:songbird/models/song.dart';

class LyricCard extends StatelessWidget {
  LyricCard({Key key, this.song, this.lyric}) : super(key: key);

  final Song song;
  final Lyric lyric;

  static Color _colorFor(String type) {
    type = type.toLowerCase();

    if (type.contains('verse'))
      return Colors.blue;
    else if (type.contains('pre') && type.contains('chorus'))
      return Colors.deepOrange;
    else if (type.contains('chorus'))
      return Colors.red;
    else if (type.contains('bridge'))
      return Colors.purple;
    else
      return Colors.green;
  }

  void _duplicate() {
    final dupe = Lyric(lyric.type, lyric.body);

    // Increment type if ending with number
    final number = num.tryParse(lyric.type.split(' ').last);
    if (number != null)
      dupe.type = dupe.type.replaceAll("$number", "${number + 1}");

    final pos = song.lyrics.indexOf(lyric);
    song.lyrics.insert(pos + 1, dupe);
  }

  void _delete(BuildContext context) {
    if (lyric.body.trim().isNotEmpty) {
      AlertHelper.showPrompt(
        context,
        "Delete ${lyric.type}?",
        "Deleting a lyric is permanent.",
        () => lyric.delete(),
      );
    } else
      lyric.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _colorFor(lyric.type),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: lyric.type,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hasFloatingPlaceholder: false,
                      hintText: "Verse...",
                    ),
                    onChanged: (value) {
                      lyric.type = value;
                      lyric.save();

                      //_updateColor();
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: _duplicate,
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _delete(context),
                  color: Colors.white,
                ),
              ],
            ),
            Divider(height: 2.0),
            TextFormField(
              initialValue: lyric.body,
              maxLines: null,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hasFloatingPlaceholder: false,
                hintText: "My lyrics...",
              ),
              onChanged: (value) {
                lyric.body = value;
                lyric.save();
              },
            ),
            Divider(height: 2.0),
            Container(
              height: 32,
              child: TextFormField(initialValue: "",
                maxLines: null,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hasFloatingPlaceholder: false,
                  hintText: "Chords...",
                ),
                onChanged: (value) {
                  lyric.body = value;
                  lyric.save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
