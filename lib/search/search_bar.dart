import 'package:flutter/material.dart';
import 'suggestion.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  GlobalKey searchField = GlobalKey();
  FocusNode searchFieldFocus = FocusNode();
  bool isSearchFieldFocus = false;
  String searchKey = '';
  late Suggestion searchSuggestion;

  void setIsSearchFieldFocus(bool value) {
    setState(() {
      isSearchFieldFocus = value;
    });
  }

  void setSearchKey(String value) {
    setState(() {
      searchKey = value;
    });
  }

  @override
  void initState() {
    super.initState();

    searchSuggestion = Suggestion();

    searchFieldFocus.addListener(() => {
      searchFieldFocus.hasFocus ?
        searchSuggestion.show(context, searchKey)
        : searchSuggestion.hide(),
      setIsSearchFieldFocus(searchFieldFocus.hasFocus)
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchFieldFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: searchField,
      focusNode: searchFieldFocus,
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
        searchSuggestion.updateWord(str),
        setSearchKey(str)
      },
    );
  }
}
