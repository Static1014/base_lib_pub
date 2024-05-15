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
    Brightness brightness = Brightness.light,
    required Color primaryColor,
    required Color error,
    Color? secondary,
    Color? onPrimary,
    Color? onSecondary,
    Color? onError,
    Color? surface,
    Color? onSurface,
    ColorScheme? colorScheme,
    Color? splashColor,
    Color? appBarBgColor,
    Color? appBarForegroundColor,
    Color? iconColor,
    Color? cardColor,
    Color? bgColor,
    Color? scaffoldBgColor,
    Color? textColor,
    Color? inputHintColor,
    Color? bodyLarge,
    Color? bodyMedium,
    Color? bodySmall,
    Color? indicatorColor,
    Iterable<ThemeExtension<dynamic>>? extensions,
    String? fontFamily,
  }) {
    MaterialColor primaryMC = primaryColor.toMaterialColor;
    return BaseTheme._createBaseTheme(primaryColor).copyWith(
      primaryColor: primaryColor,
      colorScheme: colorScheme ??
          ColorScheme(
            brightness: brightness,
            primary: primaryColor,
            onPrimary: onPrimary ?? BaseColors.cWhite,
            secondary: secondary ?? primaryMC.shade300,
            onSecondary: onSecondary ?? BaseColors.cWhite,
            error: error,
            onError: onError ?? BaseColors.cWhite,
            surface: surface ?? BaseColors.cWhite,
            onSurface: onSurface ?? BaseColors.cFontGray,
          ),
      splashColor: splashColor ?? primaryMC.shade50,
      iconButtonTheme: IconButtonThemeData(style: IconButton.styleFrom(foregroundColor: iconColor ?? primaryColor)),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: onPrimary ?? BaseColors.cWhite,
          textStyle: TextStyle(fontFamily: fontFamily),
        ),
      ),
      iconTheme: IconThemeData(color: iconColor ?? primaryColor),
      cardTheme: CardTheme(color: cardColor ?? primaryColor, elevation: 2),
      scaffoldBackgroundColor: scaffoldBgColor ?? BaseColors.cGrayBgMiddle,
      appBarTheme: BaseTheme.defaultAppBarTheme.copyWith(
        color: appBarBgColor ?? BaseColors.cWhite,
        centerTitle: true,
        scrolledUnderElevation: 2,
        shadowColor: BaseColors.cGrayLine,
        iconTheme: BaseTheme.defaultAppBarTheme.iconTheme?.copyWith(color: appBarForegroundColor),
        titleTextStyle: BaseTheme.defaultAppBarTheme.titleTextStyle?.copyWith(
          color: appBarForegroundColor ?? primaryColor,
          fontSize: BaseDimens.dFontSizeTitle,
          fontWeight: FontWeight.bold,
          fontFamily: fontFamily,
        ),
      ),
      // 自定义
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(textStyle: TextStyle(fontFamily: fontFamily))),
      textTheme: createTextTheme(
        bodyLarge: bodyLarge,
        bodyMedium: bodyMedium,
        bodySmall: bodySmall,
        label: onPrimary ?? BaseColors.cWhite,
        fontFamily: fontFamily,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: inputHintColor ?? BaseColors.cFontGrayLight, height: 1.3).apply(fontFamily: fontFamily),
      ),
      indicatorColor: indicatorColor ?? primaryColor,
      extensions: extensions,
    );
  }

  static final ThemeData defaultTheme = _createBaseTheme(BaseColors.cPrimaryColor);
  static final AppBarTheme defaultAppBarTheme = createAppBarTheme(bgColor: BaseColors.cPrimaryColor, scrolledUnderElevation: 4);

  /// 修正flutter 3.16下M2 -> M3样式的变化
  static ThemeData _createBaseTheme(
    Color color, {
    Brightness brightness = Brightness.light,
    Iterable<ThemeExtension<dynamic>>? extensions,
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
      extensions: extensions,
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

  static TextTheme createTextTheme({
    Color? bodyLarge,
    Color? bodyMedium,
    Color? bodySmall,
    Color? label,
    String? fontFamily,
    Brightness brightness = Brightness.light,
  }) {
    return (brightness == Brightness.light ? ThemeData.light() : ThemeData.dark())
        .textTheme
        .copyWith(
          bodyLarge: TextStyle(
            color: bodyLarge ?? BaseColors.cFontBlackLight,
            fontSize: BaseDimens.dFontSizeLarge,
            overflow: TextOverflow.ellipsis,
            height: 1.3,
            decoration: TextDecoration.none,
          ),
          bodyMedium: TextStyle(
            color: bodyMedium ?? BaseColors.cFontBlack,
            fontSize: BaseDimens.dFontSizeNormal,
            overflow: TextOverflow.ellipsis,
            height: 1.3,
            decoration: TextDecoration.none,
          ),
          bodySmall: TextStyle(
            color: bodySmall ?? BaseColors.cFontGrayLight,
            fontSize: BaseDimens.dFontSizeSmall,
            overflow: TextOverflow.ellipsis,
            height: 1.3,
            decoration: TextDecoration.none,
          ),
          // labelLarge: TextStyle(
          //   color: label ?? BaseColors.cFontBlack,
          //   fontSize: BaseDimens.dFontSizeLarge,
          //   overflow: TextOverflow.ellipsis,
          //   height: 1.3,
          //   decoration: TextDecoration.none,
          // ),
          // labelMedium: TextStyle(
          //   color: label ?? BaseColors.cFontBlack,
          //   fontSize: BaseDimens.dFontSizeNormal,
          //   overflow: TextOverflow.ellipsis,
          //   height: 1.3,
          //   decoration: TextDecoration.none,
          // ),
          // labelSmall: TextStyle(
          //   color: label ?? BaseColors.cFontBlack,
          //   fontSize: BaseDimens.dFontSizeSmall,
          //   overflow: TextOverflow.ellipsis,
          //   height: 1.3,
          //   decoration: TextDecoration.none,
          // ),
        )
        .apply(fontFamily: fontFamily, displayColor: label);
  }
}
