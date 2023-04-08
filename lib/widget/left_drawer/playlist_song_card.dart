import 'package:flutter/material.dart';

class PlaylistSongCard extends StatefulWidget {
  const PlaylistSongCard({super.key});

  @override
  State<PlaylistSongCard> createState() => _PlaylistSongCardState();
}

class _PlaylistSongCardState extends State<PlaylistSongCard> {
  bool isCardHover = false;

  void setIsCardHover(bool value) {
    setState(() {
      isCardHover = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // print(222)
      },
      child: MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        onEnter: (e) => setIsCardHover(true),
        onExit: (e) => setIsCardHover(false),
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
                color: isCardHover ? Colors.black : Colors.transparent,
                border: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hotel California',
                            style: TextStyle(color: Colors.white)),
                        Text('Eagle')
                      ],
                    ),
                    const Text('7:34'),
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
