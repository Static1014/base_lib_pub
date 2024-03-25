import 'package:flutter/material.dart';

/// Name: color_ext.dart
///
/// Created by Static4u
/// Date : 2023/12/13 11:09
extension ColorExt on Color {
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
}

extension MaterialColorExt on MaterialColor {
  get dark => shade900;
}
