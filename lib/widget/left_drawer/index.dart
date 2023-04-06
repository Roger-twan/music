import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import 'playlist.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({super.key});

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {
  String currentDrawer = '';

  void setCurrentDrawer(String value) {
    if (mounted) {
      setState(() {
        currentDrawer = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    eventBus.on<OpenDrawerEvent>().listen((event) {
      if (event == OpenDrawerEvent.playlist) {
        setCurrentDrawer('playlist');
      } else if (event == OpenDrawerEvent.settings) {
        setCurrentDrawer('settings');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    Widget drawer = Container();

    switch (currentDrawer) {
      case 'playlist':
        title = 'Playlist';
        drawer = const Playlist();
        break;
      case 'settings':
        title = 'Settings';
        drawer = const Text('text');
        break;
      default: break;
    }

    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              )
            ),
            const SizedBox(height: 20),
            Expanded(child: drawer)
          ],
        ),
      )
    );
  }
}
