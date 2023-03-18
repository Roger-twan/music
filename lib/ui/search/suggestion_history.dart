import 'package:flutter/material.dart';

import '../../controller/search_history.dart';

class SuggestionHistory extends StatefulWidget {
  final String searchKey;
  const SuggestionHistory({Key? key, required this.searchKey}): super(key: key);
  

  @override
  State<SuggestionHistory> createState() => _SuggestionHistoryState();
}

class _SuggestionHistoryState extends State<SuggestionHistory> {
  List<String> historyList = SearchHistory().getList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        primary: false,
        itemCount: historyList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(widget.searchKey),
                      const Icon(Icons.history),
                      const SizedBox(width: 10),
                      Text(historyList[index]),
                    ]
                  ),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.delete_outline)
                  )
                ],
              )
            ),
          );
        });
  }
}
