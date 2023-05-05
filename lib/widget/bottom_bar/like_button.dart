import 'package:flutter/material.dart';
import '../../model/lyric_model.dart';
import '../../model/search_songs_model.dart';
import '../../provider/dio_client.dart';
import '../../provider/event_bus.dart';
import '../../provider/music_player.dart';
import '../lyric/index.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late SongModel? curSong;
  late bool isLiked = false;
  final player = MusicPlayer();

  void setIsLiked(bool value) {
    setState(() {
      isLiked = value;
    });
  }

  @override
  void initState() {
    super.initState();

    curSong = null;

    eventBus.on<PlayEvent>().listen((event) {
      if (event.state != null && event.state == 'ready') {
        curSong = player.getPlayingSong();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => toggleLike(),
        iconSize: 22,
        icon: Icon(isLiked ? Icons.favorite : Icons.favorite_outline));
  }

  void toggleLike() async {
    if (curSong == null) return;

    setIsLiked(!isLiked);

    if (isLiked) {
      // remove from likes
    } else {
      if (curSong?.source != 'storage') {
        if (curSong?.lyric == null) {
          LyricModel lyric = await searchLyric(curSong!);
          String lyr = lyric.lyric ?? '';
          curSong?.lyric = lyr;
          player.setLyric(lyr);
        }
        syncSong(curSong);
      }
      // add to likes
    }
  }

  Future<SongModel> syncSong(SongModel? song) async {
    final response =
        await dioClient().post('/song/sync', data: curSong?.toJson());

    return SongModel.fromJson(response.data);
  }
}
