import 'dart:io';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

/// Name: my_extended_image_with_http_client.dart
///
/// Created by Static4u
/// Date : 2023/10/18 12:27
class MyExtendedImageWithHttpClient extends ExtendedImage {
  /// 支持自定义httpClient来请求图片
  MyExtendedImageWithHttpClient.network(
    String url, {
    super.key,
    super.semanticLabel,
    super.excludeFromSemantics = false,
    super.width,
    super.height,
    super.color,
    super.opacity,
    super.colorBlendMode,
    super.fit,
    super.alignment = Alignment.center,
    super.repeat = ImageRepeat.noRepeat,
    super.centerSlice,
    super.matchTextDirection = false,
    super.gaplessPlayback = false,
    super.filterQuality = FilterQuality.low,
    super.loadStateChanged,
    super.shape,
    super.border,
    super.borderRadius,
    super.clipBehavior = Clip.antiAlias,
    super.enableLoadState = true,
    super.beforePaintImage,
    super.afterPaintImage,
    super.mode = ExtendedImageMode.none,
    super.enableMemoryCache = true,
    super.clearMemoryCacheIfFailed = true,
    super.onDoubleTap,
    super.initGestureConfigHandler,
    super.enableSlideOutPage = false,
    BoxConstraints? constraints,
    CancellationToken? cancelToken,
    int retries = 3,
    Duration? timeLimit,
    Map<String, String>? headers,
    bool cache = true,
    double scale = 1.0,
    Duration timeRetry = const Duration(milliseconds: 100),
    super.extendedImageEditorKey,
    super.initEditorConfigHandler,
    super.heroBuilderForSlidingPage,
    super.clearMemoryCacheWhenDispose = false,
    super.handleLoadingProgress = false,
    super.extendedImageGestureKey,
    int? cacheWidth,
    int? cacheHeight,
    super.isAntiAlias = false,
    String? cacheKey,
    bool printError = true,
    double? compressionRatio,
    int? maxBytes,
    bool cacheRawData = false,
    String? imageCacheName,
    Duration? cacheMaxAge,
    super.layoutInsets = EdgeInsets.zero,
    HttpClient? client,
  })  : assert(cacheWidth == null || cacheWidth > 0),
        assert(cacheHeight == null || cacheHeight > 0),
        assert(constraints == null || constraints.debugAssertIsValid()),
        assert(cacheWidth == null || cacheWidth > 0),
        assert(cacheHeight == null || cacheHeight > 0),
        super(
            image: ExtendedResizeImage.resizeIfNeeded(
              provider: MyExtendedImageProviderWithHttpClient(url,
                  scale: scale,
                  headers: headers,
                  cache: cache,
                  cancelToken: cancelToken,
                  retries: retries,
                  timeRetry: timeRetry,
                  timeLimit: timeLimit,
                  cacheKey: cacheKey,
                  printError: printError,
                  cacheRawData: cacheRawData,
                  imageCacheName: imageCacheName,
                  cacheMaxAge: cacheMaxAge,
                  httpClient: client ?? httpClient),
              compressionRatio: compressionRatio,
              maxBytes: maxBytes,
              cacheWidth: cacheWidth,
              cacheHeight: cacheHeight,
              cacheRawData: cacheRawData,
              imageCacheName: imageCacheName,
            ),
            constraints: (width != null || height != null)
                ? constraints?.tighten(width: width, height: height) ?? BoxConstraints.tightFor(width: width, height: height)
                : constraints);

  // Do not access this field directly; use [_httpClient] instead.
  // We set `autoUncompress` to false to ensure that we can trust the value of
  // the `Content-Length` HTTP header. We automatically uncompress the content
  // in our call to [consolidateHttpClientResponseBytes].
  static HttpClient _sharedHttpClient = (globalHttpClient ?? initHttpClient())..autoUncompress = false;

  static HttpClient get httpClient {
    HttpClient client = _sharedHttpClient;
    assert(() {
      if (debugNetworkImageHttpClientProvider != null) {
        client = debugNetworkImageHttpClientProvider!();
      }
      return true;
    }());
    return client;
  }

  static set httpClient(HttpClient client) {
    _sharedHttpClient = client;
  }
}
