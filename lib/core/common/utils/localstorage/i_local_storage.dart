abstract class ILocalStorage {
  void clearData();

  Future<bool> initState();

  String getString(String key, {required String defValue});
  bool getBoolean(String key, {required bool defValue});
  int getInt(String key, {required int defValue});
  List<String> getStringList(String key);

  void putString(String key, String value);
  void putBool(String key, bool value);
  void putInt(String key, int value);
  void putStringList(String key, List<String> value);

  void deleteData(String key);
}
