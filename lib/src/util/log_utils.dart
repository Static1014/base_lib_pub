import 'dart:developer' as developer;
import 'dart:io';
import 'dart:isolate';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get_core/src/get_main.dart';

// ignore: non_constant_identifier_names
final LogUtils = _LogUtils();

class _LogUtils {
  /// 通过转义字符改变日志颜色
  final ansiColorRed = "\x1B[31m";
  final ansiColorGreen = "\x1B[32m";
  final ansiColorYellow = "\x1B[33m";
  final ansiColorBlue = "\x1B[34m";
  final ansiColorMagenta = "\x1B[35m";
  final ansiColorCyan = "\x1B[36m";

  /// 重置
  final ansiColorReset = "\x1B[0m";
  bool _colorful = true;
  bool _tagId = false;

  /// 日志开关
  bool _isForceLog = false;

  /// 初始化日志
  /// @param enable 是否开启日志
  /// @param colorful 是否根据日志级别显示彩色日志
  /// @param tagId 是否在tag中显示当前进程、线程hashCode
  void initLog({
    bool enable = false,
    bool colorful = true,
    bool tagId = false,
  }) {
    _isForceLog = enable;
    _colorful = colorful;
    _tagId = tagId;
    Get.isLogEnable = enable;
  }

  /// 打印错误日志
  void e({required dynamic msg, String tag = '', bool split = false, String? ansiColor}) {
    if (_isForceLog) {
      printLog("E", msg, tag: tag, split: split, ansiColor: ansiColor);
    }
  }

  /// 打印信息日志
  void i({required dynamic msg, String tag = '', bool split = false, String? ansiColor}) {
    if (_isForceLog) {
      printLog("I", msg, tag: tag, split: split, ansiColor: ansiColor);
    }
  }

  /// 打印警告日志
  void w({required dynamic msg, String tag = '', bool split = false, String? ansiColor}) {
    if (_isForceLog) {
      printLog("W", msg, tag: tag, split: split, ansiColor: ansiColor);
    }
  }

  /// NSLog日志格式
  void printLog(String type, dynamic msg, {String tag = "", bool split = false, String? ansiColor}) {
    // 时间补齐
    var time = DateTime.now().toFormatString(milliSecond: true);
    // if (time.length < 26) {
    //   time = "$time${"0" * (26 - time.length)}";
    // }

    // var log = "$time($type) ${tag.isNotEmpty ? "[$tag]" : ""} ==> $msg";
    // var log = "[$type]$time ${tag.isNotEmpty ? "[$tag]" : ""}=>$msg";
    var log = "$msg";
    var name = ' $type $time${tag.isNotEmpty ? " tag: $tag" : ""}${_tagId ? ' ${Process.run.hashCode}-${Isolate.current.hashCode}' : ''}';
    var color = ansiColorReset;
    switch (type) {
      case "E":
        color = ansiColorRed;
        break;
      case "I":
        color = ansiColorCyan;
        break;
      case "W":
        color = ansiColorYellow;
        break;
    }
    if (ansiColor != null && ansiColor.isNotEmpty) {
      color = ansiColor;
    }
    if (!_colorful) {
      color = "";
    }
    try {
      if (split) {
        int maxLen = 800;
        while (log.length > maxLen) {
          realLog(log.substring(0, maxLen), name, color);
          log = log.substring(maxLen);
        }
        realLog(log, name, color);
      } else {
        realLog(log, name, color);
      }
    } catch (e) {
      realLog('$e', name, color);
    }
  }

  void realLog(String msg, String name, String ansiColor) async {
    if (ansiColor.isNotEmpty) {
      developer.log(_color(msg, ansiColor), name: _color(name, ansiColor));
    } else {
      developer.log(msg, name: name);
    }
  }

  String _color(String msg, String ansiColor) {
    return '$ansiColor$msg$ansiColorReset';
  }
}
