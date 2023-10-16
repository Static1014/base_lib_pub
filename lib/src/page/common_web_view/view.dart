library common_web_view;

import 'dart:async';
import 'dart:typed_data';

import 'package:base_lib_pub/base_lib_pub.dart';
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

/// 自定义页面布局
typedef WebPageBuilder = Widget Function(CommonWebViewLogic logic, Widget webViewWithNav, Widget pb);

class CommonWebViewPage extends StatelessWidget {
  /// 启动通用WebView，参照lib/route/nav.startCommonWebView().

  final OnCommonWebViewPageCreate? onCommonWebViewPageCreate;
  final String? tag;
  final String? title;
  final String urlOrData;
  final WebViewContentType type;
  final bool? bottomNavEnable;

  /// 不能直接传入mAppBar，它会在创建page之前被创建，此时还不能pop，所以不会正常显示返回按钮
  final MAppBarBuilder? appBarBuilder;

  /// 当pageBuilder不为空，popConfirm、onPopConfirm、appBar、title会忽略
  final WebPageBuilder? pageBuilder;

  final bool popConfirm; // 关闭是否需要确认
  final WillPopCallback? onPopConfirm; // 关闭确认回调
  // 启动时是否清空缓存
  final bool clearCacheOnStart;
  final bool clearLocalStorageOnStart;

  final void Function(int progress)? onProgress;
  final void Function(String url)? onPageStarted;
  final void Function(String url)? onPageFinished;
  final FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest;
  final void Function(WebResourceError error)? onWebResourceError;
  final String? userAgent;

  final LoadRequestMethod method;
  final Map<String, String> headers;
  final Uint8List? body;

  final Color? pbBgColor;
  final Color? pbColor;

  CommonWebViewPage({
    required this.urlOrData,
    this.type = WebViewContentType.url,
    Key? key,
    this.tag,
    this.title,
    this.popConfirm = false,
    this.onPopConfirm,
    this.onProgress,
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
    this.appBarBuilder,
    this.pageBuilder,
    this.pbBgColor,
    this.pbColor,
    this.bottomNavEnable = true,
  }) : super(key: key) {
    final logic = Get.find<CommonWebViewLogic>(tag: tag);
    logic._bottomNavEnable(bottomNavEnable);
    logic.webViewController.init(
      clearCache: clearCacheOnStart,
      clearLocalStorage: clearLocalStorageOnStart,
      userAgent: userAgent,
      onPageStarted: onPageStarted,
      onProgress: (progress) {
        logic._pb(progress);
        onProgress?.call(progress);
      },
      onPageFinished: (url) {
        logic._checkBottomNavState();
        onPageFinished?.call(url);
      },
      onWebResourceError: onWebResourceError,
      onNavigationRequest: onNavigationRequest,
      onUrlChange: (url) {
        logic._checkBottomNavState();
      },
    );
    onCommonWebViewPageCreate?.call(logic.webViewController);

    if (urlOrData.isEmptyOrNull()) {
      'CommonWebViewPage\' url or data is empty or null, check?'.logE(tag: 'CommonWebViewPage');
    }
  }

  final double bottomHeight = 40;

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CommonWebViewLogic>(tag: tag);

    onBuildFinished((duration) {
      logic._type(type);
      logic.webViewController.load(
        urlOrData: urlOrData,
        type: type,
        method: method,
        headers: headers,
        body: body,
      );
    });
    return pageBuilder?.call(logic, _buildWebViewWithNav(logic), _buildPb(logic)) ??
        mRoot(
          onWillPop: _buildPopConfirm(),
          child: Scaffold(
            appBar: appBarBuilder?.call() ??
                mAppBar(
                  title: title ?? '',
                  backPressed: _buildPopConfirm(),
                ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: _buildWebViewWithNav(logic),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _buildPb(logic),
                ),
              ],
            ),
          ),
        );
  }

  Widget _buildWebViewWithNav(CommonWebViewLogic logic) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: WebViewWidget(
            controller: logic.webViewController,
          ),
        ),
        Obx(() => logic._bottomNavEnable.value && logic._bottomNavVisible.value ? _buildBottomNavigator(logic) : const SizedBox.shrink()),
      ],
    );
  }

  Widget _buildPb(CommonWebViewLogic logic) {
    return Obx(
      () => logic._pb.value < 100
          ? LinearProgressIndicator(
              value: logic._pb.value < 10 ? null : double.parse('${logic._pb.value}'),
              backgroundColor: pbBgColor ?? BaseColors.cGrayBg,
              valueColor: AlwaysStoppedAnimation(pbColor ?? BaseColors.cPrimaryColor),
            )
          : const SizedBox.shrink(),
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

  WillPopCallback? _buildPopConfirm() {
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
        : null;
  }
}
