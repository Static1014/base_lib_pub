import 'dart:async';
import 'dart:typed_data';

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

  Future<dynamic>? push(String routeName, {dynamic args, bool singleTop = true}) {
    return Get.toNamed(routeName, arguments: args, preventDuplicates: singleTop);
  }

  void pop({dynamic result, bool closeOverlays = false}) {
    Get.back(result: result, closeOverlays: closeOverlays);
  }

  Future<dynamic>? replace(String routeName, {dynamic args, bool singleTop = true}) {
    return Get.offNamed(routeName, arguments: args, preventDuplicates: singleTop);
  }

  bool isPopEnable() {
    var routeName = Get.routing.route?.settings.name;
    return !(_unPopRoutes.contains(routeName));
  }

//  bool isPbShowing() {
//   return Get.rawRoute?.settings.name == BaseRoutes.pb;
// }

  /// 图片预览
  Future<dynamic>? startImagePreview<T>({
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
    String? tag,
    Transition? transition = Transition.fadeIn,
    bool fullscreenDialog = false, // 当前页面是否是以全屏弹框的方式展示，当是时，手势滑出将无效
    bool showIndicator = true,
    TextViewBuilder? textBuilder,
  }) {
    if (imgList.isEmpty) {
      toast(BaseTrs.previewListEmpty.tr);
      return null;
    }
    return to<T>(
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
        tag: tag,
        showIndicator: showIndicator,
        textBuilder: textBuilder,
      ),
      opaque: pageOpaque,
      routeName: BaseRoutes.imgPreview,
      preventDuplicates: singleTop,
      transition: transition,
      tag: tag,
      fullscreenDialog: fullscreenDialog,
      binding: BindingsBuilder(() {
        Get.put(ImagePreviewLogic(), tag: tag);
      }),
    );
  }

  /// 启动通用WebView
  Future<dynamic>? startCommonWebView<T>({
    required String urlOrData,
    bool singleTop = false,
    String? tag,
    String? title,
    bool popConfirm = false,
    PopInvokedCallback? onPopConfirm,
    bool clearCache = true,
    bool clearLocalStorage = true,
    void Function(String url)? onPageStarted,
    void Function(String url)? onPageFinished,
    FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest,
    void Function(WebResourceError error)? onWebResourceError,
    Transition? transition,
    String? userAgent,
    LoadRequestMethod method = LoadRequestMethod.get,
    Map<String, String> headers = const <String, String>{},
    Uint8List? body,
    OnCommonWebViewPageCreate? onCommonWebViewPageCreate,
    bool fullscreenDialog = false, // 当前页面是否是以全屏弹框的方式展示，当是时，手势滑出将无效
    MAppBarBuilder? appBarBuilder,
    WebPageBuilder? pageBuilder,
    Color? pbBgColor,
    Color? pbColor,
    bool? bottomNavEnable,
  }) {
    return to<T>(
      () => CommonWebViewPage(
        urlOrData: urlOrData,
        tag: tag,
        title: title,
        popConfirm: popConfirm,
        onPopConfirm: onPopConfirm,
        clearCacheOnStart: clearCache,
        clearLocalStorageOnStart: clearLocalStorage,
        onPageStarted: onPageStarted,
        onPageFinished: onPageFinished,
        onNavigationRequest: onNavigationRequest,
        onWebResourceError: onWebResourceError,
        userAgent: userAgent,
        method: method,
        headers: headers,
        body: body,
        onCommonWebViewPageCreate: onCommonWebViewPageCreate,
        appBarBuilder: appBarBuilder,
        pageBuilder: pageBuilder,
        pbBgColor: pbBgColor,
        pbColor: pbColor,
        bottomNavEnable: bottomNavEnable,
      ),
      tag: tag,
      preventDuplicates: singleTop,
      transition: transition,
      fullscreenDialog: fullscreenDialog,
      binding: BindingsBuilder(() {
        Get.put(CommonWebViewLogic(), tag: tag);
      }),
    );
  }

  Future<dynamic>? to<T>(
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
    bool ok = preventDuplicates || ((tag?.isNotEmpty ?? false) && !Get.isRegistered(tag: tag));
    if (!ok) {
      var msg = BaseTrs.notSingleTopError.tr;
      toast(msg);
      msg.logE();
    }
    assert(ok, BaseTrs.notSingleTopError.tr);

    return Get.to<T>(
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
