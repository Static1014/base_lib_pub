import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Name: base_theme.dart
///
/// Created by Static4u
/// Date : 2023/12/13 10:54
class BaseTheme {
  static ThemeData defaultTheme = createBaseTheme(BaseColors.cPrimaryColor);

  /// 修正flutter 3.16下M2 -> M3样式的变化
  static ThemeData createBaseTheme(
    Color color, {
    Brightness brightness = Brightness.light,
  }) {
    return (Brightness.light == brightness ? ThemeData.light() : ThemeData.dark()).copyWith(
        // primarySwatch: color.toMaterialColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: color,
          primary: color,
          brightness: brightness,
          surfaceTint: BaseColors.cTransparent,
        ),
        iconTheme: const IconThemeData(
          size: BaseDimens.dIconSize,
          fill: 0.0,
          weight: 400.0,
          grade: 0.0,
          opticalSize: BaseDimens.dIconBtnHeight,
          color: BaseColors.cWhite,
          opacity: 0.8,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: BaseColors.cWhite,
          backgroundColor: color,
          shape: const CircleBorder(),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(
            color: BaseColors.cWhite,
            size: BaseDimens.dIconSize,
          ),
          backgroundColor: color,
          titleTextStyle: Typography.dense2014.titleLarge,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        tabBarTheme: const TabBarTheme(
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: BaseColors.cFontWhite,
          labelPadding: EdgeInsets.zero,
        ));
  }
}
