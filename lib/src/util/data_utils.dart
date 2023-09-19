import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Name: data_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/18 14:49

// ignore: non_constant_identifier_names
final DataUtils = _DataUtilsClass();

class _DataUtilsClass {
  static _DataUtilsClass? _instance;

  _DataUtilsClass._internal() {
    _instance = this;
  }

  factory _DataUtilsClass() {
    return _instance ?? _DataUtilsClass._internal();
  }

  SharedPreferences? _prefs;

  Future<SharedPreferences> init({bool prefix = false}) async {
    if (prefix) {
      SharedPreferences.setPrefix(await PackageUtils.pkgName);
    }
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<bool> set(String key, dynamic value) async {
    await init();
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
    try {
      return (await init()).getInt(key) ?? defaultValue;
    } catch (e) {
      e.logE(tag: 'Exception msg');
    }

    return defaultValue;
  }

  Future<bool> getBool(String key, {bool defaultValue = false}) async {
    try {
      return (await init()).getBool(key) ?? defaultValue;
    } catch (e) {
      e.logE(tag: 'Exception msg');
    }

    return defaultValue;
  }

  Future<String> getString(String key, {String defaultValue = ''}) async {
    try {
      return (await init()).getString(key) ?? defaultValue;
    } catch (e) {
      e.logE(tag: 'Exception msg');
    }

    return defaultValue;
  }

  Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    try {
      return (await init()).getDouble(key) ?? defaultValue;
    } catch (e) {
      e.logE(tag: 'Exception msg');
    }

    return defaultValue;
  }

  Future<List<String>> getStringList(String key, {List<String> defaultValue = const []}) async {
    try {
      return (await init()).getStringList(key) ?? defaultValue;
    } catch (e) {
      e.logE(tag: 'Exception msg');
    }

    return defaultValue;
  }
}
