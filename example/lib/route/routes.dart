import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get.dart';

import '../page/home/view.dart';

/// Name: routes.dart
///
/// Created by Static4u
/// Date : 2023/4/12 10:53
class Routes extends BaseRoutes {
  /// 初始路由
  static const init = '/';

  /// 所有路由别名必须以‘/’开头
  static const home = '/home';

  static List<GetPage> getPages() {
    var list = [
      GetPage(name: init, page: () => HomePage()),
      GetPage(name: home, transition: Transition.fade, page: () => HomePage()),
    ];
    list.addAll(BaseRoutes.basePages);
    return list;
  }
}
