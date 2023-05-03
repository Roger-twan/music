import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import '../../utils/format_lyric.dart';

class LyricWrapper extends CustomPainter {
  String lyricStr;
  double baseFontSize;
  LyricWrapper(this.lyricStr, this.baseFontSize);
  int currentIndex = 0;

  @override
  void paint(Canvas canvas, Size size) {
    List<Lyric> lyricList = formatLyric(lyricStr);
    double middleHeight = size.height / 2 - 60;
    double y = 0;

    eventBus.on<PlayEvent>().listen((event) {
      if (event.position != null) {
        int curIndex = lyricList.indexWhere((lyric) {
          if (lyric.endTime != null) {
            int startPosition = lyric.startTime!.inMilliseconds;
            int endPosition = lyric.endTime!.inMilliseconds;
            return startPosition <= event.position! &&
                endPosition >= event.position!;
          } else {
            return true;
          }
        });

        currentIndex = curIndex > -1 ? curIndex : currentIndex;
      }
    });

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

    for (int i = 0; i < lyricList.length; i++) {
      TextStyle lyricStyle = commonStyle;

      if (isWithinIndex(i, currentIndex, 0)) {
        lyricStyle = primaryStyle;
        y = middleHeight;
      } else if (isWithinIndex(i, currentIndex, 1)) {
        lyricStyle = secondaryStyle;
      } else if (isWithinIndex(i, currentIndex, 2)) {
        lyricStyle = tertiaryStyle;
      }

      y = middleHeight + (baseFontSize * 1.2 * (i - currentIndex));

      if (y > 0 && y < size.height) {
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: lyricList[i].lyric,
            style: lyricStyle,
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();

        final xCenter = (size.width - textPainter.width) / 2;
        final offset = Offset(xCenter, y);
        textPainter.paint(canvas, offset);
      }
    }
  }

  @override
  bool shouldRepaint(LyricWrapper oldDelegate) =>
      oldDelegate.currentIndex != currentIndex;

  bool isWithinIndex(int index, int baseIndex, int range) {
    return (index == baseIndex + range) || (index == baseIndex - range);
  }
}
