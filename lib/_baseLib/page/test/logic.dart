import 'package:get/get.dart';
import '../../extension/common_ext.dart';

import 'state.dart';

class TestLogic extends GetxController {
  final tag = 'TestLogic';
  final TestState state = TestState();

  @override
  void onInit() {
    /// GetxController生命周期之onInit
    'onInit'.logI(tag: tag);
    super.onInit();
  }

  @override
  void onReady() {
    /// GetxController生命周期之onReady
    'onReady'.logI(tag: tag);
    super.onReady();
  }

  @override
  void onClose() {
    /// GetxController生命周期之onClose
    'onClose'.logI(tag: tag);
    super.onClose();
  }
}
