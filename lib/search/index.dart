import 'package:flutter/material.dart';
import 'search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 20, 6, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.settings)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                const SearchBar(),
                Container(
                  color: Colors.white,
                  child: const Text('data'),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.cloud_upload))
        ],
      ),
    );
  }
}
