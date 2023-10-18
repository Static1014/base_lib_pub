import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub_example/route/routes.dart';
import 'package:base_lib_pub_example/translation/translation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runMyApp(
    const MyApp(),
    enableLog: true,
    unPopRoutes: [Routes.init, Routes.home],
    initWeChat: true,
    beforeRun: () async {
      /// 初始化网络请求
      initDio(ignoreCertificate: true);
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
