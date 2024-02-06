import 'dart:math';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: overlay_utils.dart
///
/// Created by Static4u
/// Date : 2023/4/12 17:36

var defaultLoadingSize = min(Get.width / 3, 160).roundToDouble();

enum ToastLevel {
  normal, // 灰底白字
  info, // 绿底白字
  warn, // 黄底白字
  error // 红底白字
}

TransitionBuilder toastBuilder = BotToastInit();
NavigatorObserver toastObserver = BotToastNavigatorObserver();

void toast(
  String msg, {
  Duration duration = const Duration(seconds: 2),
  bool onlyOne = false,
  Color bgColor = BaseColors.cGray, // level == ToastLevel.normal时才有效
  Color textColor = BaseColors.cFontWhite,
  EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
  TextStyle? textStyle,
  ToastLevel level = ToastLevel.normal,
  AlignmentGeometry align = const Alignment(0, 0.9),
  bool crossPage = true,
}) {
  switch (level) {
    case ToastLevel.info:
      bgColor = BaseColors.cGreen;
      break;
    case ToastLevel.warn:
      bgColor = BaseColors.cYellow;
      break;
    case ToastLevel.error:
      bgColor = BaseColors.cRed;
      break;
    case ToastLevel.normal:
      break;
  }

  BotToast.showText(
    text: msg,
    duration: duration,
    onlyOne: onlyOne,
    backgroundColor: BaseColors.cTransparent,
    // 页面背景，toast是一个透明的全页面
    contentColor: bgColor,
    textStyle: textStyle ?? TextStyle(fontSize: 14.5, color: textColor),
    contentPadding: padding,
    align: align,
    crossPage: crossPage,
  );
}

void notify(String msg, {String title = '', int durationInSec = 2}) {
  bool isOnlyMsg = title.isEmptyOrNull();
  BotToast.showSimpleNotification(
      title: isOnlyMsg ? msg : title,
      subTitle: isOnlyMsg ? null : msg,
      align: const Alignment(0, -0.9),
      duration: Duration(seconds: durationInSec),
      hideCloseButton: true);
}

typedef LoadingBuilder = Widget Function(VoidCallback hide);

/// 显示加载中
/// @param: msg 消息
/// @param: onClose 关闭方法回调
/// @return: 关闭方法
CancelFunc showLoading({
  VoidCallback? onClose,
  String? msg,
  Color msgColor = Colors.white,
  TextAlign msgAlign = TextAlign.center,
  int msgMaxLines = 2,
  TextOverflow msgOverflow = TextOverflow.ellipsis,
  TextStyle? msgStyle,
  double msgFontSize = 14,
  double pbSize = 36,
  Color pbColor = BaseColors.cWhite,
  double? contentWidth,
  double? contentHeight,
  EdgeInsets contentPadding = const EdgeInsets.all(12),
  EdgeInsets msgPadding = const EdgeInsets.fromLTRB(8, 20, 8, 4),
  double contentCornerRadius = 8,
  Color contentBgColor = Colors.black54,
  LoadingBuilder? builder,
}) {
  return BotToast.showCustomLoading(
    backButtonBehavior: BackButtonBehavior.ignore, // 拦截返回按钮点击
    onClose: onClose,
    toastBuilder: (func) {
      return builder != null
          ? builder.call(func)
          : Container(
              padding: contentPadding,
              alignment: Alignment.center,
              width: contentWidth ?? defaultLoadingSize,
              height: contentHeight ?? defaultLoadingSize,
              decoration: BoxDecoration(
                color: contentBgColor,
                borderRadius: BorderRadius.all(Radius.circular(contentCornerRadius)),
              ),
              child: Column(
                children: [
                  mProgressIndicator(size: pbSize, color: pbColor),
                  isEmptyOrNull(msg)
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: msgPadding,
                          child: Text(
                            msg ?? '',
                            textAlign: msgAlign,
                            maxLines: msgMaxLines,
                            overflow: msgOverflow,
                            style: msgStyle ?? TextStyle(color: msgColor, fontSize: msgFontSize),
                          ),
                        ),
                ],
              ),
            );
    },
  );
}

MDialog mShowDialog(Widget child, {String? id}) {
  return MDialog.builder(builder: (ctx, controller) => child, id: id)..show();
}

MDialog mShowTip({
  String? id,
  String title = '',
  String msg = '',
  bool dismissible = true,
  List<Widget>? actions,
  double? maxContentSize,
  Color titleColor = BaseColors.cFontBlack,
  double titleFontSize = 16,
  FontWeight titleFontWeight = FontWeight.bold,
  int titleMaxLines = 4,
  Color msgColor = BaseColors.cFontGray,
  double msgFontSize = 15,
  FontWeight msgFontWeight = FontWeight.normal,
  TextAlign msgTextAlign = TextAlign.start,
  double? minContentSize,
  Widget? contentWidget,
  Widget? titleWidget,
  EdgeInsets msgPadding = EdgeInsets.zero,
}) {
  return MDialog.tip(
    id: id,
    dismissible: dismissible,
    title: title,
    titleWidget: titleWidget,
    msg: msg,
    contentWidget: contentWidget,
    actions: actions,
    maxContentSize: maxContentSize,
    minContentSize: minContentSize,
    msgTextAlign: msgTextAlign,
    msgFontWeight: msgFontWeight,
    msgFontSize: msgFontSize,
    msgColor: msgColor,
    titleMaxLines: titleMaxLines,
    titleFontWeight: titleFontWeight,
    titleFontSize: titleFontSize,
    titleColor: titleColor,
    msgPadding: msgPadding,
  )..show();
}

// Get.bottomSheet(
//   Container(
//     clipBehavior: Clip.antiAlias,
//     decoration: const BoxDecoration(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(12),
//         topRight: Radius.circular(12),
//       ),
//       color: MyColors.cWhite,
//     ),
//     child: Wrap(
//       crossAxisAlignment: WrapCrossAlignment.center,
//       children: <Widget>[
//         Container(
//           height: GlobalConst.appBarHeight,
//           // color: MyColors.cYellow,
//           alignment: Alignment.center,
//           width: getScreenWidth(Get.context!),
//           child: mText(
//             msg: Trs.titleAdd.tr,
//             textAlign: TextAlign.center,
//             weight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         mLine(),
//         ListTile(
//             leading: const Icon(Icons.camera),
//             title: Text(Trs.btnAddImageFromRemote.tr),
//             onTap: () {
//               // 网络图片
//               logic.startAddNewPostItem(PostItemType.image, isNetwork: true);
//             }),
//         ListTile(
//             leading: const Icon(Icons.image_outlined),
//             title: Text(Trs.btnAddImageFromLocal.tr),
//             onTap: () {
//               // 本地图片（拍照）
//               logic.startAddNewPostItem(PostItemType.image);
//             }),
//         ListTile(
//             leading: const Icon(Icons.text_fields_outlined),
//             title: Text(Trs.btnAddText.tr),
//             onTap: () {
//               // 文本
//               logic.startAddNewPostItem(PostItemType.text);
//             }),
//       ],
//     ),
//   ),
//   barrierColor: MyColors.cBlackTrans,
// );
