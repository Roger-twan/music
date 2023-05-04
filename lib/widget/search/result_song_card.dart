import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../provider/music_player.dart';
import '../../model/search_songs_model.dart';
import '../../utils/time_converter.dart';

class ResultSongCard extends StatefulWidget {
  final SongModel song;
  const ResultSongCard({Key? key, required this.song}) : super(key: key);

  @override
  State<ResultSongCard> createState() => _ResultSongCardState();
}

class _ResultSongCardState extends State<ResultSongCard> {
  bool isCardHover = false;

  void setIsCardHover(bool value) {
    setState(() {
      isCardHover = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    late Widget icon;
    String sourceType = widget.song.source;
    String subTitle = widget.song.artist;

    if (sourceType == 'storage') {
      icon = const Icon(Icons.rocket_sharp);
      subTitle +=
          ' · ${TimeConverter.formatMilliseconds(widget.song.duration!)}';
    } else if (sourceType == 'netease') {
      icon = SvgPicture.asset(
        'lib/assets/netEase.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
      );
    } else if (sourceType == 'qq') {
      icon = SvgPicture.asset(
        'lib/assets/qq.svg',
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(Colors.grey[400]!, BlendMode.srcIn),
      );
    }

    return GestureDetector(
      onTap: () {
        if (widget.song.url != null && widget.song.url!.isNotEmpty) {
          final player = MusicPlayer();

          player.play(widget.song);
        }
      },
      child: MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        onEnter: (e) => setIsCardHover(true),
        onExit: (e) => setIsCardHover(false),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
              color: isCardHover ? Colors.grey[900] : Colors.transparent,
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
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 4),
                        Text(subTitle, overflow: TextOverflow.ellipsis)
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  icon,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
