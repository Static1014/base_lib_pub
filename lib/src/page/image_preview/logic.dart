part of 'view.dart';

class ImagePreviewLogic extends GetxController {
  static ImagePreviewLogic get to => Get.find();

  late ExtendedPageController _epc;
  final _curIndex = 0.obs;
  final _imgList = [].obs;
  final _isSliding = false.obs;
  OnPreviewIndexChanged? onPreviewIndexChanged;

  void _initPageController(int initialPage) {
    _epc = ExtendedPageController(initialPage: initialPage);
    _curIndex(initialPage);
  }

  void deleteAt(int index) {
    int oldLen = _imgList.length;
    if (index >= 0 && index < oldLen) {
      _imgList.removeAt(index);

      if (_imgList.length == 1) {
        _curIndex(0);
      }
      if (_curIndex.value >= _imgList.length) {
        _curIndex(max(0, _imgList.length - 1));
      }

      onPreviewIndexChanged?.call(_curIndex.value);
    }

    if (_imgList.isEmpty) {
      _close();
    }
  }

  void _close() {
    Nav.pop();
  }
}
