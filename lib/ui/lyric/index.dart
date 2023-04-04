import 'package:flutter/material.dart';

class LyricScreen extends StatefulWidget {
  const LyricScreen({super.key});

  @override
  State<LyricScreen> createState() => _LyricScreenState();
}

class _LyricScreenState extends State<LyricScreen> {
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
              // children: const [
              //   SearchBar(),
              //   Expanded(child: SearchResult()),
              // ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(onPressed: () => {}, icon: const Icon(Icons.cloud_upload))
        ],
      ),
    );
  }
}
