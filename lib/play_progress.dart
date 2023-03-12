import 'package:flutter/material.dart';

class PlayProgress extends StatefulWidget {
  const PlayProgress({super.key});

  @override
  State<PlayProgress> createState() => _PlayProgressState();
}

class _PlayProgressState extends State<PlayProgress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 2,
      color: Colors.grey[800],
      child: Stack(
        children: [
          Container(
            color: Colors.grey[600],
            width: 300,
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: 100,
          ),
          Positioned(
            top: 0,
            left: 200,
            width: 10,
            height: 10,
            child: Container(
              color: Theme.of(context).primaryColor,
            ))
        ]
      )
    );
  }
}
