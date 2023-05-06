import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  SharedPreferences? _sharedPreferences;

  static final Preferences _instance = Preferences._internal();
  Preferences._internal();
  factory Preferences() => _instance;

  Future<void> init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences?.setStringList('searchHistory', []);
      await _sharedPreferences?.setString('loopMode', 'all');
    }
  }

  SharedPreferences? get() {
    return _sharedPreferences;
  }
}
