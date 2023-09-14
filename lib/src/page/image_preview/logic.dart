part of image_preview;

class ImagePreviewLogic extends GetxController {
  late ExtendedPageController _epc;
  final _curIndex = 0.obs;
  final _imgList = [].obs;
  final _isSliding = false.obs;

  void _initPageController(int initialPage) {
    _epc = ExtendedPageController(initialPage: initialPage);
    _curIndex(initialPage);
  }

  void deleteAt(int index) {
    if (index >= 0 && index < _imgList.length) {
      _imgList.removeAt(index);
    }

    if (_imgList.isEmpty) {
      _close();
    }
  }

  void _close() {
    Nav.pop();
  }
}
