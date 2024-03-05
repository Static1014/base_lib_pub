import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Name: common_utils.dart
///
/// Created by Static4u
/// Date : 2023/4/12 15:31

/// 延迟执行
void doDelay(int milliSec, VoidCallback callback) {
  doDelayOn(Duration(milliseconds: milliSec), callback);
}

/// 延迟执行
void doDelayOn(Duration delay, VoidCallback callback) {
  Future.delayed(delay, callback);
}

/// 定时循环执行
Timer doInterval(
  Duration interval,
  void Function(Timer? timer) callback, {
  // 启动时调用一次
  bool callOnStart = false,
}) {
  if (callOnStart) {
    callback(null);
  }
  return Timer.periodic(interval, callback);
}

/// 字符串判空
bool isEmptyOrNull(String? str) => (GetUtils.isNullOrBlank(str) ?? true) || str == 'null';

/// 隐藏软键盘
void hideKeyboard() {
  FocusScope.of(Get.context!).requestFocus(FocusNode());
}

/// 点击返回
Future<bool> clickBack({dynamic result}) async {
  hideKeyboard();

  if (Nav.isPopEnable()) {
    // 能返回直接返回上一页
    Nav.pop();
    return false;
  } else {
    // 不能返回
    if (MyGet.lastTime == null || DateTime.now().difference(MyGet.lastTime!) > const Duration(seconds: 1)) {
      //   // 一秒之内点击两次返回键，提示再次点击退出
      MyGet.lastTime = DateTime.now();
      toast(BaseTrs.exitOnDoubleClick.tr);
      return false;
    }
    exitApp();
    return true;
  }
}

/// 退出APP
void exitApp({bool force = false}) async {
  _beforeExit();
  if (force) {
    exit(0);
  } else {
    await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
}

void _beforeExit() {
  for (var value in MyGet.actionsBeforeExitApp) {
    value();
  }
}

/// 清除所有getx控制器
void clearAllGetxControllers() {
  Get.deleteAll(force: true);
}

/// 计算行数
int getRowCount(int length, int lengthPerRow) {
  int count = (length / lengthPerRow).floor() + (length % lengthPerRow == 0 ? 0 : 1);
  // logI(msg: "getRowCount: $count");
  return count;
}

bool isEmail(String str) {
  if (isEmptyOrNull(str)) return false;
  return RegExp(GlobalConst.regexpStrEmail).hasMatch(str);
}

/// 获取屏幕宽度
double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// 获取屏幕高度
double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

/// 获取状态栏高度
double getStatusBarHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// 获取屏幕尺寸
Size getScreenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

/// 比较年月日
bool compareYMD(DateTime d1, DateTime d2) {
  return d1.year != d2.year || d1.month != d2.month || d1.day != d2.day;
}

/// 获取随机数[0, max)
int randomNum(int max) {
  var ran = Random();
  return ran.nextInt(max);
}

/// 日期时间格式化
String mFormatDate({
  DateTime? time,
  List<String>? format,
  String daySeparator = '-',
  String middleSeparator = ' ',
  String timeSeparator = ':',
  String milliSeparator = '-',
  bool milliSecond = false,
}) {
  time ??= DateTime.now();
  format ??= [
    yyyy,
    daySeparator,
    mm,
    daySeparator,
    dd,
    middleSeparator,
    HH,
    timeSeparator,
    nn,
    timeSeparator,
    ss,
    if (milliSecond) ...[milliSeparator, SSS]
  ];
  return formatDate(time, format);
}

/// 日期时间格式化
String mFormatDateFromStamp({
  required int stamp,
  List<String>? format,
  String daySeparator = '-',
  String middleSeparator = ' ',
  String timeSeparator = ':',
  String milliSeparator = '-',
  bool milliSecond = false,
}) {
  DateTime time = DateTime.fromMillisecondsSinceEpoch(stamp);
  return mFormatDate(
    time: time,
    format: format,
    daySeparator: daySeparator,
    middleSeparator: middleSeparator,
    timeSeparator: timeSeparator,
    milliSeparator: milliSeparator,
    milliSecond: milliSecond,
  );
}

/// 货币格式
String formatMoney(double num) {
  /// 先保留两位小数
  String numStr = num.toStringAsFixed(2);
  String result = "";

  List list = numStr.split(".");
  String pre = list[0];
  String suf = list[1];

  if (pre.length <= 3) {
    return "$pre.$suf";
  }
  int pf = pre.length % 3;
  final int pff = pf;
  for (int i = 0; i < pre.length; i++) {
    result += pre[i];
    if (pf > 0) {
      pf--;
      if (pf == 0) {
        result += ",";
      }
    } else {
      if ((i - pff) % 3 == 2 && i != pre.length - 1) {
        result += ",";
      }
    }
  }

  result += ".$suf";

  return result;
}

/// 货币格式
String formatIntMoney(int num) {
  String pre = num.toString();
  if (pre.length <= 3) {
    return pre;
  }

  String result = "";

  int pf = pre.length % 3;
  final int pff = pf;
  for (int i = 0; i < pre.length; i++) {
    result += pre[i];
    if (pf > 0) {
      pf--;
      if (pf == 0) {
        result += ",";
      }
    } else {
      if ((i - pff) % 3 == 2 && i != pre.length - 1) {
        result += ",";
      }
    }
  }

  return result;
}

void _vibrate() {
  SystemChannels.platform.invokeMethod('HapticFeedback.vibrate');
}

// 振动
Timer? vibrate({
  int times = 1,
  Duration interval = const Duration(milliseconds: 100),
}) {
  // 需要权限
  // <uses-permission android:name="android.permission.VIBRATE"/>
  if (times > 1) {
    // 多次
    int count = 0;
    return doInterval(interval, callOnStart: true, (timer) {
      if (count >= times) {
        timer?.cancel();
      }
      _vibrate();
      count++;
    });
  } else {
    _vibrate();
    return null;
  }
}
