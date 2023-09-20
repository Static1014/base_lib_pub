<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
_Language_: [![Static Badge](https://img.shields.io/badge/Chinese-Zh--cn-FF0000)
](README.zh-cn.md), [![Static Badge](https://img.shields.io/badge/English-En--us-122c60)](README.md)

## Description

This is a basic library of Flutter project based on [Getx](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md).

In order to build applications conveniently and quickly, you can quickly integrate the basic functions needed by general applications by adding this project dependency.

The original intention of this project is to establish a basic framework library that can be directly cited in multiple projects. In the early days, the base_lib folder was directly copied and pasted between various projects. Later, for the convenience of maintenance and synchronous update, we began to look for a common solution, so this project came into being.

It would be great if someone could get some help in the project.

Come on!

## Features

1. General project structure;
2. General page:
    1. Picture preview (text preview support);
    2. webView (no-singleTop support);
3. General tools;
    1. aes encryption and decryption;
    2. Network requests and request logs;
    3. System sharing;
    4. crash log;
    5. File operation;
    6. Picture selector, photo selector and picture compression;
    7. Unified log management;
    8. Permission request and verification;
    9. Local data storage;
    10. Equipment information inquiry;
    11. Application information query;
    12. Adjust third-party applications;
    13. Other general utils;
4. Internationalization of general foundation (Chinese and English);
5. Universal ui:
    1. common_ui:
        1. mWillPopScope;
        2. mRoot;
        3. mAppBar;
        4. mText;
        5. mTextField;
        6. mBorder、mLine、mDivider;
        7. mLoadImageView;
        8. mFadeInView;
        9. mAvatar;
        10. mSimpleBoxDecoration;
        11. mInkView;
        12. mProgressIndicator;
        13. mOverSizeScrollView;
        14. mScrollConfig;
        15. ...
    2. Cartridge: Support multiple cartridges to customize closing sequence and animation;
        1. mShowTip;
        2. mShowDialog;
    3. General showLoading, toast, notify；;
    4. Common colors and sizes (which may be removed later)
    5. universal list Footer；;
    6. KeepAliveWrapper;
    7. MySalomonBottomBar (modified from SalomonBottomBar, supporting double-click callback);
6. Universal navigation routing;
    1. Nav navigation tools;
    2. Inherit BaseRoutesClass to uniformly obtain routing Routes；;
7. Universal extension:
    1. Log output;
    2. Date formatting;
    3. Rolling controller;
    4. getx: myget extends GetInterface；;
8. Others
    1. GetxAnimationControllerMixin gets AnimationController；;
    2. GetTicker to get TickerProvider；;
9. ...

## Getting started

1. Personal open source, limited ability, light spray;
2. Most of the time, the project is only debugging on individual private Android devices. 
3. If there is any compatibility problem, please email to [420048248@qq.com](mailto:420048248@qq.com) or use the contact information at the bottom to give feedback;
4. Based on Flutter 3.13.0, Dart 3.1.0；


## Usage

The [example](example/lib/page/home/view.dart) is in `example/lib/page/home/view.dart`.

The [entrance](example/lib/main.dart) is as follows:

```dart
import 'package:base_lib_pub/base_lib_pub.dart';

// ...

void main() {
  initBaseApp(
    enableLog: true,
    unPopRoutes: [Routes.init, Routes.home],
    initWeChat: true,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key}) {
    /// 初始化网络请求
    initDio(baseUrl: '');
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 路由
      initialRoute: Routes.init,
      getPages: Routes.getPages(),
      // 国际化配置
      locale: MyTranslations.locale,
      fallbackLocale: MyTranslations.fallbackLocale,
      translations: MyTranslations(),
      // botToast
      builder: toastBuilder,
      navigatorObservers: [toastObserver],
    );
  }
}
```

## Additional information

- Please comply with the open source licensing requirements of the dependent project.
- Technology is a long and continuous road, and you share!
- Contact:  [420048248@qq.com](mailto:420048248@qq.com), [Github](https://github.com/Static1014/base_lib_pub.git), [WeChat: Misu_324]()
 