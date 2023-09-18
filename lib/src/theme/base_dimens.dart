import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: dart
///
/// Created by Static4u
/// Date : 2021/7/15 10:01 上午
class BaseDimens {
  static const double dFontSizeSmallEx = 12;
  static const double dFontSizeSmall = 14;
  static const double dFontSizeNormal = 16;
  static const double dFontSizeLarge = 18;
  static const double dFontSizeLargeEx = 26;
  static const double dFontSize20 = 20;
  static const double dFontSizeTitle = 20;

  static const double dFontSizeBtnSmall = 16;
  static const double dFontSizeBtnNormal = 18;

  /// 默认padding、margin
  static const double dPadding = 12, dMargin = 12;

  /// 默认按钮高度
  static const double dBtnHeight = 40; // 44
  static const double dIconBtnHeight = 50; // 44
  static const double dIconSize = 20;

  static double dStatusBarHeight = MediaQuery.of(Get.context!).padding.top;
  static const double dAppBarHeight = 56;

  /// header高度
  static const double dHeaderHeightDefault = 64;

  /// footer高度
  static const double dBottomBarHeightDefault = 56;

  /// FAB大小
  static const double dFabSize = 50;

  /// 显示“回到顶部”按钮的滚动距离
  static const double dOffsetShowTopBtn = 600;

  /// 默认图片比例
  static const double dImgRatio = 16 / 9;

  /// 一小时毫秒数
  static const int dOneHourInMs = 3600000;

  /// 一小时秒数
  static const int dOneHourInSec = 3600;

  /// 密码长度6-45
  static const int dPwdMinLen = 6;
  static const int dPwdMaxLen = 45;
}
