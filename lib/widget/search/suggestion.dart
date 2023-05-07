import 'dart:io';
import 'package:flutter/material.dart';
import 'search_history_list.dart';
import '../../provider/search_history.dart';

class Suggestion {
  OverlayEntry? _overlayEntry;
  final ValueNotifier<List<String>> _list = ValueNotifier<List<String>>([]);
  final SearchHistory searchHistory = SearchHistory();

  static final Suggestion _instance = Suggestion._internal();
  Suggestion._internal();
  factory Suggestion() => _instance;

  void handle(BuildContext context, bool isFieldFocus, String keyWord) async {
    List<String> list = searchHistory.getList();
    _list.value = keyWord.isEmpty
        ? list
        : list.where((element) => element.startsWith(keyWord)).toList();

    if (isFieldFocus) {
      if (keyWord.isNotEmpty || _list.value.isNotEmpty) {
        if (context.mounted) {
          _show(context);
        }
      } else {
        _hide();
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 120));
      _hide();
    }
  }

  void _show(BuildContext context) {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (context) {
        return Positioned(
            top: Platform.isIOS ? 101 : 59,
            left: 56,
            right: 58,
            child: Material(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: const Border(
                      top: BorderSide.none,
                      left: BorderSide(color: Colors.white, width: 0),
                      right: BorderSide(color: Colors.white, width: 0),
                      bottom: BorderSide(color: Colors.white, width: 0))),
              child: ValueListenableBuilder<List<String>>(
                  valueListenable: _list,
                  builder: (BuildContext context, List<String> value,
                      Widget? child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchHistoryList(list: value),
                      ],
                    );
                  }),
            )));
      });

      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  void _hide() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }
}
