import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_colors.dart';

/// Name: my_themes.dart
///
/// Created by Static4u
/// Date : 2023/7/12 10:35

class MyThemes {
  static final _light = _createTheme(MyColors.cc2);
  static final _red = _createTheme(MyColors.cc4);
  static final _blue = _createTheme(MyColors.cc1);

  static List<ThemeHolder> themeList = [
    ThemeHolder('light', _light),
    ThemeHolder('red', _red),
    ThemeHolder('blue', _blue),
  ];

  static ThemeHolder curThemeHolder = themeList[0];

  static const _keyCurThemeName = 'keyCurThemeName';

  static Future<bool> changeTheme({String? name}) async {
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

  static ThemeData _createTheme(Color primaryColor, {Brightness brightness = Brightness.light}) {
    return BaseTheme.createBaseTheme(primaryColor).copyWith(
      primaryColor: primaryColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: BaseColors.cWhite,
        secondary: MyColors.cc3,
        onSecondary: BaseColors.cWhite,
        error: MyColors.cc4,
        onError: BaseColors.cWhite,
        background: BaseColors.cGrayLightBg,
        onBackground: BaseColors.cFontGray,
        surface: BaseColors.cWhite,
        onSurface: BaseColors.cFontGray,
      ),
      splashColor: MyColors.cc3,
      iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: primaryColor)),
      iconTheme: IconThemeData(color: primaryColor),
      cardTheme: CardTheme(color: primaryColor, elevation: 2),
      scaffoldBackgroundColor: BaseColors.cGrayBgMiddle,
      appBarTheme: BaseTheme.defaultAppBarTheme.copyWith(
        color: BaseColors.cWhite,
        centerTitle: true,
        scrolledUnderElevation: 4,
        shadowColor: BaseColors.cGrayLine,
        titleTextStyle: BaseTheme.defaultAppBarTheme.titleTextStyle?.copyWith(
          color: primaryColor,
          fontSize: BaseDimens.dFontSizeTitle,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ThemeHolder {
  String name;
  ThemeData themeData;

  ThemeHolder(this.name, this.themeData);
}
