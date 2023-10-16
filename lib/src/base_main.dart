import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: base_main.dart
///
/// Created by Static4u
/// Date : 2022/11/6 16:43

typedef RoundAppRun = Future<void> Function();

void runMyApp(
  Widget app, {
  /// 是否开启日志
  enableLog = false,

  /// 状态栏和系统导航栏配色
  Color statusBarColor = BaseColors.cTransparent,
  Color sysNavigationBarColor = BaseColors.cBlack,
  bool isStatusBarIconLight = true, // 深底白字
  bool isSysNavigationBarIconLight = true, // 深底白字

  /// 底层路由
  List<String>? unPopRoutes,

  /// 默认路由跳转动画
  Transition? defaultTransition = Transition.cupertino,

  /// 自定义启动前执行
  RoundAppRun? beforeRun,

  /// 初始化仿微信图片选择
  bool initWeChat = false,

  /// 是否开启日志
  String? crashPrefixMsg,

  /// 自定义启动后执行
  RoundAppRun? afterRun,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  setGlobalSystemOverlayStyle(
    statusBarColor: statusBarColor,
    isStatusBarIconLight: isStatusBarIconLight,
    sysNavigationBarColor: sysNavigationBarColor,
    isSysNavigationBarIconLight: isStatusBarIconLight,
  );
  Nav.initUnPopRoutes(unPopRoutes ?? []);
  initLog(enable: enableLog);
  Get.config(
    enableLog: enableLog,
    defaultTransition: defaultTransition,
  );

  baseBeforeRun().then((value) {
    /// 自定义启动前执行
    if (beforeRun != null) {
      beforeRun.call().then((value) {
        runBaseApp(
          app,
          initWeChat: initWeChat,
          crashPrefixMsg: crashPrefixMsg,
          afterRun: afterRun,
        );
      });
    } else {
      runBaseApp(
        app,
        initWeChat: initWeChat,
        crashPrefixMsg: crashPrefixMsg,
        afterRun: afterRun,
      );
    }
  });
}

void runBaseApp(
  Widget app, {
  /// 初始化仿微信图片选择
  bool initWeChat = false,

  /// 是否开启日志
  String? crashPrefixMsg,

  /// 自定义启动后执行
  RoundAppRun? afterRun,
}) {
  /// 启动app
  runApp(app);

  /// 部分初始化任务可在启动app之后执行
  initCrashHandler(prefixMsg: crashPrefixMsg);
  if (initWeChat) {
    initWechatAssetsPicker();
  }

  /// 自定义启动后执行，即使是异步的，也不用处理异步返回
  afterRun?.call();
}

Future<void> baseBeforeRun() async {
  await initMyDefaultDir();
  await DataUtils.init(prefix: true);

  return;
}

void initLog({bool enable = false}) {
  isForceLog = enable;
}
