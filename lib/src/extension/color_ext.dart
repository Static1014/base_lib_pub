import 'package:flutter/material.dart';

/// Name: color_ext.dart
///
/// Created by Static4u
/// Date : 2023/12/13 11:09
extension ColorExt on Color {
  /// 获得颜色的浅色和深色
  ///
  /// @shade 颜色深浅值
  /// ```
  ///   0:        白色;
  ///   (0,1):    浅色;
  ///   1:        原本色;
  ///   (1,2):    深色;
  ///   2:        黑色;
  ///   如果超出范围则取正、取模
  /// ```
  /// @alpha 透明度
  Color shade(double shade, {double alpha = 1}) {
    // assert(shade >= 0 && shade <= 2, 'shade should be between 0 and 2');
    if (shade < 0) {
      shade = shade.abs();
    }
    if (shade > 2) {
      shade = shade % 2;
    }
    Color color = this;
    final int r = color.red, g = color.green, b = color.blue;
    final ds = 1 - shade;
    return Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      alpha,
    );
  }

  /// 转变为MaterialColor
  get toMaterialColor {
    Color color = this;
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  get toMaterialStatePropertyAll {
    return MaterialStatePropertyAll<Color>(this);
  }

  // 转十六进制字符
  String toHexString() => '#${value.toRadixString(16).padLeft(8, '0')}';
}

extension MaterialColorExt on MaterialColor {
  get dark => shade900;
}
