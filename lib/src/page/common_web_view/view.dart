library common_web_view;

import 'dart:async';
import 'dart:typed_data';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub/src/util/url_launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'logic.dart';

enum WebViewContentType {
  url, // 远程地址
  htmlString, // html字符串
  file, // 本地文件
  asset, // 项目资源
}

/// CommonWebViewPage创建回调，用于返回当前WebViewController
/// 注意：此时WebView还未绘制，只能设置WebViewController参数，无法load
typedef OnCommonWebViewPageCreate = void Function(WebViewController logic);

class CommonWebViewPage extends StatelessWidget {
  /// 启动
  static void start(
    String urlOrData, {
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
    String? userAgent,
    LoadRequestMethod method = LoadRequestMethod.get,
    Map<String, String> headers = const <String, String>{},
    Uint8List? body,
    OnCommonWebViewPageCreate? onCommonWebViewPageCreate,
  }) {
    Nav.to(
      () => CommonWebViewPage(
        urlOrData,
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
      ),
      tag: tag,
      preventDuplicates: singleTop,
      transition: transition,
      binding: BindingsBuilder(() {
        Get.put(CommonWebViewLogic(), tag: tag);
      }),
    );
  }

  final OnCommonWebViewPageCreate? onCommonWebViewPageCreate;
  final String? tag;
  final String? title;
  final String urlOrData;
  final WebViewContentType type;

  final bool popConfirm; // 关闭是否需要确认
  final WillPopCallback? onPopConfirm; // 关闭确认回调
  // 启动时是否清空缓存
  final bool clearCacheOnStart;
  final bool clearLocalStorageOnStart;

  final void Function(String url)? onPageStarted;
  final void Function(String url)? onPageFinished;
  final FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest;
  final void Function(WebResourceError error)? onWebResourceError;
  final String? userAgent;

  final LoadRequestMethod method;
  final Map<String, String> headers;
  final Uint8List? body;

  CommonWebViewPage(
    this.urlOrData, {
    this.type = WebViewContentType.url,
    Key? key,
    this.tag,
    this.title,
    this.popConfirm = false,
    this.onPopConfirm,
    this.onPageStarted,
    this.onPageFinished,
    this.clearCacheOnStart = true,
    this.clearLocalStorageOnStart = true,
    this.onNavigationRequest,
    this.onWebResourceError,
    this.userAgent,
    this.body,
    this.method = LoadRequestMethod.get,
    this.headers = const <String, String>{},
    this.onCommonWebViewPageCreate,
  }) : super(key: key) {
    final logic = Get.find<CommonWebViewLogic>(tag: tag);
    logic._initWebViewController(
      clearCache: clearCacheOnStart,
      clearLocalStorage: clearLocalStorageOnStart,
      onPageFinished: onPageFinished,
      onNavigationRequest: onNavigationRequest,
      onWebResourceError: onWebResourceError,
      userAgent: userAgent,
    );
    onCommonWebViewPageCreate?.call(logic.webViewController);
  }

  final double bottomHeight = 40;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CommonWebViewLogic>(tag: tag);

    onBuildFinished((duration) {
      logic
          // .._initWebViewController(
          //   clearCache: clearCacheOnStart,
          //   clearLocalStorage: clearLocalStorageOnStart,
          //   onPageFinished: onPageFinished,
          //   onNavigationRequest: onNavigationRequest,
          //   onWebResourceError: onWebResourceError,
          // )
          // .._load(urlOrData, type);
          ._load(
        urlOrData,
        type,
        method: method,
        headers: headers,
        body: body,
      );
    });
    return mRoot(
      onWillPop: _buildPopConfirm(),
      child: Scaffold(
        appBar: mAppBar(
          title: title ?? '',
          backPressed: _buildPopConfirm(),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              bottom: bottomHeight,
              child: WebViewWidget(
                controller: logic.webViewController,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Obx(
                () => logic._pb.value < 100
                    ? LinearProgressIndicator(
                        value: logic._pb.value < 10 ? null : double.parse('${logic._pb.value}'),
                        backgroundColor: BaseColors.cGrayBg,
                        valueColor: const AlwaysStoppedAnimation(BaseColors.cPrimaryColor),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNavigator(logic),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigator(CommonWebViewLogic logic) {
    return Container(
      height: bottomHeight,
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => _buildBottomAction(
              Icons.arrow_back_ios_new_rounded,
              logic._canGoBack.value ? BaseColors.cFontBlack : BaseColors.cFontGrayLight,
              () {
                logic.webViewController.canGoBack().then((value) {
                  logic.webViewController.goBack();
                });
              },
            ),
          ),
          mDividerH(width: 8),
          Obx(
            () => _buildBottomAction(
              Icons.arrow_forward_ios_rounded,
              logic._canGoForward.value ? BaseColors.cFontBlack : BaseColors.cFontGrayLight,
              () {
                logic.webViewController.canGoForward().then((value) {
                  logic.webViewController.goForward();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(IconData icon, Color? color, Callback onClick) {
    return mInkView(
      borderRadius: BorderRadius.circular(12),
      onClick: onClick,
      child: SizedBox(
        width: 100,
        height: bottomHeight,
        child: Icon(
          icon,
          size: 16,
          weight: 100,
          color: color,
        ),
      ),
    );
  }

  WillPopCallback _buildPopConfirm() {
    MDialog? confirmDialog;
    return popConfirm
        ? (onPopConfirm ??
            () async {
              confirmDialog = mShowTip(
                msg: BaseTrs.closePageConfirmTip.tr,
                actions: MDialog.doubleActions(rightCallback: () {
                  confirmDialog?.hide(onClosed: () {
                    Nav.pop();
                  });
                }),
              );
              return false;
            })
        : clickBack;
  }
}
