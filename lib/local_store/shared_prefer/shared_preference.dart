import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  SharedPreferenceUtil._internal();
  factory SharedPreferenceUtil() => _instance;
  static final SharedPreferenceUtil _instance =
      SharedPreferenceUtil._internal();

  Future<bool> setInt({required String key, required int value}) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<bool> setBool({required String key, required bool value}) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  Future<bool> setDouble({required String key, required double value}) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  Future<bool> setString({required String key, required String value}) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<bool> setStringList(
      {required String key, required List<String> value}) async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, value);
  }

  Object? get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
