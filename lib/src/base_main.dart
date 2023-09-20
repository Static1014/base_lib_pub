import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: base_main.dart
///
/// Created by Static4u
/// Date : 2022/11/6 16:43

void initBaseApp({
  enableLog = false,
  String? crashDefaultMsg,
  Color statusBarColor = Colors.transparent,
  bool? isLightBarIcon = true, // 深底白字
  List<String>? unPopRoutes,
  bool initWeChat = false,
  Transition? defaultTransition = Transition.cupertino,
  bool enableData = false,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  initMyDefaultDir();
  initCrashHandler(msg: crashDefaultMsg);
  initUi(
    statusBarColor: statusBarColor,
    isLightBarIcon: isLightBarIcon ?? MyGet.isLightBarIcon,
  );
  initLog(enable: enableLog);
  Nav.initUnPopRoutes(unPopRoutes ?? []);
  if (initWeChat) {
    initWechatAssetsPicker();
  }
  Get.config(
    enableLog: enableLog,
    defaultTransition: defaultTransition,
  );
  DataUtils.init(prefix: true);
}

void initUi({
  Color statusBarColor = Colors.transparent,
  bool isLightBarIcon = true, // 深底白字
}) {
  setGlobalStatusBarStyle(statusBarColor: statusBarColor, isLightBarIcon: isLightBarIcon);
}

void initLog({bool enable = false}) {
  isForceLog = enable;
}
