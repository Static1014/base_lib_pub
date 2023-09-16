import 'package:get/get.dart';

/// Name: base_routes.dart
///
/// Created by Static4u
/// Date : 2023/4/12 15:46

// ignore: non_constant_identifier_names
final BaseRoutes = BaseRoutesClass();

class BaseRoutesClass {
  /// 图片预览页
  /// Nav.startImagePreview(...)跳转，
  final imgPreview = '/imgPreview_base';

  /// 通用webView，加载通用html url
  final commonWebView = '/commonWebView_base';

  /// 基础路由
  final List<GetPage> basePages = [];
}
