import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../base_lib_pub.dart';

/// Name: share_utils.dart
///
/// Created by Static4u
/// Date : 2023/7/19 15:12

// 分享文本
void shareStr(String msg) {
  if (msg.isEmptyOrNull()) {
    toast(BaseTrs.shareEmpty.tr);
    return;
  }
  Share.share(msg);
}

// 分享本地文件
void shareLocalFile(String path, {String? msg}) async {
  if (path.isEmptyOrNull()) {
    toast(BaseTrs.shareEmpty.tr);
    return;
  }

  var file = File(path);
  if (!(await file.exists())) {
    toast(BaseTrs.shareNoFile.tr);
    return;
  }

  Share.shareXFiles([XFile(path)], text: msg);
}

// 分享本地文件
void shareLocalData(Uint8List? data, {String? msg}) async {
  if (data != null) {
    Share.shareXFiles([XFile.fromData(data)], text: msg);
  } else {
    toast(BaseTrs.shareEmpty.tr);
  }
}
