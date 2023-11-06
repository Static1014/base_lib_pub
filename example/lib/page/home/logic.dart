import 'dart:async';

import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class HomeLogic extends GetxController {
  final tick = 0.obs;
  Timer? timer;

  final list = [false, false, false, false].obs;
  final index = 0.obs;

  final pkgInfo = ''.obs;
  final deviceInfo = ''.obs;
  final displayName = ''.obs;
  final slideOne = false.obs;
  final pickUrl = ''.obs;
  AssetEntity? pickEntity;
}
