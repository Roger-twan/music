import 'package:flutter/material.dart';

import 'play_controller.dart';
import 'play_progress.dart';

class BottomBar extends StatefulWidget {
const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
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
                onTap: () => {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.repeat),
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
