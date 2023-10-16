import 'dart:async';
import 'dart:typed_data';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Name: web_view_ext.dart
///
/// Created by Static4u
/// Date : 2023/9/25 17:33
extension WebViewControllerExt on WebViewController {
  /// 自定义初始化
  void init({
    bool enableJS = true,
    bool clearCache = true,
    bool clearLocalStorage = true,
    void Function(int progress)? onProgress,
    void Function(String url)? onPageStarted,
    void Function(String url)? onPageFinished,
    FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest,
    void Function(WebResourceError error)? onWebResourceError,
    void Function(UrlChange change)? onUrlChange,
    String? userAgent,
    NavigationDelegate? navigationDelegate,
  }) {
    this
      ..setJavaScriptMode(enableJS ? JavaScriptMode.unrestricted : JavaScriptMode.disabled)
      ..setUserAgent(userAgent)
      ..setNavigationDelegate(
        navigationDelegate ??
            NavigationDelegate(
                onProgress: onProgress,
                onPageStarted: (url) {
                  onPageStarted?.call(url);
                },
                onPageFinished: onPageFinished,
                onWebResourceError: (e) {
                  e.description.logE(tag: 'CommonWebView onWebResourceError');
                  onWebResourceError?.call(e);
                },
                onNavigationRequest: onNavigationRequest ??
                    (request) async {
                      // 默认拦截scheme并通过url_launcher启动
                      if (request.url.isSchemeUrl) {
                        bool suc = await request.url.launch();
                        if (!suc) {
                          mShowTip(title: '错误', msg: '未能打开url: ${request.url}');
                        }
                        return NavigationDecision.prevent;
                      }
                      return NavigationDecision.navigate;
                    },
                onUrlChange: onUrlChange),
      );
    if (clearCache) {
      this.clearCache();
    }
    if (clearLocalStorage) {
      this.clearLocalStorage();
    }
  }

  /// 加载内容
  void load({
    required String urlOrData,
    required WebViewContentType type,
    LoadRequestMethod method = LoadRequestMethod.get,
    Map<String, String> headers = const <String, String>{},
    Uint8List? body,
  }) {
    switch (type) {
      case WebViewContentType.url:
        'CommonWebViewPage.load url: $urlOrData'.logI();
        loadRequest(
          Uri.parse(urlOrData),
          method: method,
          headers: headers,
          body: body,
        );
        break;
      case WebViewContentType.htmlString:
        loadHtmlString(urlOrData);
        break;
      case WebViewContentType.file:
        loadFile(urlOrData);
        break;
      case WebViewContentType.asset:
        loadFlutterAsset(urlOrData);
        break;
    }
  }
}
