import 'package:flutter/material.dart';

class PlayOrderController extends StatefulWidget {
  const PlayOrderController({super.key});

  @override
  State<PlayOrderController> createState() => _PlayOrderControllerState();
}

class _PlayOrderControllerState extends State<PlayOrderController> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => {}, icon: const Icon(Icons.repeat),iconSize: 22,);
        // shuffle_outlined
        // repeat_one_outlined
  }
}
