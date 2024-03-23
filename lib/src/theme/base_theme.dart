import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Name: base_theme.dart
///
/// Created by Static4u
/// Date : 2023/12/13 10:54

class ThemeHolder {
  String name;
  ThemeData themeData;

  ThemeHolder(this.name, this.themeData);
}

class BaseTheme {
  static ThemeData createTheme({
    required Color primaryColor,
    required Color error,
    Color? secondary,
    Color? splashColor,
    Brightness brightness = Brightness.light,
  }) {
    MaterialColor primaryMC = primaryColor.toMaterialColor;
    return BaseTheme._createBaseTheme(primaryColor).copyWith(
      primaryColor: primaryColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: BaseColors.cWhite,
        secondary: primaryMC.shade300,
        onSecondary: BaseColors.cWhite,
        error: error,
        onError: BaseColors.cWhite,
        background: BaseColors.cGrayLightBg,
        onBackground: BaseColors.cFontGray,
        surface: BaseColors.cWhite,
        onSurface: BaseColors.cFontGray,
      ),
      splashColor: primaryMC.shade50,
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

  static final ThemeData defaultTheme = _createBaseTheme(BaseColors.cPrimaryColor);
  static final AppBarTheme defaultAppBarTheme = createAppBarTheme(bgColor: BaseColors.cPrimaryColor, scrolledUnderElevation: 4);

  /// 修正flutter 3.16下M2 -> M3样式的变化
  static ThemeData _createBaseTheme(
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
      ),
      // 自定义
      textTheme: defaultTextTheme,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: BaseColors.cFontGrayLight, height: 1.2),
      ),
    );
  }

  static AppBarTheme createAppBarTheme({
    required Color bgColor,
    Color? iconColor,
    TextStyle? titleTextStyle,
    double? elevation,
    double? scrolledUnderElevation,
    SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle.light,
    Brightness brightness = Brightness.light,
    bool? centerTitle,
  }) {
    return (brightness == Brightness.light ? ThemeData.light() : ThemeData.dark()).appBarTheme.copyWith(
          iconTheme: IconThemeData(
            color: iconColor,
            size: BaseDimens.dIconSize,
          ),
          centerTitle: centerTitle,
          elevation: elevation,
          backgroundColor: bgColor,
          titleTextStyle: titleTextStyle ?? Typography.dense2014.titleLarge,
          systemOverlayStyle: overlayStyle,
          scrolledUnderElevation: scrolledUnderElevation,
        );
  }

  static TextTheme defaultTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      color: BaseColors.cFontBlackLight,
      fontSize: BaseDimens.dFontSizeLarge,
      overflow: TextOverflow.ellipsis,
      height: 1.3,
      decoration: TextDecoration.none,
    ),
    bodyMedium: TextStyle(
      color: BaseColors.cFontBlack,
      fontSize: BaseDimens.dFontSizeNormal,
      overflow: TextOverflow.ellipsis,
      height: 1.3,
      decoration: TextDecoration.none,
    ),
    bodySmall: TextStyle(
      color: BaseColors.cFontGrayLight,
      fontSize: BaseDimens.dFontSizeSmall,
      overflow: TextOverflow.ellipsis,
      height: 1.3,
      decoration: TextDecoration.none,
    ),
  );
}
