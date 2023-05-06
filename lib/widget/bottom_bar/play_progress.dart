import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import '../../provider/music_player.dart';
import '../../utils/time_converter.dart';

class PlayProgress extends StatefulWidget {
  const PlayProgress({super.key});

  @override
  State<PlayProgress> createState() => _PlayProgressState();
}

class _PlayProgressState extends State<PlayProgress> {
  bool isProgressHover = false;
  bool isDotDragging = false;
  double dotProgress = 0;
  double mouseX = 0;
  static const double activeHeight = 4;
  static const double inactiveHeight = 2;
  int totalDuration = 0;
  int hoverDuration = 0;
  int position = 0;
  double loadedRadio = 0;
  final player = MusicPlayer();

  bool isProgressActivity() {
    return isProgressHover || isDotDragging;
  }

  void setIsProgressHover(bool value) {
    setState(() {
      isProgressHover = value;
    });
  }

  void setMouseX(double dx) {
    setState(() {
      mouseX = dx;
    });
  }

  void setIsDotDragging(bool value) {
    setState(() {
      isDotDragging = value;
    });
  }

  void setDotProgress(double value) {
    setState(() {
      dotProgress = value;
    });
  }

  void setTotalDuration(int value) {
    setState(() {
      totalDuration = value;
    });
  }

  void setPosition(int value) {
    setState(() {
      position = value;
    });
  }

  void setLoadedRadio(double value) {
    setState(() {
      loadedRadio = value;
    });
  }

  void onDotDrag(DragUpdateDetails e) {
    setDotProgress(e.globalPosition.dx);
  }

  void onDotDragEnd(DragEndDetails e) {
    setIsDotDragging(false);
    player
        .seek(totalDuration * dotProgress ~/ MediaQuery.of(context).size.width);
  }

  void setHoverDuration(double dx) {
    double radio = MediaQuery.of(context).size.width / dx;

    setState(() {
      hoverDuration = totalDuration ~/ radio;
    });
  }

  double getDotPosition() {
    return isDotDragging || totalDuration == 0
        ? dotProgress
        : MediaQuery.of(context).size.width * (position / totalDuration);
  }

  @override
  void initState() {
    super.initState();

    eventBus.on<PlayEvent>().listen((event) {
      if (event.state != null && event.state == 'ready') {
        final playingSong = player.getPlayingSong();
        if (playingSong != null && playingSong.duration != null) {
          setTotalDuration(playingSong.duration!);
        }
      }
      if (event.position != null) {
        setPosition(event.position!);

        if (!isDotDragging) {
          setDotProgress(MediaQuery.of(context).size.width *
              (event.position! / totalDuration));
        }
      }
      if (event.bufferedPosition != null &&
          !totalDuration.isNaN &&
          totalDuration != 0) {
        setLoadedRadio(event.bufferedPosition! / totalDuration);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      onEnter: (e) => setIsProgressHover(true),
      onHover: (e) {
        setMouseX(e.position.dx);
        setHoverDuration(e.position.dx);
      },
      onExit: (e) => setIsProgressHover(false),
      child: GestureDetector(
        onTap: () => player.seek(hoverDuration),
        child: Column(
          children: [
            Container(
              height: isProgressActivity() ? 3 : 5,
              color: Colors.black,
            ),
            Container(
                width: double.infinity,
                color: Colors.grey[800],
                height: isProgressActivity() ? activeHeight : inactiveHeight,
                child: Stack(clipBehavior: Clip.none, children: [
                  // loaded progress
                  Container(
                    color: Colors.grey[600],
                    width: MediaQuery.of(context).size.width * loadedRadio,
                  ),
                  // current play progress
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: getDotPosition(),
                  ),
                  isProgressActivity()
                      // dot
                      ? Positioned(
                          top: isDotDragging ? -8 : -4,
                          left: getDotPosition() - (isDotDragging ? 10 : 6),
                          width: isDotDragging ? 20 : 12,
                          height: isDotDragging ? 20 : 12,
                          child: GestureDetector(
                            onHorizontalDragDown: (e) => setIsDotDragging(true),
                            onHorizontalDragUpdate: (e) => onDotDrag(e),
                            onHorizontalDragEnd: (e) => onDotDragEnd(e),
                            onTapDown: (e) => setIsDotDragging(true),
                            onTapUp: (e) => setIsDotDragging(false),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle),
                            ),
                          ))
                      : Container(),
                  isProgressActivity()
                      // current position text
                      ? Positioned(
                          top: -25,
                          left: getDotPosition(),
                          child: FractionalTranslation(
                            translation: const Offset(-0.5, 0),
                            child: Text(
                                '${TimeConverter.formatMilliseconds(isDotDragging ? totalDuration * dotProgress ~/ MediaQuery.of(context).size.width : position)} / ${TimeConverter.formatMilliseconds(totalDuration)}',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12)),
                          ))
                      : Container(),
                  (isProgressHover && !isDotDragging)
                      // hover duration text
                      ? Positioned(
                          top: -25,
                          left: mouseX,
                          child: FractionalTranslation(
                            translation: const Offset(-0.5, 0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(2))),
                              child: Text(
                                  TimeConverter.formatMilliseconds(
                                      hoverDuration),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ),
                          ))
                      : Container(),
                ])),
            Container(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
