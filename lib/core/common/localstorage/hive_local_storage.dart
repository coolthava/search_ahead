// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:flutter/foundation.dart';
// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:search_ahead/core/common/utils/localstorage/i_local_storage.dart';
//
// class HiveLocalStorage implements ILocalStorage, WillSignalReady {
//   late Box _hiveBox;
//   final ILocalStorage _secureStorage;
//
//   ///BOX_KEY is version of hive storage
//   // ignore: constant_identifier_names
//   static const BOX_KEY = 'boxkey2';
//
//   HiveLocalStorage(this._secureStorage);
//
//   @override
//   Future<ILocalStorage> init({required String dbName}) async {
//     await Hive.initFlutter();
//     registerAdapter();
//
//     var keyBox = await _secureStorage.getString(BOX_KEY);
//     if (keyBox.isEmpty) {
//       var newKey = Hive.generateSecureKey();
//       _secureStorage.clearData();
//       await Hive.deleteBoxFromDisk(dbName);
//       _secureStorage.putEncryptedString(BOX_KEY, base64UrlEncode(newKey));
//     }
//
//     var securekey = await _secureStorage.getString(BOX_KEY);
//     var keyInt = base64Url.decode(securekey);
//     await openHiveBoxDb(dbName, keyInt);
//     if (_hiveBox.isOpen) {
//       await _hiveBox.compact();
//       await _hiveBox.close();
//     }
//     await openHiveBoxDb(dbName, keyInt);
//
//     if (kDebugMode) {
//       print('HiveLocalStorage -> Finish Init');
//     }
//     return this;
//   }
//
//   Future openHiveBoxDb(String dbName, Uint8List keyInt) async {
//     _hiveBox = await Hive.openBox<Object>(dbName,
//         encryptionCipher: HiveAesCipher(keyInt));
//   }
//
//   @override
//   void registerAdapter() {}
//
//   @override
//   void clearData() {
//     _hiveBox.clear();
//   }
//
//   @override
//   Future<dynamic> getData(String param, {dynamic defValue}) async {
//     return await _hiveBox.get(param, defaultValue: defValue);
//   }
//
//   @override
//   Future<String> getString(String param, {String defValue = ''}) async {
//     return _hiveBox.get(param, defaultValue: defValue).toString();
//   }
//
//   @override
//   Future<int> getInt(String param, {int defValue = 0}) async {
//     dynamic value = await _hiveBox.get(param, defaultValue: defValue);
//     var data = tryCast<int>(value, fallback: defValue);
//     return data;
//   }
//
//   @override
//   Future<bool> getBoolean(String param, {bool defValue = false}) async {
//     dynamic value = await _hiveBox.get(param, defaultValue: defValue);
//     var data = tryCast<bool>(value, fallback: defValue);
//     return data;
//   }
//
//   @override
//   Future<List> getListData(
//     String param, {
//     List defValue = const <dynamic>[],
//   }) async {
//     dynamic value = await _hiveBox.get(param, defaultValue: <dynamic>[]);
//     var data = tryCast<List>(value, fallback: <dynamic>[]);
//     return data;
//   }
//
//   @override
//   void putEncryptedString(String key, String? data) {
//     throw UnimplementedError(
//         'Please use Secure Storage to store encrypted string');
//   }
//
//   @override
//   Future<void> putData(String key, Object? data) async {
//     return await _hiveBox.put(key, data);
//   }
//
//   @override
//   Future<void> putAsyncData(String key, Object data) async {
//     return await _hiveBox.put(key, data);
//   }
//
//   @override
//   Future<void> putListData(String key, List<dynamic> list) async {
//     return await _hiveBox.put(key, list);
//   }
//
//   @override
//   void deleteData(String key) {
//     _hiveBox.delete(key);
//   }
// }
