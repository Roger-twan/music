import 'package:flutter/material.dart';
import '../../provider/music_player.dart';
import '../../provider/event_bus.dart';

class PlayController extends StatefulWidget {
  const PlayController({super.key});

  @override
  State<PlayController> createState() => _PlayControllerState();
}

class _PlayControllerState extends State<PlayController> {
  bool isPlaying = false;
  String playState = 'ready';
  final player = MusicPlayer();

  void setIsPlaying(bool value) {
    setState(() {
      isPlaying = value;
    });
  }

  void setPlayState(String value) {
    setState(() {
      playState = value;
    });
  }

  @override
  void initState() {
    super.initState();

    eventBus.on<PlayEvent>().listen((event) {
      if (event.isPlaying != null) {
        setIsPlaying(event.isPlaying!);
      }
      if (event.state != null) {
        setPlayState(event.state!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => player.previous(),
            icon: const Icon(Icons.skip_previous)),
        if (playState == 'loading')
          Container(
            padding: const EdgeInsets.all(16),
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: Colors.grey),
            ),
          ),
        if (playState == 'ready')
          IconButton(
            onPressed: () => isPlaying ? player.pause() : player.play(),
            icon: Icon(isPlaying ? Icons.pause_outlined : Icons.play_arrow),
            iconSize: 40,
          ),
        IconButton(
            onPressed: () => player.next(), icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}
