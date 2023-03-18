import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  final prefs = SharedPreferences.getInstance();
  final List<String> _list = ['1', '23', '4'];

  static final SearchHistory _instance = SearchHistory._internal();
  SearchHistory._internal();
  factory SearchHistory() => _instance;

  List<String> getList() => _list;

  void add(String value) {
    _list.add(value);
  }

  void delete({int? index, String? value}) {
    
  }
}
