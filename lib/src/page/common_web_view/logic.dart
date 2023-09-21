part of common_web_view;

class CommonWebViewLogic extends GetxController {
  final WebViewController webViewController = WebViewController();
  final _pb = 0.obs;
  final _type = WebViewContentType.url.obs;
  final _canGoBack = false.obs;
  final _canGoForward = false.obs;

  void _initWebViewController({
    bool clearCache = true,
    bool clearLocalStorage = true,
    void Function(String url)? onPageStarted,
    void Function(String url)? onPageFinished,
    FutureOr<NavigationDecision> Function(NavigationRequest request)? onNavigationRequest,
    void Function(WebResourceError error)? onWebResourceError,
    String? userAgent,
  }) {
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(userAgent)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (progress) {
              _pb(progress);
            },
            onPageStarted: (url) {
              onPageStarted?.call(url);
            },
            onPageFinished: (url) {
              _checkBottomState();
              onPageFinished?.call(url);
            },
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
            onUrlChange: (url) {
              _checkBottomState();
            }),
      );
    if (clearCache) {
      webViewController.clearCache();
    }
    if (clearLocalStorage) {
      webViewController.clearLocalStorage();
    }
  }

  void _checkBottomState() {
    webViewController.canGoBack().then((v) {
      _canGoBack(v);
    });
    webViewController.canGoForward().then((v) {
      _canGoForward(v);
    });
  }

  void _load(
    String urlOrData,
    WebViewContentType type, {
    LoadRequestMethod method = LoadRequestMethod.get,
    Map<String, String> headers = const <String, String>{},
    Uint8List? body,
  }) {
    _type(type);
    switch (_type.value) {
      case WebViewContentType.url:
        webViewController.loadRequest(
          Uri.parse(urlOrData),
          method: method,
          headers: headers,
          body: body,
        );
        break;
      case WebViewContentType.htmlString:
        webViewController.loadHtmlString(urlOrData);
        break;
      case WebViewContentType.file:
        webViewController.loadFile(urlOrData);
        break;
      case WebViewContentType.asset:
        webViewController.loadFlutterAsset(urlOrData);
        break;
    }
  }
}
