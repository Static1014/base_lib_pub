import 'dart:ui';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get.dart';

/// Name: getx_ext.dart
///
/// Created by Static4u
/// Date : 2023/9/15 09:32

// ignore: non_constant_identifier_names
final MyGet = _MyGetImpl();

class _MyGetImpl extends GetInterface {
  /// 双击退出
  DateTime? lastTime;

  bool isStatusBarVisible = true; // 状态栏可见
  bool isSysNavigationBarVisible = true; // 系统导航栏可见
  /// 当前应用状态栏、底部系统导航栏(不一定存在)配色
  bool isStatusBarIconLight = true; //状态栏（深底白字）
  Color statusBarBgColor = BaseColors.cTransparent; // 状态栏背景色
  bool isSysNavigationBarIconLight = true; //系统导航栏（深底白字）
  Color sysNavigationBarBgColor = BaseColors.cBlack; // 系统导航栏背景色
}

extension GetExt on GetInterface {
  /// 当以非singleTop模式启动多个同一页面，必须使用不同tag的logic进行处理。
  /// 当需要从外部获取对应logic（页面关闭时可能已经销毁）时，需要先判断是否存在
  T? findLogic<T>({String? tag}) {
    bool isR = Get.isRegistered<T>(tag: tag);
    '$T${tag == null ? '' : '($tag)'} - $isR'.logE();
    if (isR) {
      return Get.find<T>(tag: tag);
    }
    return null;
  }
}
