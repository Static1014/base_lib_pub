import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:dio/dio.dart';

/// Name: api_log_interceptor.dart
///
/// Created by Static4u
/// Date : 2023/9/4 17:18
class ApiLogInterceptor extends Interceptor {
  static const tag = 'Api Log';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
    // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
    String url = globalDio.options.baseUrl + options.path;
    dynamic data = options.data;
    'Request  on url: $url, with ${data == null ? "no params" : "params:\n$data"}'.logI(tag: tag, split: true);
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
    // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
    String url = globalDio.options.baseUrl + err.requestOptions.path;
    dynamic data = err.requestOptions.data;
    'Error    on url: $url, with ${data == null ? "no params" : "params:\n$data"}  :\n$data'.logW(tag: tag, split: true);
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 如果你想完成请求并返回一些自定义数据，你可以使用 `handler.resolve(response)`。
    // 如果你想终止请求并触发一个错误，你可以使用 `handler.reject(error)`。
    String url = globalDio.options.baseUrl + response.requestOptions.path;
    dynamic data = response.data;
    'Response on url: $url, with response:\n$data'.logI(tag: tag, split: true);
    handler.next(response);
  }
}
