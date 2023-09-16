import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get.dart';

import '../page/home/view.dart';

/// Name: routes.dart
///
/// Created by Static4u
/// Date : 2023/4/12 10:53
// ignore: non_constant_identifier_names
final Routes = MyRoutesClass();

class MyRoutesClass extends BaseRoutesClass {
  /// 初始路由
  final init = '/';

  /// 所有路由别名必须以‘/’开头
  final home = '/home';

  /// 基础测试页
  final test = '/test';

  @override
  List<GetPage> getPages() {
    return super.getPages()
      ..addAll([
        GetPage(name: Routes.init, page: () => HomePage()),
        GetPage(name: Routes.home, transition: Transition.fade, page: () => HomePage()),
      ]);
  }
}
