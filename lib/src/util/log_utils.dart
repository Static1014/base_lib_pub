import 'package:base_lib_pub/base_lib_pub.dart';

/// 通过转义字符改变日志颜色
const ansiColorRed = "\x1b[31m";
const ansiColorGreen = "\x1b[32m";
const ansiColorYellow = "\x1b[33m";
const ansiColorBlue = "\x1b[34m";
const ansiColorMagenta = "\x1b[35m";
const ansiColorCyan = "\x1b[36m";

/// 重置
const ansiColorReset = "\x1b[0m";
const bool colorful = false;

/// 日志开关
bool isForceLog = false;

/// 打印错误日志
void e({required dynamic msg, String tag = '', bool split = false, String? ansiColor}) {
  if (isForceLog) {
    printLog("E", msg, tag: tag, split: split, ansiColor: ansiColor);
  }
}

/// 打印信息日志
void i({required dynamic msg, String tag = '', bool split = false, String? ansiColor}) {
  if (isForceLog) {
    printLog("I", msg, tag: tag, split: split, ansiColor: ansiColor);
  }
}

/// 打印警告日志
void w({required dynamic msg, String tag = '', bool split = false, String? ansiColor}) {
  if (isForceLog) {
    printLog("W", msg, tag: tag, split: split, ansiColor: ansiColor);
  }
}

/// NSLog日志格式
void printLog(String type, dynamic msg, {String tag = "", bool split = false, String? ansiColor}) {
  // 时间补齐
  var time = DateTime.now().toFormatString();
  // if (time.length < 26) {
  //   time = "$time${"0" * (26 - time.length)}";
  // }

  // var log = "$time($type) ${tag.isNotEmpty ? "[$tag]" : ""} ==> $msg";
  var log = "[$type]$time ${tag.isNotEmpty ? "[$tag]" : ""}=>$msg";
  var color = ansiColorReset;
  var reset = ansiColorReset;
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
  if (!colorful) {
    color = "";
    reset = "";
  }
  try {
    if (split) {
      int maxLen = 800;
      while (log.length > 800) {
        print("$color${log.substring(0, maxLen)}$reset");
        log = log.substring(maxLen);
      }
      print("$color$log$reset");
    } else {
      print("$color$log$reset");
    }
  } catch (e) {
    print("$color$e$reset");
  }
}
