import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub_example/page/test/logic.dart';
import 'package:base_lib_pub_example/page/test/view.dart';
import 'package:base_lib_pub_example/route/routes.dart';
import 'package:get/get.dart';

/// Name: nav_ext.dart
///
/// Created by Static4u
/// Date : 2023/9/15 00:21
extension NavExt on NavClass {
  void startTest({
    bool singleTop = true,
    String? tag,
  }) {
    Nav.to(
      () => TestPage(tag: tag),
      routeName: Routes.test,
      binding: BindingsBuilder(() {
        Get.put(TestLogic(), tag: tag);
      }),
      tag: tag,
      preventDuplicates: singleTop,
    );
  }
}
