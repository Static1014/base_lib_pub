import 'dart:async';
import 'dart:io';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';

import 'const/api.dart';
import 'trans/lang.dart';

/// Name: main_logic.dart
///
/// Created by Static4u
/// Date : 2023/8/24 14:12
class MainLogic extends GetxController {
  static MainLogic get to => Get.find();

  void requestUpdate() async {
    var hide = showLoading(msg: Trs.checkUpdateLoading.tr);

    sleep(const Duration(seconds: 2));
    hide();
  }

  void goUpdate() {
    /// 浏览器打开下载页
    Api.pathDownload.launch();
  }

  /// 隐私协议
  Future<dynamic>? goPrivacy(BuildContext context) {
    return Nav.startCommonWebView(
      urlOrData: Api.pathPrivacy,
      clearCache: false,
      tag: 'privacy',
      appBarBuilder: () => mAppBar(
        title: Trs.privacy.tr,
      ),
      bottomNavEnable: false,
      pbColor: Theme.of(context).primaryColor,
    );
  }

  /// 应用首页/下载页
  Future<dynamic>? goHomeSite() {
    // 使用浏览器打开主页，以方便进行下载
    return Api.pathDownload.launch();
  }

  void shareApp() {
    shareStr('${Trs.appName.tr}: ${Api.pathDownload}');
  }
}
