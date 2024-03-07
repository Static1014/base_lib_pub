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

  static bool hideDialogById(String id, {Callback? onClosed}) {
    var rDialog = dialogList.firstWhereOrNull((element) => element.id == id);
    if (rDialog == null || rDialog.isFake) {
      return false;
    }

    rDialog.hide(onClosed: onClosed);
    return true;
  }

  static bool showDialog(MDialog dialog, {BuildContext? overlayContext, Callback? onOpened}) {
    var d = dialogList.firstWhereOrNull((element) => element.id == dialog.id);
    if (d == null) {
      dialogList.add(dialog);
      var overlayState = Overlay.of(overlayContext ?? Get.overlayContext!);
      dialog.animController.controller.clearListeners();
      dialog.animController.controller.addListener(() {
        overlayState.setState(() {});
      });
      overlayState.insert(dialog._entry);
      dialog.animController.controller.forward().whenComplete(() {
        onOpened?.call();
      });
      return true;
    }
    return false;
  }

  static bool hideDialog(MDialog dialog, {Callback? onClosed}) {
    var d = dialogList.firstWhereOrNull((element) => element.id == dialog.id);
    if (d != null) {
      dialog.animController.controller.reverse().whenComplete(() {
        dialog._entry.remove();
        // dialog.animController.controller.dispose();
        dialogList.remove(dialog);
        onClosed?.call();
      });
      return true;
    }
    return false;
  }

  static bool isVisible(MDialog dialog) {
    return dialogList.contains(dialog);
  }
}

typedef MDialogBuilder = Widget Function(BuildContext context, AnimationController animationController);
typedef MDialogActionCallback = bool Function();

class MDialog {
  late OverlayEntry _entry;
  bool dismissible = false;
  Widget? child;
  String? id;
  bool isFake = false;
  late GetxAnimationControllerMixin animController;

  bool get isVisible => MDialogManager.isVisible(this);

  void _init({Duration? duration}) {
    animController = GetxAnimationControllerMixin(animDuration: duration ?? const Duration(milliseconds: 240));

    if (isEmptyOrNull(id)) {
      id = UniqueKey().toString();
    }
  }

  MDialog.fake() {
    _init();
    isFake = true;
  }

  /// 完全自定义
  MDialog.builder({required MDialogBuilder builder, this.id, Duration? duration}) {
    _init(duration: duration);
    _entry = OverlayEntry(builder: (ctx) {
      return builder(ctx, animController.controller);
    });
  }

  /// 自定义带动画
  MDialog.simpleAnimate({required Widget child, this.id, Duration? duration}) {
    _init(duration: duration);
    _entry = OverlayEntry(
      builder: (ctx) => FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animController.controller,
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
                    parent: animController.controller,
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
            parent: animController.controller,
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
                  parent: animController.controller,
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
                                          msg: title,
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
                                        msg: msg,
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

  MDialog show({BuildContext? overlayContext, Callback? onOpened}) {
    MDialogManager.showDialog(this, overlayContext: overlayContext, onOpened: onOpened);
    return this;
  }

  MDialog hide({Callback? onClosed}) {
    MDialogManager.hideDialog(this, onClosed: onClosed);
    return this;
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
