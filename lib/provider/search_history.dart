import 'package:shared_preferences/shared_preferences.dart';

import 'preferences.dart';

class SearchHistory {
  static const int maxCount = 10;
  final SharedPreferences? _preferences = Preferences().get();

  static final SearchHistory _instance = SearchHistory._internal();
  SearchHistory._internal();
  factory SearchHistory() => _instance;

  List<String> getList() {
    return _preferences?.getStringList('searchHistory') ?? [];
  }

  Future<void> add(String value) async {
    if (value.isNotEmpty) {
      List<String>? list = getList();

      if (!list.contains(value)) {
        list.insert(0, value);
        int end = list.length > maxCount ? maxCount : list.length;
        await _preferences?.setStringList(
            'searchHistory', list.sublist(0, end));
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

    await _preferences?.setStringList('searchHistory', list);
  }

  Future<void> clear() async {
    await _preferences?.remove('searchHistory');
  }
}
