import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get.dart';

/// Name: GetxExt.dart
///
/// Created by Static4u
/// Date : 2023/9/15 09:32

class _MyGetImpl extends GetInterface {
  /// 双击退出
  DateTime? lastTime;
}

// ignore: non_constant_identifier_names
final MyGet = _MyGetImpl();

extension GetExt on GetInterface {
  /// 当以非singleTop模式启动多个同一页面，必须使用不同tag的logic进行处理。
  /// 当需要从外部获取对应logic（页面关闭时可能已经销毁）时，需要先判断是否存在
  T? findLogic<T>({String? tag}) {
    bool isR = Get.isRegistered<T>(tag: tag);
    '$T${tag == null ? '' : '($tag)'} - $isR'.logE();
    if (isR) {
      return Get.find<T>(tag: tag);
    }
    return null;
  }
}
