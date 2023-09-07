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

_语言: 中文, [英文](README.md)

## 项目介绍

这是一个基于[Getx](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md)的Flutter项目基础库。

为了方便快速的搭建应用程序，可以通过添加此项目依赖，快速集成一般应用所需要的基础功能。

此项目的建设初衷是建立一个可以在多个项目中直接引用的基础框架库。早期是直接在各个项目之间直接复制粘贴base_lib文件夹，后出于方便维护、同步更新，便开始寻找通用解决方案，于是就有了此项目。

如果有人能在项目中获得一些帮助，那真是太好了。

一起加油吧！

## 项目功能

1. 通用项目结构;
2. 通用page：图片预览（支持文字预览）、测试页;
3. 通用工具;
   1. aes加解密；
   2. 网络请求、请求日志；
   3. 分享；
   4. 崩溃日志；
   5. 文件操作；
   6. GetxAnimationController；
   7. 图片选择器、拍照选择器、图片压缩；
   8. 统一日志管理；
   9. 权限请求与验证；
   10. 其他通用utils；
4. 通用基础国际化（中文、英文）;
5. 通用ui：
   1. 弹框：支持多个弹框自定义关闭顺序；自定义动画；
   2. 通用loading；
   3. 通用颜色、尺寸；
6. 通用导航；
7. 通用扩展：
   1. 日志输出；
   2. 日期格式化；
   3. 滚动控制器；
8. 敬请期待...

## 开始之前

1. 个人开源，能力有限，轻喷；
2. 该项目大部分时间只在个别私人Android设备上调试；
3. 如存在兼容性问题，可邮箱联系[420048248@qq.com](mailto:420048248@qq.com)或通过底部联系方式进行反馈；
4. 开发调试基于：Flutter 3.13.2, Dart 3.1.0；

## 使用

项目使用[入口示例](example/lib/main.dart):

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
      initialRoute: Routes.init,
      getPages: Routes.getPages(),
      // botToast
      builder: toastBuilder,
      navigatorObservers: [toastObserver],
    );
  }
}

```

## 项目依赖

1. 基础: [get: ^4.6.5](https://pub.dev/packages/get)
2. 动画: [simple_animations](https://pub.dev/packages/simple_animations)
3. toast、loading: [bot_toast: ^4.0.4](https://pub.dev/packages/bot_toast)
4. 权限申请、检查: [permission_handler: ^10.4.5](https://pub.dev/packages/permission_handler)
5. 保存图片到相册: [image_gallery_saver: ^2.0.1](https://pub.dev/packages/)
6. 图片加载、查看: [extended_image: ^8.1.0](https://pub.dev/packages/extended_image)
7. 仿微信选择图片: [wechat_assets_picker: ^8.7.0](https://pub.dev/packages/wechat_assets_picker)、[wechat_camera_picker: ^4.0.1](https://pub.dev/packages/)
8. 网络: [dio: ^5.3.2](https://pub.dev/packages/wechat_camera_picker)
9. 图片压缩: [flutter_image_compress: ^2.0.3](https://pub.dev/packages/flutter_image_compress)
10. 文件操作: [path_provider: ^2.1.1](https://pub.dev/packages/path_provider)
11. 日期格式化: [date_format: ^2.0.7](https://pub.dev/packages/date_format)
12. 分享: [share_plus: ^7.1.0](https://pub.dev/packages/share_plus)
13. 瀑布流、自定义栅格等: [flutter_staggered_grid_view: ^0.7.0](https://pub.dev/packages/flutter_staggered_grid_view)
14. uri转文件路径: [uri_to_file: ^0.2.0](https://pub.dev/packages/uri_to_file)
15. 加解密: [encrypt: ^5.0.1](https://pub.dev/packages/encrypt)

- 请自觉遵循依赖项目的开源许可要求。

## 写在最后

- 技术是一条漫长且持续的道路，与诸君共勉！


- 联系方式: [420048248@qq.com](mailto:420048248@qq.com)、[Github](https://github.com/Static1014/base_lib_pub.git)、[微信: Misu_324]()


