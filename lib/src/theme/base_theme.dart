import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Name: base_theme.dart
///
/// Created by Static4u
/// Date : 2023/12/13 10:54
class BaseTheme {
  static ThemeData defaultTheme = createBaseTheme(BaseColors.cPrimaryColor);
  static AppBarTheme defaultAppBarTheme = createAppBarTheme(bgColor: BaseColors.cPrimaryColor);

  /// 修正flutter 3.16下M2 -> M3样式的变化
  static ThemeData createBaseTheme(
    Color color, {
    Brightness brightness = Brightness.light,
  }) {
    return (Brightness.light == brightness ? ThemeData.light() : ThemeData.dark()).copyWith(
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
          // opacity: 0.8,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: BaseColors.cWhite,
          backgroundColor: color,
          shape: const CircleBorder(),
        ),
        appBarTheme: defaultAppBarTheme,
        tabBarTheme: const TabBarTheme(
          dividerHeight: 0,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: BaseColors.cFontWhite,
          labelPadding: EdgeInsets.zero,
        ));
  }

  static AppBarTheme createAppBarTheme({
    required Color bgColor,
    Color? iconColor,
    TextStyle? titleTextStyle,
    double? elevation,
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light,
    Brightness brightness = Brightness.light,
  }) {
    return (brightness == Brightness.light ? ThemeData.light() : ThemeData.dark()).appBarTheme.copyWith(
          iconTheme: IconThemeData(
            color: iconColor,
            size: BaseDimens.dIconSize,
          ),
          elevation: elevation,
          backgroundColor: bgColor,
          titleTextStyle: titleTextStyle ?? Typography.dense2014.titleLarge,
          systemOverlayStyle: overlayStyle,
        );
  }
}
