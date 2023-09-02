import 'package:get/get.dart';

import '../../route/nav.dart';

class ImagePreviewLogic extends GetxController {
  static ImagePreviewLogic get to => Get.find();

  final curIndex = 0.obs;
  final imgList = [].obs;
  final isSliding = false.obs;

  void deleteAt(int index) {
    if (index >= 0 && index < imgList.length) {
      imgList.removeAt(index);
    }

    if (imgList.isEmpty) {
      close();
    }
  }

  void close() {
    Nav.pop();
  }
}
