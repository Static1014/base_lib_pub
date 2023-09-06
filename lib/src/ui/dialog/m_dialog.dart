import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../theme/base_colors.dart';
import '../../translation/lang.dart';
import '../../ui/common_ui.dart';
import '../../util/common_utils.dart';
import '../../util/getx_animation_controller_mixin.dart';

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

  MDialog.builder({required MDialogBuilder builder, this.id, Duration? duration}) {
    _init(duration: duration);
    _entry = OverlayEntry(builder: (ctx) {
      return builder(ctx, animController.controller);
    });
  }

  MDialog.tip({
    this.dismissible = true,
    this.id,
    String title = '',
    String msg = '',
    List<Widget>? actions,
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
              scale: Tween<double>(begin: 0.3, end: 1).animate(
                CurvedAnimation(
                  parent: animController.controller,
                  curve: const Interval(0.2, 1, curve: Curves.easeOutCubic),
                ),
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxHeight: Get.height * 0.8),
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: BaseColors.cWhite,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 6),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isEmptyOrNull(title)
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: mText(
                                        msg: title,
                                        color: BaseColors.cFontBlack,
                                        weight: FontWeight.bold,
                                        fontSize: 16,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                              mText(
                                msg: msg,
                                color: BaseColors.cFontGray,
                                fontSize: 15,
                                textAlign: TextAlign.start,
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
                                          child: Text(baseTrs.confirm.tr),
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
    Color? leftColor,
    Callback? leftCallback,
    String? rightBtnText,
    Color? rightColor,
    Callback? rightCallback,
  }) {
    return [
      TextButton(
        onPressed: leftCallback,
        child: Text(
          leftBtnText ?? baseTrs.cancel.tr,
          style: TextStyle(color: leftColor),
        ),
      ),
      TextButton(
        onPressed: rightCallback,
        child: Text(
          rightBtnText ?? baseTrs.confirm.tr,
          style: TextStyle(color: rightColor),
        ),
      ),
    ];
  }
}
