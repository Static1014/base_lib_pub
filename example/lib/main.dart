import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub_example/main_logic.dart';
import 'package:base_lib_pub_example/route/routes.dart';
import 'package:base_lib_pub_example/theme/my_themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'trans/translation.dart';

void main() {
  runMyApp(
    const MyApp(),
    enableLog: true,
    unPopRoutes: Routes.unPopRoutes,
    initWeChat: true,
    isStatusBarIconLight: false,
    isSysNavigationBarIconLight: false,
    beforeRun: () async {
      /// 初始化网络请求
      initGlobalDio(ignoreCertificate: true);
      Get.put(MainLogic(), permanent: true);
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
    onBuildFinished((duration) {
      MyThemes.changeTheme();
    });
    return baseApp(
      // 路由
      initialRoute: Routes.init,
      getPages: Routes.getPages(),
      // theme
      // themeMode: ThemeMode.light,
      theme: MyThemes.curThemeHolder.themeData,
      // darkTheme: MyThemes.dark,
      // 国际化配置
      locale: MyTrans.locale,
      fallbackLocale: MyTrans.fallbackLocale,
      translations: MyTrans(),
      // botToast
      builder: toastBuilder,
      navigatorObservers: [toastObserver],
    );
  }
}
