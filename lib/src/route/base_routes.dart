import 'package:get/get.dart';

import '../page/test/view.dart';

/// Name: base_routes.dart
///
/// Created by Static4u
/// Date : 2023/4/12 15:46
class BaseRoutes {
  // 基础测试页
  static const test = '/test';
  // 图片预览页
  static const imgPreview = '/imgPreview';

  static List<GetPage> basePages = [
    GetPage(name: test, page: () => TestPage()),
  ];
}
