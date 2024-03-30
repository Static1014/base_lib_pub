import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../../base_lib_pub.dart';

/// Name: m_dialog.dart
///
/// Created by Static4u
/// Date : 2023/8/8 15:54

class MDialogManager {
  static List<MDialog> dialogList = [];

  static bool hideDialogById(String id) {
    var dList = dialogList.where((element) => element.id == id).toList();
    if (dList.isEmpty) {
      return false;
    }
    for (var dialog in dList) {
      if (dialog.isFake) {
        dialog.hide();
      }
    }
    return true;
  }

  static bool showDialog(MDialog dialog, {BuildContext? overlayContext}) {
    if (dialog.isFake) {
      return false;
    }

    var dList = dialogList.where((element) => element.id == dialog.id).toList();
    if (dList.isEmpty) {
      // 没有同id的对话框
      _add(dialog, overlayContext: overlayContext);
      return true;
    } else {
      // 有同id的对话框，先关闭
      for (var element in dList) {
        element.hide();
      }
      // 再添加新的
      _add(dialog, overlayContext: overlayContext);
    }
    return false;
  }

  static void _add(MDialog dialog, {BuildContext? overlayContext}) {
    dialogList.add(dialog);
    var overlayState = Overlay.of(overlayContext ?? Get.overlayContext!);
    overlayState.insert(dialog._entry);
    dialog.animMixin.animController.forward().whenComplete(() {
      dialog.onOpened?.call();
    });
  }

  static bool hideDialog(MDialog dialog, {bool anim = true}) {
    if (dialog.isFake) {
      return false;
    }
    int index = dialogList.indexOf(dialog);
    if (index >= 0) {
      if (anim) {
        dialog.animMixin.animController.reverse().whenComplete(() {
          _remove(dialog);
        });
      } else {
        _remove(dialog);
      }
      return true;
    }
    return false;
  }

  static void _remove(MDialog dialog) {
    dialog._entry.remove();
    dialogList.remove(dialog);
    dialog.onClosed?.call();
    dialog.animMixin.dispose();
  }

  static bool isVisible(MDialog dialog) {
    return !dialog.isFake && dialogList.contains(dialog);
  }
}

typedef MDialogBuilder = Widget Function(BuildContext context, AnimationController animationController);

class MDialog {
  late OverlayEntry _entry;
  bool dismissible = false;
  Widget? child;
  String? id;
  bool isFake = false;
  late GetxAnimationControllerMixin animMixin;
  VoidCallback? onOpened;
  VoidCallback? onClosed;

  bool get isVisible => MDialogManager.isVisible(this);

  void _init({Duration? duration}) {
    animMixin = GetxAnimationControllerMixin(animDuration: duration ?? const Duration(milliseconds: 240));

    if (isEmptyOrNull(id)) {
      id = UniqueKey().toString();
    }
  }

  MDialog.fake() {
    _init();
    isFake = true;
  }

  MDialog show({BuildContext? overlayContext, Callback? onOpened}) {
    this.onOpened = onOpened;
    MDialogManager.showDialog(this, overlayContext: overlayContext);
    return this;
  }

  MDialog hide({
    Callback? onClosed,
    bool anim = true,
  }) {
    this.onClosed = onClosed;
    MDialogManager.hideDialog(this, anim: anim);
    return this;
  }

  /// 完全自定义
  MDialog.builder({
    required MDialogBuilder builder,
    this.id,
    Duration? duration,
  }) {
    _init(duration: duration);
    _entry = OverlayEntry(builder: (ctx) {
      return builder(ctx, animMixin.animController);
    });
  }

  /// 自定义带动画
  MDialog.simpleAnimate({
    required Widget child,
    this.id,
    Duration? duration,
    this.dismissible = true,
  }) {
    _init(duration: duration);

    _entry = OverlayEntry(
      builder: (ctx) => FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animMixin.animController,
            curve: const Interval(0, 1, curve: Curves.easeOutCubic),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            if (dismissible) {
              hide();
            }
          },
          child: Container(
            color: BaseColors.cBlackTrans,
            child: ScaleTransition(
                scale: Tween<double>(begin: 0, end: 1).animate(
                  CurvedAnimation(
                    parent: animMixin.animController,
                    curve: const Interval(0, 1, curve: Curves.easeOutCubic),
                  ),
                ),
                child: child),
          ),
        ),
      ),
    );
  }

  MDialog.tip({
    this.dismissible = true,
    this.id,
    String title = '',
    Color titleColor = BaseColors.cFontBlack,
    double titleFontSize = 16,
    FontWeight titleFontWeight = FontWeight.bold,
    int titleMaxLines = 4,
    String msg = '',
    Widget? titleWidget,
    Widget? contentWidget,
    Color msgColor = BaseColors.cFontGray,
    double msgFontSize = 15,
    FontWeight msgFontWeight = FontWeight.normal,
    TextAlign msgTextAlign = TextAlign.start,
    List<Widget>? actions,
    double? maxContentSize,
    double? minContentSize,
    EdgeInsets msgPadding = EdgeInsets.zero,
  }) {
    _init();
    _entry = OverlayEntry(
      builder: (ctx) => FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animMixin.animController,
            curve: const Interval(0, 1, curve: Curves.easeOutCubic),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            if (dismissible) {
              hide();
            }
          },
          child: Container(
            color: BaseColors.cBlackTrans,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  parent: animMixin.animController,
                  curve: const Interval(0, 1, curve: Curves.easeOutCubic),
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: BaseColors.cWhite,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 6),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleWidget ??
                                (isEmptyOrNull(title)
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: mText(
                                          title,
                                          color: titleColor,
                                          weight: titleFontWeight,
                                          maxLines: titleMaxLines,
                                          fontSize: titleFontSize,
                                          textAlign: TextAlign.start,
                                        ),
                                      )),
                            contentWidget ??
                                mOverSizeScrollView(
                                  maxSize: maxContentSize ?? Get.height * 0.6,
                                  minSize: minContentSize ?? 0,
                                  children: [
                                    Padding(
                                      padding: msgPadding,
                                      child: mText(
                                        msg,
                                        color: msgColor,
                                        fontSize: msgFontSize,
                                        weight: msgFontWeight,
                                        textAlign: msgTextAlign,
                                      ),
                                    ),
                                  ],
                                ),
                            mDividerH(height: 4),
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.end,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: actions ??
                                    [
                                      TextButton(
                                        onPressed: () {
                                          hide();
                                        },
                                        child: Text(BaseTrs.confirm.tr),
                                      ),
                                    ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 常用的两按钮
  static List<Widget> doubleActions({
    String? leftBtnText,
    String? leftBtnSemanticsLabel,
    Color? leftColor,
    Callback? leftCallback,
    String? rightBtnText,
    String? rightBtnSemanticsLabel,
    Color? rightColor,
    Callback? rightCallback,
    TextStyle? leftStyle,
    TextStyle? rightStyle,
    double? leftFontSize,
    double? rightFontSize,
    FontWeight? leftFontWeight,
    FontWeight? rightFontWeight,
  }) {
    return [
      TextButton(
        onPressed: leftCallback,
        child: Text(
          leftBtnText ?? BaseTrs.cancel.tr,
          semanticsLabel: leftBtnSemanticsLabel,
          style: leftStyle ??
              TextStyle(
                color: leftColor,
                fontSize: leftFontSize,
                fontWeight: leftFontWeight,
              ),
        ),
      ),
      TextButton(
        onPressed: rightCallback,
        child: Text(
          semanticsLabel: rightBtnSemanticsLabel,
          rightBtnText ?? BaseTrs.confirm.tr,
          style: rightStyle ??
              TextStyle(
                color: rightColor,
                fontSize: rightFontSize,
                fontWeight: rightFontWeight,
              ),
        ),
      ),
    ];
  }
}
