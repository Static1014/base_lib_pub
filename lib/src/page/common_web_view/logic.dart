part of common_web_view;

class CommonWebViewLogic extends GetxController {
  final WebViewController webViewController = WebViewController();
  final _pb = 0.obs;
  final _type = WebViewContentType.url.obs;
  final _canGoBack = false.obs;
  final _canGoForward = false.obs;
  final _bottomNavEnable = true.obs;
  final _bottomNavVisible = false.obs;

  void _checkBottomNavState() async {
    _canGoBack(await webViewController.canGoBack());
    _canGoForward(await webViewController.canGoForward());
    setBottomNav(_canGoBack.value || _canGoForward.value);
  }

  void setBottomNav(bool visible) {
    if (_bottomNavEnable.value) {
      _bottomNavVisible(visible);
    }
  }

  void toggleBottomNav() {
    if (_bottomNavEnable.value) {
      _bottomNavVisible(!_bottomNavVisible.value);
    }
  }
}
