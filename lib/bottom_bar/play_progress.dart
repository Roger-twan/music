import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlayProgress extends StatefulWidget {
  const PlayProgress({super.key});

  @override
  State<PlayProgress> createState() => _PlayProgressState();
}

class _PlayProgressState extends State<PlayProgress> {
  bool isProgressHover = false;
  bool isDotDrag  = false;
  double dotProgress = 100;
  double mouseX = 0;
  static const double activeHeight = 4;
  static const double inactiveHeight = 2;

  bool isProgressActivity() {
    return isProgressHover || isDotDrag;
  }

  void setIsProgressHover(bool value) {
    setState(() {
      isProgressHover = value;
    });
  }

  void setMouseX(PointerHoverEvent e) {
    setState(() {
      mouseX = e.position.dx;
    });
  }

  void onProgressTap() {
    setDotProgress(mouseX);
  }

  void setIsDotDrag(bool value) {
    setState(() {
      isDotDrag = value;
    });
  }

  void setDotProgress(double value) {
    setState(() {
      dotProgress = value;
    });
  }

  void onDotDrag (DragUpdateDetails e) {
    setDotProgress(e.globalPosition.dx);
  }
  
  void onDotDragEnd (DragEndDetails e) {
    setIsDotDrag(false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      onEnter: (e) => setIsProgressHover(true),
      onHover: (e) => setMouseX(e),
      onExit: (e) => setIsProgressHover(false),
      child: GestureDetector(
        onTap: () => onProgressTap(),
        child: Column(
          children: [
            Container(
              height:isProgressActivity() ? 3 : 5,
              color: Colors.black,
            ),
            Container(
              width: double.infinity,
              color: Colors.grey[800],
              height: isProgressActivity() ? activeHeight : inactiveHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: Colors.grey[600],
                    width: 300,
                  ),
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: dotProgress,
                  ),
                  isProgressActivity() ? Positioned(
                    top: isDotDrag ? -8 : -4,
                    left: dotProgress - (isDotDrag ? 10 : 6),
                    width: isDotDrag ? 20 : 12,
                    height: isDotDrag ? 20 : 12,
                    child: GestureDetector(
                      onHorizontalDragDown: (e) => setIsDotDrag(true),
                      onHorizontalDragUpdate: (e) => onDotDrag(e),
                      onHorizontalDragEnd: (e) => onDotDragEnd(e),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle
                        ),
                      ),
                    )) : Container(),
                  isProgressActivity() ? Positioned(
                    top: -25,
                    left: dotProgress,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, 0),
                      child: Text('3:45 / 7:23', style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12
                      )),
                    )) : Container(),
                  (isProgressHover && !isDotDrag) ? Positioned(
                    top: -25,
                    left: mouseX,
                    child: FractionalTranslation(
                      translation: const Offset(-0.5, 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: const BorderRadius.all(Radius.circular(2))
                        ),
                        child: const Text('4:45', style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                        )),
                      ),
                    )) : Container(),
                ]
              )
            ),
            Container(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
