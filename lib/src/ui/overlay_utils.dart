import 'dart:math';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: overlay_utils.dart
///
/// Created by Static4u
/// Date : 2023/4/12 17:36

var loadingSize = min(Get.width / 3, 160).roundToDouble();

enum ToastLevel {
  normal, // 白底黑字
  info, // 绿底白字
  warn, // 黄底白字
  error // 红底白字
}

TransitionBuilder toastBuilder = BotToastInit();
NavigatorObserver toastObserver = BotToastNavigatorObserver();

void toast(String msg, {int durationInSec = 2}) {
  BotToast.showText(text: msg, duration: Duration(seconds: durationInSec));
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

/// 显示加载中
/// @param: msg 消息
/// @param: onClose 关闭方法回调
/// @return: 关闭方法
CancelFunc showLoading(
  String msg, {
  VoidCallback? onClose,
  double pbSize = 36,
  Color pbColor = BaseColors.cWhite,
}) {
  return BotToast.showCustomLoading(
    backButtonBehavior: BackButtonBehavior.ignore, // 拦截返回按钮点击
    onClose: onClose,
    toastBuilder: (func) {
      return Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        width: loadingSize,
        height: loadingSize,
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            mProgressIndicator(size: pbSize, color: pbColor),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 4),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
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
  bool dismissible = true,
  String title = '',
  String msg = '',
  String? id,
  List<Widget>? actions,
}) {
  return MDialog.tip(
    id: id,
    dismissible: dismissible,
    title: title,
    msg: msg,
    actions: actions,
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
