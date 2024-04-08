import 'dart:convert';

import 'package:base_lib_pub/src/util/url_launcher/url_launcher_utils.dart';
import 'package:flutter/material.dart';

import '../util/common_utils.dart' as common_util;
import '../util/log_utils.dart';

/// Name: common_ext.dart
///
/// Created by Static4u
/// Date : 2023/4/12 15:21
extension CommonExt on Object {
  void logE({String tag = '', bool split = true, String? ansiColor}) {
    LogUtils.e(msg: toString(), tag: tag, split: split, ansiColor: ansiColor);
  }

  void logI({String tag = '', bool split = true, String? ansiColor}) {
    LogUtils.i(msg: toString(), tag: tag, split: split, ansiColor: ansiColor);
  }

  void logW({String tag = '', bool split = true, String? ansiColor}) {
    LogUtils.w(msg: toString(), tag: tag, split: split, ansiColor: ansiColor);
  }
}

extension StringExt on String {
  /// 字符串判空
  bool isEmptyOrNull() => common_util.isEmptyOrNull(this);

  /// 在url中传中文时需要进行中文转码
  String encodeUrl({Encoding encoding = utf8}) {
    return Uri.encodeQueryComponent(this, encoding: encoding);
  }

  /// 是否是schemeUrl，需要通过url_launcher打开第三方app
  bool get isSchemeUrl => !startsWith('http://') && !startsWith('https://');

  /// 通过url_launcher启动（在浏览器中打开），如果无法启动，返回false
  Future<bool> launch() async {
    return launchMyUrl(this);
  }
}

extension ScrollControllerExt on ScrollController {
  /// 滚动到底部
  void scrollToBottom({int milliseconds = 300, Curve curve = Curves.easeIn}) {
    animateTo(
      position.maxScrollExtent,
      duration: Duration(milliseconds: milliseconds),
      curve: curve,
    );
  }

  /// 滚动到顶部
  void scrollToTop({int milliseconds = 300, Curve curve = Curves.easeIn}) {
    animateTo(
      0,
      duration: Duration(milliseconds: milliseconds),
      curve: curve,
    );
  }

  /// 如果在顶部，滚动到底部；否则滚动到顶部
  void toggleScroll({int milliseconds = 300, Curve curve = Curves.easeIn}) {
    if (offset == 0) {
      scrollToBottom(milliseconds: milliseconds, curve: curve);
    } else {
      scrollToTop(milliseconds: milliseconds, curve: curve);
    }
  }

  /// 在滚动轴上晃动一次
  void shake({
    double? beginOffset,
    double shakeOffset = 100,
    Duration duration = const Duration(milliseconds: 600),
    Curve curve = Curves.easeOutCubic,
  }) {
    beginOffset ??= offset;
    animateTo(beginOffset + shakeOffset, duration: duration, curve: curve).then((value) {
      animateTo(beginOffset ?? offset, duration: duration, curve: curve).then((value) {});
    });
  }
}
