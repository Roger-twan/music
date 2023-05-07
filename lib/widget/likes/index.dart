import 'dart:io';
import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import '../../provider/likes_song.dart';
import '../../model/songs_model.dart';
import '../_common/toast.dart';
import 'liked_song_card.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  final likesSong = LikesSong();
  List<SongModel?>? list;

  void initList() {
    if (mounted) {
      setState(() {
        list = likesSong.getList().reversed.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    initList();

    eventBus.on<LikesSongUpdateEvent>().listen((event) {
      if (event.updated != null && event.updated!) {
        initList();
      }
    });
  }

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
              if (Platform.isIOS)
                SizedBox(height: MediaQuery.of(context).padding.top),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Likes',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      )),
                  const SizedBox(width: 6),
                  Text(list?.length.toString() ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: list?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LikedSongCard(song: list![index]!);
                      })),
              if (Platform.isIOS)
                SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ));
  }

  Future<void> removeSong(int id) async {
    bool isRemoved = await likesSong.remove(id);
    if (mounted) {
      showToast(context, isRemoved ? 'Successfully removed' : 'Remove failed');
    }
  }
}
