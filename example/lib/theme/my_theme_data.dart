import 'package:flutter/material.dart';

/// Name: my_theme_data.dart
///
/// Created by Static4u
/// Date : 2024/3/25 16:31
class MyThemeData extends ThemeExtension<MyThemeData> {
  final Color record;

  MyThemeData({required this.record});

  @override
  ThemeExtension<MyThemeData> copyWith() {
    return MyThemeData(record: record);
  }

  @override
  ThemeExtension<MyThemeData> lerp(covariant ThemeExtension<MyThemeData>? other, double t) {
    if (other is! MyThemeData) {
      return this;
    }

    return MyThemeData(record: Color.lerp(record, other.record, t)!);
  }
}

extension ThemeDataExt on ThemeData {
  // 获取自定义主题
  MyThemeData get myThemeData => extension<MyThemeData>()!;
}
