import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_colors.dart';
import 'my_theme_data.dart';

/// Name :my_themes.dart
///
/// Created by Static4u
/// Date : 2024/3/23 22:18
///
// ignore: non_constant_identifier_names
final MyThemes = MyThemesClass();

class ThemeHolder {
  String name;
  ThemeData themeData;

  ThemeHolder(this.name, this.themeData);
}

class MyThemesClass {
  final _keyCurThemeName = 'keyCurThemeName';

  // 静态变量
  static final MyThemesClass _singleton = MyThemesClass._internal();

  // 工厂方法
  factory MyThemesClass() {
    return _singleton;
  }

  List<ThemeHolder> themeList = [];
  late ThemeHolder curThemeHolder;

  // 私有构造函数
  MyThemesClass._internal() {
    MaterialColor rcColor = BaseColors.cOrange.toMaterialColor;
    final green = ThemeHolder(
      'green',
      BaseTheme.createTheme(
        primaryColor: MyColors.cc2,
        error: MyColors.cc4,
        secondary: MyColors.cc3,
        extensions: <ThemeExtension<MyThemeData>>[
          MyThemeData(record: rcColor.shade500),
        ],
      ),
    );
    final red = ThemeHolder(
      'red',
      BaseTheme.createTheme(
        primaryColor: MyColors.cc4,
        error: MyColors.cc4,
        secondary: MyColors.cc3,
        extensions: <ThemeExtension<MyThemeData>>[
          MyThemeData(record: rcColor.shade50),
        ],
      ),
    );
    final blue = ThemeHolder(
      'blue',
      BaseTheme.createTheme(
        primaryColor: MyColors.cc1,
        error: MyColors.cc4,
        secondary: MyColors.cc3,
        extensions: <ThemeExtension<MyThemeData>>[
          MyThemeData(record: rcColor.shade900),
        ],
      ),
    );
    themeList = [green, red, blue];
    curThemeHolder = themeList[0];
  }

  Future<bool> changeTheme({String? name}) async {
    if (isEmptyOrNull(name)) {
      name = await DataUtils.getString(_keyCurThemeName, defaultValue: '');
      if (name == '') {
        // 没指定，也没有存储值，不修改主题
        return false;
      }
    }
    ThemeHolder? target = themeList.firstWhereOrNull((element) => element.name == name);
    if (target == null) {
      // 指定错误，也不修改主题
      return false;
    }

    Get.changeTheme(target.themeData);
    DataUtils.set(_keyCurThemeName, name);
    curThemeHolder = target;
    return true;
  }
}
