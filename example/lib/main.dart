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
    initWeChat: true,
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
      // 手动配置主题，重启时需要切换
      MyThemes.changeTheme();
    });
    return baseApp(
      // 路由
      initialRoute: Routes.init,
      getPages: Routes.getPages(),
      unPopRoutes: Routes.unPopRoutes,
      defaultTransition: Transition.cupertino,
      navigatorObservers: [
        // botToast
        toastObserver
      ],
      // 系统栏样式
      isStatusBarIconLight: false,
      isSysNavigationBarIconLight: false,
      // 主题
      // 手动配置主题，只初始化theme即可，切换即改变MyThemes.curThemeHolder
      theme: MyThemes.curThemeHolder.themeData,
      // 如果需要跟随系统主题变化，需要配置themeMode和darkTheme
      // themeMode: ThemeMode.light,
      // darkTheme: MyThemes.dark,
      // 国际化配置
      locale: MyTrans.locale,
      fallbackLocale: MyTrans.fallbackLocale,
      translations: MyTrans(),
      // botToast
      builder: toastBuilder,
    );
  }
}
