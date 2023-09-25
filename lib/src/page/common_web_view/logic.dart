part of common_web_view;

class CommonWebViewLogic extends GetxController {
  final WebViewController webViewController = WebViewController();
  final _pb = 0.obs;
  final _type = WebViewContentType.url.obs;
  final _canGoBack = false.obs;
  final _canGoForward = false.obs;
  final _bottomNavVisible = true.obs;

  void _checkBottomNavState() {
    webViewController.canGoBack().then((v) {
      _canGoBack(v);
    });
    webViewController.canGoForward().then((v) {
      _canGoForward(v);
    });
  }

  void setBottomNav(bool visible) {
    _bottomNavVisible(visible);
  }
}
