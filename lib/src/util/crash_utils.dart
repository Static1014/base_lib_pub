import 'package:date_format/date_format.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../base_lib_pub.dart';

/// Name: crash_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/2 19:46

/// 崩溃监听
void initCrashHandler({String? prefixMsg, toastError = false}) {
  /// 崩溃处理
  void reportCrash(FlutterErrorDetails details) async {
    if (toastError) {
      // commonToast(
      //   details.exception.toString(),
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      // );
    }
    prefixMsg ??= BaseTrs.crash.tr;
    try {
      writeToFile("${myDefaultDirPath}crash/log-${DateTime.now().toFormatString(format: [yyyy, '-', mm, '-', dd])}.txt",
          "\n\n\n${DateTime.now().toFormatString()}===============\n${details.exception.toString()}\n${details.stack.toString()}",
          append: true);
      "$prefixMsg$details".logE();
    } catch (_) {}
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    reportCrash(details);
  };
}
