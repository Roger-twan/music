import 'package:flutter/material.dart';
import '../../model/lyric_model.dart';
import '../../provider/music_player.dart';
import '../../model/songs_model.dart';
import '../../provider/dio_client.dart';
import '../../provider/event_bus.dart';
import 'lyric_wrapper.dart';

class LyricScreen extends StatefulWidget {
  const LyricScreen({super.key});

  @override
  State<LyricScreen> createState() => _LyricScreenState();
}

class _LyricScreenState extends State<LyricScreen> {
  SongModel? curSong = MusicPlayer().getPlayingSong();

  void setSong(SongModel value) {
    if (mounted) {
      setState(() {
        curSong = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      eventBus.on<PlayEvent>().listen((event) {
        if (event.state != null && event.state == 'ready') {
          setSong(MusicPlayer().getPlayingSong()!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseFontSize = MediaQuery.of(context).size.width * 0.05;
    const double minFontSize = 26;
    const double maxFontSize = 40;
    if (baseFontSize > maxFontSize) {
      baseFontSize = maxFontSize;
    } else if (baseFontSize < minFontSize) {
      baseFontSize = minFontSize;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      color: Colors.black,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Text(curSong?.name ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: baseFontSize,
                color: Colors.white,
              )),
          Text(curSong?.artist ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: baseFontSize * 0.6,
              )),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.only(top: 50),
                  width: double.infinity,
                  child: FutureBuilder<LyricModel>(
                      future: searchLyric(curSong),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          String lyr = snapshot.data?.lyric ?? '';
                          MusicPlayer().setLyric(lyr);
                          if (lyr.isEmpty) {
                            return const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text('No lyric')]);
                          } else {
                            return CustomPaint(
                              painter: LyricWrapper(lyr, baseFontSize),
                            );
                          }
                        }
                        if (snapshot.hasError) {
                          return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(snapshot.error.toString())]);
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(children: [
                            const SizedBox(height: 100),
                            CircularProgressIndicator(color: Colors.grey[800]),
                          ]);
                        }
                        return Container();
                      })))
        ],
      ),
    );
  }
}

Future<LyricModel> searchLyric(SongModel? song) async {
  if (song?.lyric != null) {
    return LyricModel.fromJson({'lyric': song?.lyric, 'source': song?.source});
  } else {
    final response = await dioClient().get('/lyric/get',
        queryParameters: {'id': song?.id, 'source': song?.source});

    return LyricModel.fromJson(response.data);
  }
}
