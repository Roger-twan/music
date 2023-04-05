import 'package:flutter/material.dart';
import '../../utils/format_lyric.dart';

class LyricWrapper extends CustomPainter {
  String lyricStr;
  double baseFontSize;
  LyricWrapper(this.lyricStr, this.baseFontSize);

  @override
  void paint(Canvas canvas, Size size) {
    List<Lyric> lyric = formatLyric(lyricStr);
    double y = 0;

    for (int i = 0; i < lyric.length; i++) {
      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: lyric[i].lyric,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
          )
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      if (i == 0) {
        // y = size.height - (size.height - textPainter.height) / 2;
        y = 0;
      } else {
        y += 30;
      }

      final xCenter = (size.width - textPainter.width) / 2;
      final offset = Offset(xCenter, y);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
