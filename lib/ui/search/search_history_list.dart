import 'package:flutter/material.dart';
import '../../controller/search_history.dart';

class SearchHistoryList extends StatefulWidget {
  final List<String> list;
  const SearchHistoryList({Key? key, required this.list}): super(key: key);

  @override
  State<SearchHistoryList> createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  final SearchHistory searchHistory = SearchHistory();

  @override
  void initState() {
    super.initState();
    initSearchHistory();
  }

  void initSearchHistory() async {
    await searchHistory.init();
  }

  @override
  Widget build(BuildContext context) { 
    return ListView.builder(
        primary: false,
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {
              // print(222)
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.history),
                      const SizedBox(width: 10),
                      Text(widget.list[index]),
                    ]
                  ),
                  IconButton(
                    onPressed: () => {
                      searchHistory.delete(value: widget.list[index])
                    },
                    icon: const Icon(Icons.delete_outline)
                  )
                ],
              )
            ),
          );
        });
  }
}
