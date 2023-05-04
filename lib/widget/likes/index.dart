import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'liked_song_card.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[900],
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Likes',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  )),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) => {
                                  // print('delete')
                                },
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          child: const LikedSongCard(),
                        );
                      }))
            ],
          ),
        ));
  }
}
