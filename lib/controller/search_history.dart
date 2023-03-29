import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  SharedPreferences? _prefs;
  static const int maxCount = 10;

  static final SearchHistory _instance = SearchHistory._internal();
  SearchHistory._internal();
  factory SearchHistory() => _instance;

  Future init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
      await _prefs!.setStringList('searchHistory', []);
    }
  }

  List<String> getList() {
    return _prefs!.getStringList('searchHistory') ?? [];
  }

  Future<void> add(String value) async {
    if (value.isNotEmpty) {
      List<String>? list = getList();

      if (!list.contains(value)) {
        list.insert(0, value);
        int end = list.length > maxCount ? maxCount : list.length;
        await _prefs!.setStringList('searchHistory', list.sublist(0, end));
      }
    }
  }

  Future<void> delete({int? index, String? value}) async {
    List<String>? list = getList();

    if (index != null) {
      list.removeAt(index);
    }
    if (value != null && list.contains(value)) {
      list.remove(value);
    }

    _prefs!.setStringList('searchHistory', list);
  }
}
