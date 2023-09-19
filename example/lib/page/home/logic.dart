import 'dart:async';

import 'package:get/get.dart';

class HomeLogic extends GetxController {
  final tick = 0.obs;
  Timer? timer;

  final list = [false, false].obs;
  final index = 0.obs;

  final pkgInfo = ''.obs;
  final deviceInfo = ''.obs;
  final displayName = ''.obs;
}
