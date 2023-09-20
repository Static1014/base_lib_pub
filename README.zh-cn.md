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

_语言_: [![Static Badge](https://img.shields.io/badge/%E4%B8%AD%E6%96%87-Zh--cn-FF0000)
](README.zh-cn.md)、 [![Static Badge](https://img.shields.io/badge/%E8%8B%B1%E6%96%87-En--us-122c60)](README.md)

## 项目介绍

这是一个基于[Getx](https://github.com/jonataslaw/getx/blob/master/README.zh-cn.md)的Flutter项目基础库。

为了方便快速的搭建应用程序，可以通过添加此项目依赖，快速集成一般应用所需要的基础功能。

此项目的建设初衷是建立一个可以在多个项目中直接引用的基础框架库。早期是直接在各个项目之间直接复制粘贴base_lib文件夹，后出于方便维护、同步更新，便开始寻找通用解决方案，于是就有了此项目。

如果有人能在项目中获得一些帮助，那真是太好了。

一起加油吧！

## 项目功能

1. 通用项目结构;
2. 通用page：
    1. 图片预览（支持文字预览）;
    2. webView（支持非singleTop）；
3. 通用工具;
    1. aes加解密；
    2. 网络请求、请求日志；
    3. 系统分享；
    4. 崩溃日志；
    5. 文件操作；
    6. 图片选择器、拍照选择器、图片压缩；
    7. 统一日志管理；
    8. 权限请求与验证；
    9. 本地数据存储；
    10. 设备信息查询；
    11. 应用信息查询；
    12. 调整第三方应用；
    13. 其他通用utils；
4. 通用基础国际化（中文、英文）;
5. 通用ui：
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
    2. 弹框：支持多个弹框自定义关闭顺序、自定义动画；
        1. mShowTip;
        2. mShowDialog;
    3. 通用showLoading、toast、notify；
    4. 通用颜色、尺寸（后期可能移除）
    5. 通用列表Footer；
    6. KeepAliveWrapper;
    7. MySalomonBottomBar（由SalomonBottomBar修改而来，支持双击回调）；
6. 通用导航路由；
    1. Nav导航工具；
    2. 继承BaseRoutesClass以统一获得路由Routes；
7. 通用扩展：
    1. 日志输出；
    2. 日期格式化；
    3. 滚动控制器；
    4. getx：MyGet扩展GetInterface；
8. 其他
    1. GetxAnimationControllerMixin获取AnimationController；
    2. GetTicker获取TickerProvider；
9. ...

## 开始之前

1. 个人开源，能力有限，轻喷；
2. 该项目大部分时间只在个别私人Android设备上调试；
3. 如存在兼容性问题，可邮箱联系[420048248@qq.com](mailto:420048248@qq.com)或通过底部联系方式进行反馈；
4. 开发调试基于：Flutter 3.13.2, Dart 3.1.0；

## 使用

示例代码：[example](example/lib/page/home/view.dart)。

项目使用[入口示例](example/lib/main.dart):

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

## 写在最后

- 请自觉遵循依赖项目的开源许可要求。

- 技术是一条漫长且持续的道路，与诸君共勉！

- 联系方式: [420048248@qq.com](mailto:420048248@qq.com)、[Github](https://github.com/Static1014/base_lib_pub.git)、[微信: Misu_324]()


