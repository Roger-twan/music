import 'package:flutter/material.dart';
import '../../provider/music_player.dart';
import '../../model/songs_model.dart';
import '../../utils/time_converter.dart';

class LikedSongCard extends StatefulWidget {
  final SongModel song;
  const LikedSongCard({Key? key, required this.song}) : super(key: key);

  @override
  State<LikedSongCard> createState() => _LikedSongCardState();
}

class _LikedSongCardState extends State<LikedSongCard> {
  bool isCardActive = false;

  void setIsCardActive(bool value) {
    setState(() {
      isCardActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setIsCardActive(true);
        Navigator.pop(context);
        MusicPlayer().play(widget.song);
      },
      child: MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        onEnter: (e) => setIsCardActive(true),
        onExit: (e) => setIsCardActive(false),
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: isCardActive ? Colors.black : Colors.transparent,
                border: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.song.name,
                              style: const TextStyle(color: Colors.white)),
                          Text(widget.song.artist)
                        ],
                      ),
                    ),
                    Text(TimeConverter.formatMilliseconds(
                        widget.song.duration!)),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
