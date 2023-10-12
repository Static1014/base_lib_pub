import 'dart:math';

import 'package:get/get.dart';

/// Name: num_ext.dart
///
/// Created by Static4u
/// Date : 2023/10/12 21:47
extension NumExt on num {
  /// 转换为px单位
  double toPx() {
    return this * Get.pixelRatio;
  }

  /// 度数转换为角度，比如180° = pi， 90° = pi/2
  double toAngle() {
    return this * pi / 180;
  }
}
