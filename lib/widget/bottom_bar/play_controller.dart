import 'package:flutter/material.dart';
import 'package:music/provider/music_player.dart';
import '../../provider/event_bus.dart';

class PlayController extends StatefulWidget {
  const PlayController({super.key});

  @override
  State<PlayController> createState() => _PlayControllerState();
}

class _PlayControllerState extends State<PlayController> {
  bool isPlaying = false;

  void setIsPlaying(bool value) {
    setState(() {
      isPlaying = value;
    });
  }

  @override
  void initState() {
    super.initState();

    eventBus.on<PlayEvent>().listen((event) {
      if (event.isPlaying != null) {
        setIsPlaying(event.isPlaying!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: () => {}, icon: const Icon(Icons.skip_previous)),
        IconButton(
          onPressed: () {
            final player = MusicPlayer();

            isPlaying ? player.pause(): player.play();
          },
          icon: Icon(isPlaying ? Icons.pause_outlined : Icons.play_arrow),
          iconSize: 40,
        ),
        IconButton(onPressed: () => {}, icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}
