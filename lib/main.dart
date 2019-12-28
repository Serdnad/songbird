import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:songbird/screens/home.dart';

import 'models/lyric.dart';
import 'models/song.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final docDir = await getApplicationDocumentsDirectory();
  Hive.init(docDir.path);

  Hive.registerAdapter(SongAdapter(), 0);
  Hive.registerAdapter(LyricAdapter(), 1);

  await Hive.openBox<Song>('songs');
  await Hive.openBox<Lyric>('lyrics');

  runApp(App());
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Songbird',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}