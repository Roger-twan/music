import 'package:flutter/material.dart';
import '../../model/lyric_model.dart';
import '../../model/songs_model.dart';
import '../../provider/likes_song.dart';
import '../../provider/dio_client.dart';
import '../../provider/event_bus.dart';
import '../../provider/music_player.dart';
import '../_common/toast.dart';
import '../lyric/index.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  late SongModel? curSong;
  final player = MusicPlayer();
  final likesSong = LikesSong();

  void setCurSong(SongModel? song) {
    if (mounted) {
      setState(() {
        curSong = song;
      });
    }
  }

  void setLike(bool value) {
    curSong?.like = value ? 1 : 0;
    setCurSong(curSong);
  }

  @override
  void initState() {
    super.initState();

    setCurSong(null);

    eventBus.on<PlayEvent>().listen((event) {
      if (event.state != null && event.state == 'ready') {
        setCurSong(player.getPlayingSong());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => toggleLike(),
        iconSize: 22,
        icon:
            Icon(curSong?.like == 1 ? Icons.favorite : Icons.favorite_outline));
  }

  void toggleLike() async {
    if (curSong == null) return;

    setLike(curSong?.like != 1);
    if (curSong?.like == 1) {
      if (curSong?.source != 'storage') {
        if (curSong?.lyric == null) {
          LyricModel lyric = await searchLyric(curSong!);
          String lyr = lyric.lyric ?? '';
          curSong?.lyric = lyr;
          player.setLyric(lyr);
        }
        curSong = await syncSong(curSong);
      }

      bool isAdded = await likesSong.add(curSong!);

      if (!isAdded) {
        setLike(false);
      }

      if (mounted) {
        showToast(
            context,
            curSong!.name +
                (isAdded ? ' was successfully added' : ' was add failed'));
      }
    } else {
      bool isRemoved = await likesSong.remove(curSong!.id);

      if (!isRemoved) {
        setLike(true);
      }

      if (mounted) {
        showToast(
            context,
            curSong!.name +
                (isRemoved
                    ? ' was successfully removed'
                    : ' was remove failed'));
      }
    }
  }

  Future<SongModel> syncSong(SongModel? song) async {
    final response =
        await dioClient().post('/song/sync', data: curSong?.toJson());

    return SongModel.fromJson(response.data);
  }
}
