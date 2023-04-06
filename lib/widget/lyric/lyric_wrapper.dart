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
    int currentIndex = 4;

    TextStyle commonStyle = TextStyle(
      color: Colors.grey[700],
      fontSize: baseFontSize * 0.4,
    );
    TextStyle primaryStyle = TextStyle(
      color: Colors.grey[200],
      fontSize: baseFontSize * 0.8,
    );
    TextStyle secondaryStyle = TextStyle(
      color: Colors.grey[400],
      fontSize: baseFontSize * 0.6,
    );
    TextStyle tertiaryStyle = TextStyle(
      color: Colors.grey[700],
      fontSize: baseFontSize * 0.5,
    );

    for (int i = 0; i < lyric.length; i++) {
      TextStyle lyricStyle = commonStyle;

      if (isWithinIndex(i, currentIndex, 0)) {
        lyricStyle = primaryStyle;
      } else if (isWithinIndex(i, currentIndex, 1)) {
        lyricStyle = secondaryStyle;
      } else if (isWithinIndex(i, currentIndex, 2)) {
        lyricStyle = tertiaryStyle;
      }

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: lyric[i].lyric,
          style: lyricStyle,
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      y = i == 0 ? 0 : y + baseFontSize * 1.5;

      final xCenter = (size.width - textPainter.width) / 2;
      final offset = Offset(xCenter, y);
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  bool isWithinIndex(int index, int baseIndex, int range) {
    return (index == baseIndex + range) || (index == baseIndex - range);
  }
}
