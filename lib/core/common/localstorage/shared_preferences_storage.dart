import 'package:get_it/get_it.dart';
import 'package:search_ahead/core/common/utils/localstorage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements ILocalStorage, WillSignalReady {
  late SharedPreferences preferences;

  @override
  Future<bool> initState() async {
    preferences = await SharedPreferences.getInstance();

    return true;
  }

  @override
  void clearData() {
    preferences.clear();
  }

  @override
  void deleteData(String key) {
    preferences.remove(key);
  }

  @override
  bool getBoolean(String key, {required bool defValue}) {
    return preferences.getBool(key) ?? defValue;
  }

  @override
  int getInt(String key, {required int defValue}) {
    return preferences.getInt(key) ?? defValue;
  }

  @override
  String getString(String key, {required String defValue}) {
    return preferences.getString(key) ?? defValue;
  }

  @override
  List<String> getStringList(String key) {
    return preferences.getStringList(key) ?? [];
  }

  @override
  void putBool(String key, bool value) {
    preferences.setBool(key, value);
  }

  @override
  void putInt(String key, int value) {
    preferences.setInt(key, value);
  }

  @override
  void putString(String key, String value) {
    preferences.setString(key, value);
  }

  @override
  void putStringList(String key, List<String> value) {
    preferences.setStringList(key, value);
  }
}
