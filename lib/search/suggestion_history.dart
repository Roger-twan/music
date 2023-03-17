import 'package:flutter/material.dart';

class SuggestionHistory extends StatefulWidget {
  const SuggestionHistory({super.key});

  @override
  State<SuggestionHistory> createState() => _SuggestionHistoryState();
}

class _SuggestionHistoryState extends State<SuggestionHistory> {
  final List<String> historyList = ['a', 'b', 'c'];

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
