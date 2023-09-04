import 'package:base_lib_pub/src/util/image_utils.dart';
import 'package:base_lib_pub/src/util/network/network_utils.dart';
import 'package:flutter/material.dart';

import 'route/nav.dart';
import 'ui/common_ui.dart';
import 'util/crash_utils.dart';
import 'util/file_utils.dart';
import 'util/log_utils.dart';

/// Name: base_main.dart
///
/// Created by Static4u
/// Date : 2022/11/6 16:43

void initBaseApp({
  enableLog = false,
  String? crashDefaultMsg,
  Color statusBarColor = Colors.transparent,
  Brightness iconBrightness = Brightness.light,
  Brightness barBrightness = Brightness.light,
  List<String>? unPopRoutes,
  bool initWeChat = false,
  bool initNetwork = false,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  initMyDefaultDir();
  initCrashHandler(msg: crashDefaultMsg);
  initUi(
    statusBarColor: statusBarColor,
    iconBrightness: iconBrightness,
    barBrightness: barBrightness,
  );
  initLog(enable: enableLog);
  Nav.initUnPopRoutes(unPopRoutes ?? []);
  if (initWeChat) {
    initWechatAssetsPicker();
  }
  if (initNetwork) {
    initDio();
  }
}

void initUi({
  Color statusBarColor = Colors.transparent,
  Brightness iconBrightness = Brightness.light,
  Brightness barBrightness = Brightness.light,
}) {
  setGlobalStatusBarStyle();
}

void initLog({bool enable = false}) {
  isForceLog = enable;
}
