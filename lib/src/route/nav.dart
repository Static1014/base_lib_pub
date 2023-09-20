import 'dart:async';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Name: nav.dart
///
/// Created by Static4u
/// Date : 2023/5/6 11:21

// ignore: non_constant_identifier_names
final Nav = NavClass();

class NavClass {
  final List<String> _unPopRoutes = [];

  void initUnPopRoutes(List<String> routes) {
    _unPopRoutes.addAll(routes);
  }

  void push(String routeName, {dynamic args, bool singleTop = true}) {
    Get.toNamed(routeName, arguments: args, preventDuplicates: singleTop);
  }

  void pop({dynamic result, bool closeOverlays = false}) {
    Get.back(result: result, closeOverlays: closeOverlays);
  }

  void replace(String routeName, {dynamic args, bool singleTop = true}) {
    Get.offNamed(routeName, arguments: args, preventDuplicates: singleTop);
  }

  bool isPopEnable() {
    var routeName = Get.routing.route?.settings.name;
    return !(_unPopRoutes.contains(routeName));
  }

//  bool isPbShowing() {
//   return Get.rawRoute?.settings.name == BaseRoutes.pb;
// }

  /// 图片预览
  void startImagePreview({
    required List<String> imgList,
    List<(bool isText, Color? textColor, Color? textBgColor)?>? textTagList,
    int defaultIndex = 0,
    Widget? bottomView,
    Widget? actionView,
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
    OnPreviewIndexChanged? onPreviewIndexChanged,
    bool singleTop = true,
    Transition? transition = Transition.fadeIn,
  }) {
    Get.to(
      () => ImagePreviewPage(
        imgList: imgList,
        textTagList: textTagList,
        defaultIndex: defaultIndex,
        bottomView: bottomView,
        actionView: actionView,
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
        onPreviewIndexChanged: onPreviewIndexChanged,
      ),
      opaque: pageOpaque,
      routeName: BaseRoutes.imgPreview,
      preventDuplicates: singleTop,
      transition: transition,
    );
  }

  /// 启动通用WebView
  void startCommonWebView(
    String url, {
    bool singleTop = false,
    String? tag,
    String? title,
    bool popConfirm = false,
    WillPopCallback? onPopConfirm,
    bool clearCache = true,
    bool clearLocalStorage = true,
    void Function(String url)? onPageStarted,
    void Function(String url)? onPageFinished,
    FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest,
    void Function(WebResourceError error)? onWebResourceError,
    Transition? transition,
  }) {
    CommonWebViewPage.start(
      url,
      singleTop: singleTop,
      tag: tag,
      title: title,
      popConfirm: popConfirm,
      onPopConfirm: onPopConfirm,
      clearCache: clearCache,
      clearLocalStorage: clearLocalStorage,
      onPageStarted: onPageStarted,
      onPageFinished: onPageFinished,
      onNavigationRequest: onNavigationRequest,
      onWebResourceError: onWebResourceError,
      transition: transition,
    );
  }

  Future<T?>? to<T>(
    dynamic page, {
    bool? opaque,
    Transition? transition = Transition.rightToLeftWithFade,
    Curve? curve,
    Duration? duration,
    int? id,
    String? routeName,
    bool fullscreenDialog = false,
    dynamic arguments,
    Bindings? binding,
    bool preventDuplicates = true,
    String? tag,
    bool? popGesture,
    double Function(BuildContext context)? gestureWidth,
  }) {
    /// 当不是singleTop时，必须有tag，且tag不能重复
    assert(preventDuplicates || ((tag?.isNotEmpty ?? false) && !Get.isRegistered(tag: tag)));

    return Get.to(
      page,
      opaque: opaque,
      transition: transition,
      curve: curve,
      duration: duration,
      id: id,
      routeName: routeName,
      fullscreenDialog: fullscreenDialog,
      arguments: arguments,
      binding: binding,
      preventDuplicates: preventDuplicates,
      popGesture: popGesture,
      gestureWidth: gestureWidth,
    );
  }
}
