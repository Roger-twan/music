import 'package:flutter/material.dart';
import 'package:music/widget/logo/index.dart';
import 'search_bar.dart';
import 'result.dart';

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
          const Logo(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: const [
                SearchBar(),
                Expanded(child: SearchResult()),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () async => {
                    Scaffold.of(context).openEndDrawer(),
                  },
              icon: const Icon(Icons.settings)),
        ],
      ),
    );
  }
}
