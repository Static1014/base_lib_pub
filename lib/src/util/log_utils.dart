import 'dart:io';
import 'dart:isolate';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

// ignore: non_constant_identifier_names
final LogUtils = _LogUtils();
const _typeError = 'E';
const _typeInfo = 'I';
const _typeWarn = 'W';

class _LogUtils {
  /// 通过转义字符改变日志颜色
  final ansiColorRed = "\x1B[31m"; // error
  final ansiColorGreen = "\x1B[32m";
  final ansiColorYellow = "\x1B[33m"; // warning
  final ansiColorBlue = "\x1B[34m"; // tag
  final ansiColorMagenta = "\x1B[35m";
  final ansiColorCyan = "\x1B[36m"; // info
  // 重置控制台日志颜色
  final ansiColorReset = "\x1B[0m";

  // 超过一定数量的日志无法在控制台完整打印，需要截断，
  int _maxLen = 900;

  // 是否根据日志等级使用不同颜色
  bool _colorful = true;

  // 是否在日志tag中打印进程/线程hashCode
  bool _logPid = false;
  String _logId = '';

  /// 日志开关
  bool _isForceLog = false;

  /// 初始化日志
  /// @param enable 是否开启日志
  /// @param colorful 是否根据日志级别显示彩色日志
  /// @param tagId 是否在tag中显示当前进程、线程hashCode
  void initLog({
    bool enable = false,
    bool getLogEnable = false,
    bool colorful = true,
    bool tagId = false,
    String logId = 'CCLog',
    int maxPerLine = 800,
  }) {
    _isForceLog = enable;
    _colorful = colorful;
    _logPid = tagId;
    _logId = logId;
    _maxLen = maxPerLine;
    Get.isLogEnable = enable && getLogEnable;
  }

  /// 打印错误日志
  void e({required dynamic msg, String tag = '', bool split = true, String? ansiColor}) {
    if (_isForceLog) {
      printLog(_typeError, msg, tag: tag, split: split, ansiColor: ansiColor);
    }
  }

  /// 打印信息日志
  void i({required dynamic msg, String tag = '', bool split = true, String? ansiColor}) {
    if (_isForceLog) {
      printLog(_typeInfo, msg, tag: tag, split: split, ansiColor: ansiColor);
    }
  }

  /// 打印警告日志
  void w({required dynamic msg, String tag = '', bool split = true, String? ansiColor}) {
    if (_isForceLog) {
      printLog(_typeWarn, msg, tag: tag, split: split, ansiColor: ansiColor);
    }
  }

  /// NSLog日志格式
  void printLog(String type, dynamic msg, {String tag = "", bool split = true, String? ansiColor}) {
    var time = DateTime.now().toFormatString(milliSecond: true);
    var log = "$msg";
    var fullTag = '$_logId<$type> $time${tag.isNotEmpty ? " tag<$tag>" : ""}${_logPid ? ' ${Process.run.hashCode}-${Isolate.current.hashCode}' : ''}';
    String? color;
    if (_colorful) {
      if (ansiColor != null && ansiColor.isNotEmpty) {
        color = ansiColor;
      } else {
        switch (type) {
          case _typeError:
            color = ansiColorRed;
            break;
          case _typeInfo:
            color = ansiColorCyan;
            break;
          case _typeWarn:
            color = ansiColorYellow;
            break;
        }
      }
    }
    try {
      if (split) {
        final maxLine = _maxLen - fullTag.length - 10;
        String? groupId;
        if (log.length > maxLine) {
          groupId = _createGroupId();
        }
        while (log.length > maxLine) {
          realLog(log.substring(0, maxLine), fullTag, ansiColor: color, groupId: groupId);
          log = log.substring(maxLine);
        }
        realLog(log, fullTag, ansiColor: color, groupId: groupId);
      } else {
        realLog(log, fullTag, ansiColor: color);
      }
    } catch (e) {
      realLog('$e', fullTag, ansiColor: color);
    }
  }

  void realLog(String msg, String tag, {String? ansiColor, String? groupId}) async {
    // 日志内容中如果带换行，print会自动重起一行打印，会导致丢失日志等级颜色
    List<String> msgList = msg.split('\n');
    if (groupId == null && msgList.length > 1) {
      groupId = _createGroupId();
    }

    // 如果一条日志被切割成多条，自动生成groupId以方便识别哪些是一组
    final groupSuffix = groupId == null ? '' : ' $groupId';
    // tag中自动去除换行
    tag = '[$tag$groupSuffix] '.replaceAll('\n', '');
    for (var i = 0; i < msgList.length; i++) {
      final element = msgList[i];
      if (ansiColor != null && ansiColor.isNotEmpty) {
        _log('${_color(tag, ansiColorBlue)}${_color(element, ansiColor)}');
      } else {
        _log('$tag$element');
      }
    }
  }

  void _log(String msg) {
    // ! developer.log内部实现是异步的，会导致日志打印顺序错乱
    // ignore: avoid_print
    print(msg);
  }

  String _createGroupId() => UniqueKey().hashCode.toString();

  String _color(String msg, String ansiColor) {
    return '$ansiColor$msg$ansiColorReset';
  }
}
