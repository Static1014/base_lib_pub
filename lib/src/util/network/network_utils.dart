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

/// 配置全局dio
void initGlobalDio({
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
  globalDio = createDio(
    baseUrl: baseUrl,
    connectTimeout: connectTimeout,
    receiveTimeout: receiveTimeout,
    isAddLogInterceptor: isAddLogInterceptor,
    ignoreCertificate: ignoreCertificate,
    isClientGlobal: isClientGlobal,
    certPem: certPem,
    verifyCallback: verifyCallback,
  );
}

// 创建dio
Dio createDio({
  String baseUrl = '',
  Duration connectTimeout = const Duration(seconds: 10),
  Duration? receiveTimeout = const Duration(seconds: 30),
  bool isAddLogInterceptor = true,
  bool ignoreCertificate = false, // 忽略证书
  bool isClientGlobal = false, // 当前初始化httpClient是否global化
  String? certPem, // https证书pem
  // 自定义证书校验规则
  bool Function(X509Certificate cert, String host, int port)? verifyCallback,
  HttpClient? httpClient,
}) {
  final dio = Dio();

  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = connectTimeout;
  dio.options.receiveTimeout = receiveTimeout;

  // 日志拦截器
  if (isAddLogInterceptor) {
    dio.interceptors.add(ApiLogInterceptor());
  }
  // https证书校验
  dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
    return httpClient ??
        createHttpClient(
          ignoreCertificate: ignoreCertificate,
          certPem: certPem,
          isClientGlobal: isClientGlobal,
          verifyCallback: verifyCallback,
        );
  });

  return dio;
}

/// 获取统一的httpClient
HttpClient createHttpClient({
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
  Dio? dio,
}) async {
  return (dio ?? globalDio).request(
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
  Dio? dio,
}) async {
  return (dio ?? globalDio).request(
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
