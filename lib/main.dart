import 'package:flutter/material.dart';
import 'package:music/provider/likes_song.dart';
import 'provider/music_player.dart';
import 'provider/preferences.dart';
import 'widget/bottom_bar/index.dart';
import 'widget/search/index.dart';
import 'widget/likes/index.dart';
import 'widget/settings/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  await LikesSong().init();
  MusicPlayer().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: const Color(0xffD00A07),
          iconTheme: IconThemeData(color: Colors.grey[400]),
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.grey[400]),
          )),
      home: const Scaffold(
        backgroundColor: Colors.black,
        body: SearchScreen(),
        bottomNavigationBar: BottomBar(),
        drawer: Likes(),
        endDrawer: Settings(),
      ),
    );
  }
}
