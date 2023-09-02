import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../translation/lang.dart';
import '../ui/dialog/overlay_utils.dart';

/// Name: permission_utils.dart
///
/// Created by Static4u
/// Date : 2023/7/11 14:35

typedef OnPermissionCheck = void Function(bool granted);

// 检测权限
Future<bool> checkPermission({required Permission permission, OnPermissionCheck? onPermissionCheck}) async {
  var status = await permission.status;
  if (!status.isGranted) {
    var permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      onPermissionCheck?.call(true);
      return true;
    } else {
      toast(BaseTrs.permissionTipStorage.tr);
      onPermissionCheck?.call(false);
      return false;
    }
  }

  onPermissionCheck?.call(true);
  return true;
}

Future<bool> checkStoragePermission({OnPermissionCheck? onPermissionCheck}) =>
    checkPermission(permission: Permission.storage, onPermissionCheck: onPermissionCheck);
