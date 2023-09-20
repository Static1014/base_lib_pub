import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: base_main.dart
///
/// Created by Static4u
/// Date : 2022/11/6 16:43

void initBaseApp({
  /// 是否开启日志
  enableLog = false,

  /// 是否开启日志
  String? crashPrefixMsg,

  /// 状态栏和系统导航栏配色
  Color statusBarColor = BaseColors.cTransparent,
  Color sysNavigationBarColor = BaseColors.cBlack,
  bool isStatusBarIconLight = true, // 深底白字
  bool isSysNavigationBarIconLight = true, // 深底白字

  /// 底层路由
  List<String>? unPopRoutes,

  /// 初始化仿微信图片选择
  bool initWeChat = false,

  /// 默认路由跳转动画
  Transition? defaultTransition = Transition.cupertino,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  initMyDefaultDir();
  initCrashHandler(prefixMsg: crashPrefixMsg);
  setGlobalSystemOverlayStyle(
    statusBarColor: statusBarColor,
    isStatusBarIconLight: isStatusBarIconLight,
    sysNavigationBarColor: sysNavigationBarColor,
    isSysNavigationBarIconLight: isStatusBarIconLight,
  );
  Nav.initUnPopRoutes(unPopRoutes ?? []);
  if (initWeChat) {
    initWechatAssetsPicker();
  }
  initLog(enable: enableLog);
  Get.config(
    enableLog: enableLog,
    defaultTransition: defaultTransition,
  );
  DataUtils.init(prefix: true);
}

void initLog({bool enable = false}) {
  isForceLog = enable;
}
