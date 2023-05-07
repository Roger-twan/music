import 'package:flutter/material.dart';
import '../logo/index.dart';
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 4), child: const Logo()),
              const SizedBox(width: 10),
              const Expanded(child: SearchBar()),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () async => {
                  Scaffold.of(context).openEndDrawer(),
                },
                icon: const Icon(Icons.settings),
                iconSize: 30,
              ),
            ],
          ),
          const Expanded(child: SearchResult()),
        ],
      ),
    );
  }
}
