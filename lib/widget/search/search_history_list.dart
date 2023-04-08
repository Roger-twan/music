import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import '../../provider/search_history.dart';

class SearchHistoryList extends StatefulWidget {
  final List<String> list;
  const SearchHistoryList({Key? key, required this.list}) : super(key: key);

  @override
  State<SearchHistoryList> createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  final SearchHistory searchHistory = SearchHistory();
  int mouseOverIndex = -1;

  void setMouseOverIndex(int value) {
    setState(() {
      mouseOverIndex = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        itemCount: widget.list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => eventBus.fire(SearchEvent(widget.list[index])),
            child: Container(
                color: mouseOverIndex == index
                    ? Colors.grey[800]
                    : Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                child: MouseRegion(
                  cursor: MaterialStateMouseCursor.clickable,
                  onEnter: (e) => setMouseOverIndex(index),
                  onExit: (e) => setMouseOverIndex(-1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(children: [
                        const Icon(Icons.history),
                        const SizedBox(width: 10),
                        Text(widget.list[index]),
                      ]),
                      IconButton(
                          onPressed: () =>
                              {searchHistory.delete(value: widget.list[index])},
                          icon: const Icon(Icons.delete_outline))
                    ],
                  ),
                )),
          );
        });
  }
}
