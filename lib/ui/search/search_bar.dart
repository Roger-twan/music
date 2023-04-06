import 'package:flutter/material.dart';
import '../../provider/event_bus.dart';
import '../../provider/search_history.dart';
import 'suggestion.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  GlobalKey searchField = GlobalKey();
  FocusNode searchFieldFocus = FocusNode();
  final searchFieldController = TextEditingController();
  bool isSearchFieldFocus = false;
  String searchWord = '';
  final Suggestion searchSuggestion = Suggestion();
  final SearchHistory searchHistory = SearchHistory();

  void setIsSearchFieldFocus(bool value) {
    setState(() {
      isSearchFieldFocus = value;
    });
  }

  void setSearchWord(String value) {
    setState(() {
      searchWord = value;
    });
  }

  @override
  void initState() {
    super.initState();

    searchHistory.init();

    searchFieldFocus.addListener(() => {
      setIsSearchFieldFocus(searchFieldFocus.hasFocus),
      updateSuggestion()
    });

    eventBus.on<SearchEvent>().listen((event) {
      searchFieldController.text = event.keyword;
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchFieldFocus.dispose();
  }

  void updateSuggestion() {
    searchSuggestion.handle(context, isSearchFieldFocus, searchWord);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: searchField,
      focusNode: searchFieldFocus,
      controller: searchFieldController,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 0),
          ),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 0),
              borderRadius: BorderRadius.zero),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          filled: true,
          fillColor: searchFieldFocus.hasFocus
              ? Colors.grey[900]
              : Colors.transparent),
      onChanged: (str) => {
        setSearchWord(str),
        updateSuggestion()
      },
      onSubmitted: (value) async => {
        if (value.isNotEmpty) {
          await Future.delayed(const Duration(milliseconds: 50)),
          await searchHistory.add(value),
          eventBus.fire(SearchEvent(value))
        }
      },
    );
  }
}
