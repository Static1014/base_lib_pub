import 'dart:async';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:permission_handler/permission_handler.dart';

/// Name: permission_utils.dart
///
/// Created by Static4u
/// Date : 2023/7/11 14:35

/// 检测权限
Future<bool> checkPermission({required Permission permission}) async {
  var name = permission.toString();

  var status = await permission.status;
  var granted = isGranted(status);

  '$name 授权状态：$granted}'.logI(tag: 'Permission');
  return granted;
}

MDialog? _requestDialog, _requestFailedDialog;

/// 请求权限
Future<bool> requestPermission({
  required Permission permission,
  String? requestMsg,
  String? failedMsg,
}) async {
  var status = await permission.status;
  var granted = isGranted(status);
  if (granted) {
    // 已授权直接回调
    return true;
  }

  /// 将Callback转Future
  Completer<bool> completer = Completer();

  /// 未授权，先弹框提示请求权限理由
  _requestDialog = mShowTip(
    msg: requestMsg ?? parsePermissionTip(permission),
    dismissible: false,
    actions: MDialog.doubleActions(
      leftBtnText: BaseTrs.cancel.tr,
      leftCallback: () {
        _requestDialog?.hide();
        completer.complete(false);
      },
      leftColor: BaseColors.cFontGrayLight,
      rightBtnText: BaseTrs.startAuthPermission.tr,
      rightCallback: () async {
        _requestDialog?.hide();
        var name = permission.toString();
        var status = await permission.status;
        '$name 未授权状态：$status}'.logI(tag: 'Permission');

        if (status.isPermanentlyDenied || status.isRestricted) {
          /// 永久拒绝、无法授权
          DeviceUtils.goAppSetting();
          completer.complete(false);
        } else {
          /// 开始授权
          status = await permission.onDeniedCallback(() {
            // 已授权
            '$name 已授权'.logI(tag: 'Permission');
          }).onProvisionalCallback(() {
            // 授权，临时，Only supported on iOS (iOS12+)
            '$name iOS临时授权'.logI(tag: 'Permission');
          }).onLimitedCallback(() {
            // 授权，限制，Only supported on iOS (iOS14+)
            '$name iOS限制授权'.logI(tag: 'Permission');
          }).onRestrictedCallback(() {
            // 拒绝，Only supported on iOS
            '$name iOS拒绝授权'.logI(tag: 'Permission');
          }).onDeniedCallback(() {
            // 拒绝
            '$name 拒绝'.logI(tag: 'Permission');
          }).onPermanentlyDeniedCallback(() {
            // 永久拒绝
            '$name 永久拒绝'.logI(tag: 'Permission');
          }).request();
          if (isGranted(status)) {
            // 授权成功，开始回调
            completer.complete(true);
          } else {
            // 授权失败，重新弹框
            requestPermissionFailed(permission: permission, failedMsg: failedMsg);
            completer.complete(false);
          }
        }
      },
    ),
  );
  return completer.future;
}

/// 授权失败，开始弹框提示并提供手动授权选择
void requestPermissionFailed({required Permission permission, String? failedMsg}) {
  _requestFailedDialog = mShowTip(
    msg: failedMsg ?? BaseTrs.permissionTipFailed.tr,
    dismissible: false,
    actions: MDialog.doubleActions(
      leftBtnText: BaseTrs.cancel.tr,
      leftCallback: () {
        _requestFailedDialog?.hide();
      },
      leftColor: BaseColors.cFontGrayLight,
      rightBtnText: BaseTrs.manuallyAuthPermission.tr,
      rightCallback: () async {
        _requestFailedDialog?.hide();

        /// 授权失败，开始手动授权
        DeviceUtils.goAppSetting();
      },
    ),
  );
}

/// 根据权限自动匹配提示文字
String parsePermissionTip(Permission permission) => switch (permission) {
      Permission.storage => BaseTrs.permissionTipStorage.tr,
      Permission.camera => BaseTrs.permissionTipCamera.tr,
      _ => BaseTrs.permissionTipDefault.tr,
    };

/// 判断授权状态是否已授权
bool isGranted(PermissionStatus status) {
  if (!status.isGranted && !status.isProvisional && !status.isLimited) {
    // 未授权
    return false;
  } else {
    // 已授权
    return true;
  }
}

Future<bool> checkStoragePermission() => checkPermission(permission: Permission.storage);
