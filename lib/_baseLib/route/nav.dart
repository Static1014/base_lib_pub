import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../page/image_preview/view.dart';
import '../route/base_routes.dart';

/// Name: nav.dart
///
/// Created by Static4u
/// Date : 2023/5/6 11:21
class Nav {
  static final List<String> _unPopRoutes = [];

  static void initUnPopRoutes(List<String> routes) {
    _unPopRoutes.addAll(routes);
  }

  static void push(String routeName, {dynamic args}) {
    Get.toNamed(routeName, arguments: args);
  }

  static void pop({dynamic result, bool closeOverlays = false}) {
    Get.back(result: result, closeOverlays: closeOverlays);
  }

  static void replace(String routeName, {dynamic args}) {
    Get.offNamed(routeName, arguments: args);
  }

  static bool isPopEnable() {
    var routeName = Get.routing.route?.settings.name;
    return !(_unPopRoutes.contains(routeName));
  }

// static bool isPbShowing() {
//   return Get.rawRoute?.settings.name == BaseRoutes.pb;
// }

  /// 图片预览
  static void startImagePreview({
    required List<String> imgList,
    int defaultIndex = 0,
    Widget? bottomView,
    bool enableTapImgClose = true,
    bool enableHeroTag = true,
    bool enableSlideOutPage = true,
    bool closeBtnVisible = true,
    List<String>? tagList,
    Color? pageBgColor,
    Color? bgColor,
    EdgeInsets? pagePadding,
    Decoration? pageDecoration,
    bool pageOpaque = false, // 页面背景不透明
    double bgOpacityBase = 1.0,
    bool splitBottomView = false,
  }) {
    Get.to(
      () => ImagePreviewPage(
        imgList: imgList,
        defaultIndex: defaultIndex,
        bottomView: bottomView,
        enableTapImgClose: enableTapImgClose,
        enableHeroTag: enableHeroTag,
        heroTags: tagList,
        enableSlideOutPage: enableSlideOutPage,
        closeBtnVisible: closeBtnVisible,
        imgBgColor: bgColor,
        pagePadding: pagePadding,
        pageDecoration: pageDecoration,
        imgBgOpacityBase: bgOpacityBase,
        pageBgColor: pageBgColor,
        splitBottomView: splitBottomView,
      ),
      opaque: pageOpaque,
      routeName: BaseRoutes.imgPreview,
    );
  }
}
