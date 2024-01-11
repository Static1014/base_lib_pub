import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'lang.dart';

/// Name: StrTranslation.dart
///
/// Created by Static4u
/// Date : 2023/4/12 08:52
class MyTrans extends Translations {
  // 默认使用设备locale
  static Locale? get locale => Get.deviceLocale;

  // locale指定失败时的locale
  static const fallbackLocale = Locale('zh', 'CN');

  MyTrans() {
    enUS.addAll(baseEnUS);
    zhCN.addAll(baseZhCN);
  }

  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': enUS,
      'zh_CN': zhCN,
    };
  }
}
