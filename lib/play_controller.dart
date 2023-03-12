import 'package:flutter/material.dart';

class PlayController extends StatefulWidget {
  const PlayController({super.key});

  @override
  State<PlayController> createState() => _PlayControllerState();
}

class _PlayControllerState extends State<PlayController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () => {print('previous')},
            icon: const Icon(Icons.skip_previous)),
        IconButton(
            onPressed: () => {print('play')},
            icon: const Icon(Icons.play_arrow),
            iconSize: 40,
        ),
            // pause_outlined
        IconButton(
            onPressed: () => {print('next')},
            icon: const Icon(Icons.skip_next)),
      ],
    );
  }
}
