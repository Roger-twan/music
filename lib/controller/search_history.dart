import 'package:shared_preferences/shared_preferences.dart';

class SearchHistory {
  SharedPreferences? _prefs;

  static final SearchHistory _instance = SearchHistory._internal();
  SearchHistory._internal();
  factory SearchHistory() => _instance;

  Future init() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.setStringList('searchHistory', []);
  }

  List<String> getList() {
    return _prefs!.getStringList('searchHistory') ?? [];
  }

  Future<void> add(String value) async {
    List<String>? list = getList();

    if (!list.contains(value)) {
      list.add(value);
      await _prefs!.setStringList('searchHistory', list);
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
