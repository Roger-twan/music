import 'package:flutter/material.dart';
import 'result_song_card.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 56,
                mainAxisSpacing: 20,
                crossAxisSpacing: 30,
                crossAxisCount:
                    (MediaQuery.of(context).size.width ~/ 300).toInt(),
              ),
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return const ResultSongCard();
              }),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: OutlinedButton(onPressed: () {}, child: const Text('Search More')),
          ),
          CircularProgressIndicator(
            color: Colors.grey[800]
          )
        ],
      ),
    );
  }
}
