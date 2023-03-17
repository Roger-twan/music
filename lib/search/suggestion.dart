import 'package:flutter/material.dart';

import 'suggestion_history.dart';

class Suggestion {
  OverlayEntry? _overlayEntry;
  final ValueNotifier<String> _keyWord = ValueNotifier<String>('');

  static final Suggestion _instance = Suggestion._internal();
  Suggestion._internal();
  factory Suggestion() => _instance;

  void show(BuildContext context, String keyWord) {
    _keyWord.value = keyWord;
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: 59,
        left: 56,
        right: 56,
        child: Material(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: const Border(
                top: BorderSide.none,
                left: BorderSide(color: Colors.white, width: 0),
                right: BorderSide(color: Colors.white, width: 0),
                bottom: BorderSide(color: Colors.white, width: 0)
              )
            ),
            child: ValueListenableBuilder(
              valueListenable: _keyWord,
              builder: (BuildContext context, String value, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const SuggestionHistory(),
                  Text(value)
                ],);
              }),
          )
        )
      );
    });

    Overlay.of(context).insert(_overlayEntry!);
  }

  void hide() {
    _overlayEntry?.remove();
  }

  void updateWord(String value) {
    _keyWord.value = value;
  }
}
