import 'package:flutter/animation.dart';
import 'package:get/get.dart';

/// Name: getx_animation_controller_mixin.dart
///
/// Created by Static4u
/// Date : 2023/8/13 13:19
class GetxAnimationControllerMixin extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animController;
  Duration? animDuration;

  GetxAnimationControllerMixin({this.animDuration}) {
    animController = AnimationController(
      vsync: this,
      duration: animDuration ?? const Duration(milliseconds: 300),
    );
  }

  @override
  void onClose() {
    animController.dispose();
    super.onClose();
  }
}
