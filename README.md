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
_Language: [Chinese](README.zh-cn.md), English

## Description

This is a basic library of Flutter project based on [Getx](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md).

In order to build applications conveniently and quickly, you can quickly integrate the basic functions needed by general applications by adding this project dependency.

The original intention of this project is to establish a basic framework library that can be directly cited in multiple projects. In the early days, the base_lib folder was directly copied and pasted between various projects. Later, for the convenience of maintenance and synchronous update, we began to look for a common solution, so this project came into being.

It would be great if someone could get some help in the project.

Come on!

## Features

1. General project structure;
2. General page: picture preview (text preview supported) and test page.;
3. General tools：
   1. Aes encryption and decryption;
   2. Network requests and request logs; 
   3. Share; 
   4. Crash log; 
   5. File operation; 
   6. GetxAnimationController； 
   7. Picture selector, take photo and picture compression; 
   8. Unified log management; 
   9. Permission request and verification; 
   10. Other general utils; 
4. General basic internationalization (Chinese, English);
5. General ui:
   1. Cartridge: Support multiple cartridges to customize the closing sequence; Custom animation;
   2. universal loading；;
   3. Common colors and sizes;
6. General navigation;
7. General extension:
   1. Log output;
   2. Date formatting;
   3. Rolling controller;
8. Stay tuned...

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
    enableLog: MyConst.isDebug || MyConst.isForceLog,
    unPopRoutes: [Routes.init, Routes.home],
    initWeChat: true,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key}) {
    /// network util init
    initDio(baseUrl: '');
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.init,
      getPages: Routes.getPages(),
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
 