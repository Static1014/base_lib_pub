import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Name: base_main.dart
///
/// Created by Static4u
/// Date : 2022/11/6 16:43

typedef RoundAppRun = Future<void> Function();

void runMyApp(
  Widget app, {
  /// 是否开启日志
  enableLog = false,

  /// 状态栏和系统导航栏配色
  Color statusBarColor = BaseColors.cTransparent,
  Color sysNavigationBarColor = BaseColors.cBlack,
  bool isStatusBarIconLight = true, // 深底白字
  bool isSysNavigationBarIconLight = true, // 深底白字

  /// 底层路由
  List<String>? unPopRoutes,

  /// 默认路由跳转动画
  Transition? defaultTransition = Transition.cupertino,

  /// 自定义启动前执行
  RoundAppRun? beforeRun,

  /// 初始化仿微信图片选择
  bool initWeChat = false,

  /// 是否开启日志
  String? crashPrefixMsg,

  /// 自定义启动后执行
  RoundAppRun? afterRun,

  /// 退出应用时，注销所有getx的controller
  bool clearGetxControllersBeforeExit = true,
}) {
  WidgetsFlutterBinding.ensureInitialized();

  setGlobalSystemOverlayStyle(
    statusBarColor: statusBarColor,
    isStatusBarIconLight: isStatusBarIconLight,
    sysNavigationBarColor: sysNavigationBarColor,
    isSysNavigationBarIconLight: isStatusBarIconLight,
  );
  Nav.initUnPopRoutes(unPopRoutes ?? []);
  initLog(enable: enableLog);
  Get.config(
    enableLog: enableLog,
    defaultTransition: defaultTransition,
  );
  if (clearGetxControllersBeforeExit) {
    MyGet.actionsBeforeExitApp.add(() {
      clearAllGetxControllers();
    });
  }

  baseBeforeRun().then((value) {
    /// 自定义启动前执行
    if (beforeRun != null) {
      beforeRun.call().then((value) {
        runBaseApp(
          app,
          initWeChat: initWeChat,
          crashPrefixMsg: crashPrefixMsg,
          afterRun: afterRun,
        );
      });
    } else {
      runBaseApp(
        app,
        initWeChat: initWeChat,
        crashPrefixMsg: crashPrefixMsg,
        afterRun: afterRun,
      );
    }
  });
}

void runBaseApp(
  Widget app, {
  /// 初始化仿微信图片选择
  bool initWeChat = false,

  /// 是否开启日志
  String? crashPrefixMsg,

  /// 自定义启动后执行
  RoundAppRun? afterRun,
}) {
  /// 启动app
  runApp(app);

  /// 部分初始化任务可在启动app之后执行
  initCrashHandler(prefixMsg: crashPrefixMsg);
  if (initWeChat) {
    initWechatAssetsPicker();
  }

  /// 自定义启动后执行，即使是异步的，也不用处理异步返回
  afterRun?.call();
}

Future<void> baseBeforeRun() async {
  await initMyDefaultDir();
  await DataUtils.init(prefix: true);

  return;
}

void initLog({bool enable = false}) {
  isForceLog = enable;
}

GetMaterialApp baseApp({
  Key? key,
  GlobalKey<NavigatorState>? navigatorKey,
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
  Widget? home,
  Map<String, WidgetBuilder>? routes,
  String? initialRoute,
  RouteFactory? onGenerateRoute,
  InitialRouteListFactory? onGenerateInitialRoutes,
  RouteFactory? onUnknownRoute,
  List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[],
  TransitionBuilder? builder,
  String title = '',
  GenerateAppTitle? onGenerateTitle,
  ThemeData? theme,
  ThemeData? darkTheme,
  ThemeMode themeMode = ThemeMode.system,
  CustomTransition? customTransition,
  Color? color,
  Map<String, Map<String, String>>? translationsKeys,
  Translations? translations,
  TextDirection? textDirection,
  Locale? locale,
  Locale? fallbackLocale,
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates,
  LocaleListResolutionCallback? localeListResolutionCallback,
  LocaleResolutionCallback? localeResolutionCallback,
  Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')],
  bool showPerformanceOverlay = false,
  bool checkerboardRasterCacheImages = false,
  bool checkerboardOffscreenLayers = false,
  bool showSemanticsDebugger = false,
  bool debugShowCheckedModeBanner = true,
  Map<LogicalKeySet, Intent>? shortcuts,
  ScrollBehavior? scrollBehavior,
  ThemeData? highContrastTheme,
  ThemeData? highContrastDarkTheme,
  Map<Type, Action<Intent>>? actions,
  bool debugShowMaterialGrid = false,
  ValueChanged<Routing?>? routingCallback,
  Transition? defaultTransition,
  bool? opaqueRoute,
  VoidCallback? onInit,
  VoidCallback? onReady,
  VoidCallback? onDispose,
  bool? enableLog,
  LogWriterCallback? logWriterCallback,
  bool? popGesture,
  SmartManagement smartManagement = SmartManagement.full,
  Bindings? initialBinding,
  Duration? transitionDuration,
  bool? defaultGlobalState,
  List<GetPage>? getPages,
  GetPage? unknownRoute,
  RouteInformationProvider? routeInformationProvider,
  RouteInformationParser<Object>? routeInformationParser,
  RouterDelegate<Object>? routerDelegate,
  BackButtonDispatcher? backButtonDispatcher,
  bool useInheritedMediaQuery = false,
}) {
  return GetMaterialApp(
    key: key,
    navigatorKey: navigatorKey,
    scaffoldMessengerKey: scaffoldMessengerKey,
    home: home,
    routes: const <String, WidgetBuilder>{},
    initialRoute: initialRoute,
    onGenerateRoute: onGenerateRoute,
    onGenerateInitialRoutes: onGenerateInitialRoutes,
    onUnknownRoute: onUnknownRoute,
    useInheritedMediaQuery: useInheritedMediaQuery,
    navigatorObservers: navigatorObservers,
    builder: builder,
    textDirection: textDirection,
    title: title,
    onGenerateTitle: onGenerateTitle,
    color: color,
    theme: theme ?? BaseTheme.defaultTheme,
    darkTheme: darkTheme,
    themeMode: themeMode,
    locale: locale,
    fallbackLocale: fallbackLocale,
    localizationsDelegates: localizationsDelegates,
    localeListResolutionCallback: localeListResolutionCallback,
    localeResolutionCallback: localeResolutionCallback,
    supportedLocales: supportedLocales,
    debugShowMaterialGrid: debugShowMaterialGrid,
    showPerformanceOverlay: showPerformanceOverlay,
    checkerboardRasterCacheImages: checkerboardRasterCacheImages,
    checkerboardOffscreenLayers: checkerboardOffscreenLayers,
    showSemanticsDebugger: showSemanticsDebugger,
    debugShowCheckedModeBanner: debugShowCheckedModeBanner,
    shortcuts: shortcuts,
    scrollBehavior: scrollBehavior,
    customTransition: customTransition,
    translationsKeys: translationsKeys,
    translations: translations,
    onInit: onInit,
    onReady: onReady,
    onDispose: onDispose,
    routingCallback: routingCallback,
    defaultTransition: defaultTransition,
    getPages: getPages,
    opaqueRoute: opaqueRoute,
    enableLog: enableLog,
    logWriterCallback: logWriterCallback,
    popGesture: popGesture,
    transitionDuration: transitionDuration,
    defaultGlobalState: defaultGlobalState,
    smartManagement: smartManagement,
    initialBinding: initialBinding,
    unknownRoute: unknownRoute,
    highContrastTheme: highContrastTheme,
    highContrastDarkTheme: highContrastDarkTheme,
    actions: actions,
  );
}
