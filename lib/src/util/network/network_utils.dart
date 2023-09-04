import 'package:base_lib_pub/src/util/network/api_log_interceptor.dart';
import 'package:dio/dio.dart';

/// Name: network_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/4 16:58

/// 全局dio实例
late Dio globalDio;

/// 配置dio
void initDio({
  String baseUrl = '',
  Duration connectTimeout = const Duration(seconds: 5),
  Duration? receiveTimeout = const Duration(seconds: 30),
  bool isAddLogInterceptor = true,
}) {
  globalDio = Dio();

  globalDio.options.baseUrl = baseUrl;
  globalDio.options.connectTimeout = connectTimeout;
  globalDio.options.receiveTimeout = receiveTimeout;

  // 日志拦截器
  if (isAddLogInterceptor) {
    globalDio.interceptors.add(ApiLogInterceptor());
  }
}

/// post请求
Future<Response<T>> post<T>(
  String path, {
  Object? data,
  Map<String, dynamic>? headers,
  String contentType = 'application/json',
  ResponseType responseType = ResponseType.json,
  CancelToken? cancelToken,
  Options? options,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  Duration? sendTimeout,
  Duration? receiveTimeout,
}) async {
  return globalDio.request(
    path,
    data: data,
    cancelToken: cancelToken,
    options: Options(
      method: 'POST',
      contentType: contentType,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
      responseType: responseType,
    ),
    onSendProgress: onSendProgress,
    onReceiveProgress: onReceiveProgress,
  );
}
