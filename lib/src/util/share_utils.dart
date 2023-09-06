import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../extension/common_ext.dart';
import '../translation/lang.dart';
import '../ui/overlay_utils.dart';

/// Name: share_utils.dart
///
/// Created by Static4u
/// Date : 2023/7/19 15:12

// 分享文本
void shareStr(String msg) {
  if (msg.isEmptyOrNull()) {
    toast(baseTrs.shareEmpty.tr);
    return;
  }
  Share.share(msg);
}

// 分享本地文件
void shareLocalFile(String path, {String? msg}) async {
  if (path.isEmptyOrNull()) {
    toast(baseTrs.shareEmpty.tr);
    return;
  }

  var file = File(path);
  if (!(await file.exists())) {
    toast(baseTrs.shareNoFile.tr);
    return;
  }

  Share.shareXFiles([XFile(path)], text: msg);
}

// 分享本地文件
void shareLocalData(Uint8List? data, {String? msg}) async {
  if (data != null) {
    Share.shareXFiles([XFile.fromData(data)], text: msg);
  } else {
    toast(baseTrs.shareEmpty.tr);
  }
}
