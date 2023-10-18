import 'dart:io';

import 'package:base_lib_pub/src/util/network/api_log_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

/// Name: network_utils.dart
///
/// Created by Static4u
/// Date : 2023/9/4 16:58

/// 全局dio实例
late Dio globalDio;

/// 全局httpClient实例
HttpClient? globalHttpClient;

/// 配置dio
void initDio({
  String baseUrl = '',
  Duration connectTimeout = const Duration(seconds: 10),
  Duration? receiveTimeout = const Duration(seconds: 30),
  bool isAddLogInterceptor = true,
  bool ignoreCertificate = false, // 忽略证书
  bool isClientGlobal = true, // 当前初始化httpClient是否global化
  String? certPem, // https证书pem
  // 自定义证书校验规则
  bool Function(X509Certificate cert, String host, int port)? verifyCallback,
}) {
  globalDio = Dio();

  globalDio.options.baseUrl = baseUrl;
  globalDio.options.connectTimeout = connectTimeout;
  globalDio.options.receiveTimeout = receiveTimeout;

  // 日志拦截器
  if (isAddLogInterceptor) {
    globalDio.interceptors.add(ApiLogInterceptor());
  }
  // https证书校验
  HttpClient httpClient = initHttpClient(
    ignoreCertificate: ignoreCertificate,
    certPem: certPem,
    isClientGlobal: isClientGlobal,
    verifyCallback: verifyCallback,
  );
  globalDio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
    return httpClient;
  });
}

/// 获取统一的httpClient
HttpClient initHttpClient({
  bool ignoreCertificate = false,
  String? certPem,
  bool isClientGlobal = false, // 当前初始化httpClient是否global化
  bool Function(X509Certificate cert, String host, int port)? verifyCallback,
}) {
  final client = HttpClient();
  client.badCertificateCallback = verifyCallback ??
      (cert, host, port) {
        // 校验https证书
        if (ignoreCertificate) {
          return true;
        }
        return cert.pem == certPem;
      };
  if (isClientGlobal) {
    globalHttpClient = client;
  }
  return client;
}

/// post请求
Future<Response<T>> post<T>(
  String path, {
  Object? data,
  Map<String, dynamic>? headers,
  String contentType = Headers.jsonContentType,
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

/// get请求
Future<Response<T>> get<T>(
  String path, {
  Map<String, dynamic>? params,
  Map<String, dynamic>? headers,
  String? contentType,
  ResponseType? responseType,
  CancelToken? cancelToken,
  Options? options,
  ProgressCallback? onSendProgress,
  ProgressCallback? onReceiveProgress,
  Duration? sendTimeout,
  Duration? receiveTimeout,
}) async {
  return globalDio.request(
    path,
    queryParameters: params,
    cancelToken: cancelToken,
    options: Options(
      method: 'GET',
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
