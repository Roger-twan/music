import 'package:flutter/material.dart';
import '../../provider/music_player.dart';

class LoopShuffle extends StatefulWidget {
  const LoopShuffle({super.key});

  @override
  State<LoopShuffle> createState() => _LoopShuffleState();
}

class _LoopShuffleState extends State<LoopShuffle> {
  String loopMode = '';
  final MusicPlayer player = MusicPlayer();
  final Map<String, Icon> modeIconMap = {
    'all': const Icon(Icons.repeat),
    'one': const Icon(Icons.repeat_one),
    'shuffle': const Icon(Icons.shuffle),
  };

  void setLoopMode(String value) {
    setState(() {
      loopMode = value;
    });
  }

  @override
  void initState() {
    super.initState();

    loopMode = player.getLoopMode() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        String nextMode = '';

        switch (loopMode) {
          case 'all':
            nextMode = 'one';
            break;
          case 'one':
            nextMode = 'shuffle';
            break;
          case 'shuffle':
            nextMode = 'all';
            break;
          default:
            break;
        }

        setLoopMode(nextMode);
        player.setLoopMode(nextMode);
      },
      icon: modeIconMap[loopMode]!,
      iconSize: 22,
    );
  }
}
