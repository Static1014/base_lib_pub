import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../util/common_utils.dart' as common_util;
import '../util/log_utils.dart';

/// Name: common_ext.dart
///
/// Created by Static4u
/// Date : 2023/4/12 15:21
extension CommonExt on Object {
  void logE({String tag = '', bool split = false, String? ansiColor}) {
    e(msg: toString(), tag: tag, split: split, ansiColor: ansiColor);
  }

  void logI({String tag = '', bool split = false, String? ansiColor}) {
    i(msg: toString(), tag: tag, split: split, ansiColor: ansiColor);
  }

  void logW({String tag = '', bool split = false, String? ansiColor}) {
    w(msg: toString(), tag: tag, split: split, ansiColor: ansiColor);
  }
}

extension GetMy on GetInterface {
  static DateTime? lastTime;
}

extension StringExt on String {
  bool isEmptyOrNull() => common_util.isEmptyOrNull(this);
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
}

extension ExtList on List<int> {
  String toStringData() {
    return String.fromCharCodes(Uint8List.fromList(this));
  }
}

extension GlobalKeyExt on GlobalKey {
  /// 获取当前key标记的Widget在屏幕上的位置
  Offset get curWidgetLocation {
    RenderBox rb = currentContext?.findRenderObject() as RenderBox;
    return rb.localToGlobal(Offset.zero);
  }

  /// 获取当前key标记的Widget的size
  Size get curWidgetSize {
    RenderBox rb = currentContext?.findRenderObject() as RenderBox;
    return rb.size;
  }
}
