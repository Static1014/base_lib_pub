import 'package:flutter/material.dart';

extension GlobalNavigatorStateKeyExt on GlobalKey<NavigatorState> {
  /// Get the overlay context
  BuildContext? get overlayContext {
    BuildContext? overlay;
    currentState?.overlay?.context.visitChildElements((element) {
      overlay = element;
    });
    return overlay;
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
