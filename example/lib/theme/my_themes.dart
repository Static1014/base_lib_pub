import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';

import 'my_colors.dart';

/// Name: my_themes.dart
///
/// Created by Static4u
/// Date : 2023/7/12 10:35

class MyThemes {
  static const Color primaryColorLight = MyColors.cc2;

  static final light = BaseTheme.createBaseTheme(primaryColorLight).copyWith(
    primaryColor: primaryColorLight,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColorLight,
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
    splashColor: MyColors.cc4,
    iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: primaryColorLight)),
    iconTheme: const IconThemeData(color: primaryColorLight),
    cardTheme: const CardTheme(color: primaryColorLight, elevation: 2),
    scaffoldBackgroundColor: BaseColors.cGrayBgMiddle,
    appBarTheme: BaseTheme.defaultAppBarTheme.copyWith(
      color: BaseColors.cWhite,
      centerTitle: true,
      scrolledUnderElevation: 4,
      shadowColor: BaseColors.cGrayLine,
      titleTextStyle: BaseTheme.defaultAppBarTheme.titleTextStyle?.copyWith(
        color: primaryColorLight,
        fontSize: BaseDimens.dFontSizeTitle,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static final dark = BaseTheme.createBaseTheme(MyColors.cc2, brightness: Brightness.dark);

  static const Color primaryColorRed = MyColors.cc4;

  static final red = BaseTheme.createBaseTheme(primaryColorRed).copyWith(
    primaryColor: primaryColorRed,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColorRed,
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
    splashColor: MyColors.cc4,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return primaryColorRed.toMaterialColor[600];
          }
          return primaryColorRed;
        }),
      ),
    ),
    iconTheme: const IconThemeData(color: primaryColorRed),
    cardTheme: const CardTheme(color: primaryColorRed, elevation: 2),
    scaffoldBackgroundColor: BaseColors.cGrayBgMiddle,
    appBarTheme: BaseTheme.defaultAppBarTheme.copyWith(
      color: BaseColors.cWhite,
      scrolledUnderElevation: 4,
      shadowColor: BaseColors.cGrayLine,
      titleTextStyle: BaseTheme.defaultAppBarTheme.titleTextStyle?.copyWith(
        color: primaryColorRed,
        fontSize: BaseDimens.dFontSizeTitle,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
