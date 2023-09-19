import 'package:package_info_plus/package_info_plus.dart';

/// Name: package_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/19 10:21

// ignore: non_constant_identifier_names
final PackageUtils = _PackageUtilsClass();

class _PackageUtilsClass {
  static _PackageUtilsClass? _instance;

  _PackageUtilsClass._internal() {
    _instance = this;
  }

  factory _PackageUtilsClass() {
    return _instance ?? _PackageUtilsClass._internal();
  }

  PackageInfo? _pkgInfo;

  Future<PackageInfo> init() async {
    _pkgInfo ??= await PackageInfo.fromPlatform();
    return _pkgInfo!;
  }

  Future<String> get appName async => (await init()).appName;

  Future<String> get pkgName async => (await init()).packageName;

  Future<String> get versionName async => (await init()).version;

  Future<String> get versionCode async => (await init()).buildNumber;
}
