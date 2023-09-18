import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Name: data_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/18 14:49

// ignore: non_constant_identifier_names
final DataUtils = DataUtilsClass();

class DataUtilsClass {
  static DataUtilsClass? _instance;

  DataUtilsClass._internal() {
    _instance = this;
  }

  factory DataUtilsClass() {
    return _instance ?? DataUtilsClass._internal();
  }

  SharedPreferences? _prefs;

  Future<bool> set(String key, dynamic value) async {
    _prefs ??= await SharedPreferences.getInstance();

    if (value is int) {
      return await _prefs!.setInt(key, value);
    } else if (value is bool) {
      return await _prefs!.setBool(key, value);
    } else if (value is String) {
      return await _prefs!.setString(key, value);
    } else if (value is double) {
      return await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      return await _prefs!.setStringList(key, value);
    } else {
      String msg = 'Not supported value type: ${value.runtimeType}';
      msg.logE(tag: 'DataUtils');
      throw Exception(msg);
    }
  }

  Future<int> getInt(String key, {int defaultValue = 0}) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getInt(key) ?? defaultValue;
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getBool(key) ?? defaultValue;
  }

  Future<String> getString(String key, {String defaultValue = ''}) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getString(key) ?? defaultValue;
  }

  Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getDouble(key) ?? defaultValue;
  }

  Future<List<String>> getStringList(String key, {List<String> defaultValue = const []}) async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!.getStringList(key) ?? defaultValue;
  }
}
