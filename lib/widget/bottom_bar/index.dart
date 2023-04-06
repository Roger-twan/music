import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import 'play_controller.dart';
import 'play_progress.dart';
import '../lyric/index.dart';

class BottomBar extends StatefulWidget {
const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool isLyricScreenActivity = false;

  void setIsLyricScreenActivity(bool value) {
    setState(() {
      isLyricScreenActivity = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        elevation: 0,
        color: Colors.grey[900],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PlayProgress(),
            GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => {
                  if (!isLyricScreenActivity) {
                    showBottomSheet(
                      context: context,
                      enableDrag: false,
                      builder: (context) {
                        return const LyricScreen();
                      }
                    )
                  } else {
                    Navigator.pop(context)
                  },
                  setIsLyricScreenActivity(!isLyricScreenActivity)
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async => {
                          Scaffold.of(context).openDrawer(),
                          await Future.delayed(const Duration(milliseconds: 10)),
                          eventBus.fire(OpenDrawerEvent.playlist),
                        },
                        icon: const Icon(Icons.queue_music),
                        iconSize: 22,
                      ),
                      const PlayController(),
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.repeat),
                        iconSize: 22,
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
