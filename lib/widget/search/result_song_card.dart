import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResultSongCard extends StatefulWidget {
  const ResultSongCard({super.key});

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
    String sourceType = 'qq';

    if (sourceType == 'local') {
      icon = const Icon(Icons.rocket_sharp);
    } else if (sourceType == 'netEase') {
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
      onTap: () => {
        // print(222)
      },
      child: MouseRegion(
        cursor: MaterialStateMouseCursor.clickable,
        onEnter: (e) => setIsCardHover(true),
        onExit: (e) => setIsCardHover(false),
        child: Stack(
          children: [
            Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: BoxDecoration(
              color: isCardHover ? Colors.grey[900] : Colors.transparent,
              border: const Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0
                )
              )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hotel California', style: TextStyle(color: Colors.white)),
                        Text('Eagle · 7:34' )
                      ],
                    ),
                    icon,
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                width: 200,
                height: 1,
                color: Theme.of(context).primaryColor,
              ))
            ],
          )
        ]),
      ),
    );
  }
}
