## 3.7.3

1. 升级flutter sdk to 3.22.0;
2. 新增日期格式；
3. 修复部分UI样式问题；

## 3.7.2

1. color扩展：
    1. 新增函数`shade(double shade, {double alpha = 1})`获得颜色的浅色和深色；
    2. 新增`toHexString()`获取颜色的十六进制字符串；
2. list扩展，新增random()、randomList()两个方法，获取列表中的随机元素；
3. 部分ui调整；

## 3.7.1

1. 调整onBuildFinished调用时机，避免不必要的重复调用；
2. 调整CommonWebViewPage、ImagePreviewPage中logic的实例获取时间；

## 3.7.0

1. 优化log_utils:
    1. 默认开启等级颜色;
    2. 默认开启分段，在tag中新增groupID以识别分段日志；
    3. 使用print替代developer.log；
2. 默认主题调整；
3. 其他widget调整；
4. Android AGP/gradle升级：8.3.1/8.4;

## 3.6.6

1. 调整MDialog同id将先隐藏前一个再展示当前弹框；
2. 默认日志根据等级彩色打印；

## 3.6.5

1. 调整GlobalKey扩展；

## 3.6.4

1. 调整baseApp、runApp参数结构；
2. mAppBar新增默认backIconData修改；
3. 新增GlobalKeyExt扩展，获取overlayContext；

## 3.6.3

1. 部分代码优化；

## 3.6.2

1. BaseTheme.createTheme新增参数；
2. example新增自定义ThemeData属性MyThemeData;

## 3.6.1

1. 调整MyThemes为单例模式；
2. 部分函数优化；

## 3.6.0

1. 修正showLoading视图元素居中问题；
2. 替换振动反馈实现vibrate_utils；
3. example/android项目下新增flutter基础混淆；
4. 修改base_theme，新增my_theme(light、red)，在example/setting中可修改并记录主题；

## 3.5.1

1. 将location_utils移动到example项目中;

## 3.5.0

1. 更新base依赖；
2. 修正国际化lang.dart中的内容；
3. 新增location_utils，使用geoLocator获取定位信息；

## 3.4.5

1. 在common_ui部分组件中添加semanticLabel属性；

## 3.4.4

1. 调整lang.dart中的国际化内容；
2. 扩展String，支持国际化中带参数；

## 3.4.3

1. lang.dart新增常用国际化配置；

## 3.4.2

1. common_utils/vibrate支持自定义间隔振动；

## 3.4.1

1. common_ui新增mButton通用简易按钮组件；

## 3.4.0

- 提升sdk版本：flutter 3.19.1, dart 3.3.0

1. 新增List扩展，提供元素交换位置方法；
2. 新增int扩展，提供前部填充字符方法;
3. 修改example/android中settings.gradle和build.gradle配置；

## 3.3.2

1. overlay_utils/showLoading扩展；

## 3.3.1

1. log_utils/printLog打印日志，时间显示到毫秒；
2. overlay_utils/showLoading支持空提示文字；

## 3.3.0

1. 替换WillPopScope为PopScope，适配相关widget；
2. 修复commonWebView关闭弹框“取消”按钮失效问题；

## 3.2.3

1. 修复example/android项目国际化失败问题，即build.gradle中resConfigs配置须与MyTrans中配置匹配；

## 3.2.2

1. image_utils修改pickImage，新增存储和拍摄权限申请和失败说明；

## 3.2.1

1. example/android/app/build.gradle指定需要打包的语言资源，去除第三方包引入的各种语言，只保留本APP指定的语言资源；
2. example/android/app/build.gradle指定abiFilters，放弃支持x86执行；
3. ScrollControllerExt新增shake方法，支持在滚动轴上晃动一次；

## 3.2.0

1. device_utils中新增goAppSetting()方法，调整系统应用设置界面；
2. 修改permission_utils，完善权限申请流程；
3. MainActivity中修复最近任务列表不显示应用名称的问题；
4. 修改Podfile中platform :ios, '11.0'为'12.0';

## 3.1.0

> 开发环境: Flutter 3.16.7, Dart 3.2.4

1. 升级wechat_assets_picker: ^9.0.0-dev.2、wechat_camera_picker: ^4.2.0-dev.3，适配Flutter
   3.16.x，解决无法正常显示图片问题；
2. 升级全局kotlin版本为1.9.22；
3. 修改默认主题样式；
4. 修复common_ui/mImageView参数url为空时的异常报错，当url为空时，直接显示errorWidget；
5. 升级其他依赖：
    1. permission_handler: ^11.1.0 -> ^11.2.0
    2. path_provider: ^2.1.1 -> ^2.1.2
    3. share_plus: ^7.1.0 -> ^7.2.1
    4. webview_flutter: ^4.4.2 -> ^4.4.4
    5. url_launcher: ^6.2.1 -> ^6.2.3

## 3.0.3

1. 修改BaseTheme默认主题TabBarTheme，取消分割线；

## 3.0.2

1. 修改network_utils，支持post、get自定义dio；
2.

mImageView支持自定义httpClient，默认使用globalHttpClient，如果globalHttpClient未初始化，则使用myExtendedImageHttpClient（默认忽略证书）；

## 3.0.1

1. 通过base_main/baseApp设置默认主题，默认M2主题样式；
2. 通过base_main/runMyApp默认设置退出应用时，注销所有getx的controller；

## 3.0.0

1. 升级适配Flutter SDK版本至3.16.3；
2. 新增base_theme，通过defaultTheme调整默认主题效果为M2主题样式；
3. 修改sample默认主题样式；

## 2.9.1

1. MyGet新增actionsBeforeExitApp回调，在common_utils/exitApp前执行；

## 2.9.0

1. 更新dart 3.2.1, flutter 3.16.1;
2. 修复升级flutter3.16.1后photo_manager依赖中DecoderCallback not found问题；
3. 依赖版本更新；
4. 升级Android AGP 8.1.3，gradle 8.0；

## 2.8.5

1. 当mScrollConfig开启scrollbar时，如果ScrollView指定了scrollController，scrollbar必须指定同一个scrollController；

## 2.8.4

1. MDialog新增isVisible返回dialog是否正在显示；

## 2.8.3

1. MDialog新增simpleAnimate自带动画；

## 2.8.2

1. mAppBar默认使用主题背景色；

## 2.8.1

1. mImageView添加size参数设置尺寸；
2. image_utils修改pickImage，新增预览模式；

## 2.8.0

1. 新增MyExtendedImageProviderWithHttpClient实现自定义httpClient的ImageProvider，以加载非官方证书的https图片资源；
2.
新增MyExtendedImageWithHttpClient实现network网络图片加载，默认使用network_utils/globalHttpClient??initHttpClient()
进行网络图片加载；
3. 替换mImageView中ExtendedImage.network为MyExtendedImageWithHttpClient.network，用于加载非官方证书的https图片资源；

## 2.7.3

1. ImagePreviewPage支持自定义text widget；
2. ImagePreviewPage内textWidget支持超长自动开启滚动；

## 2.7.2

1. CommonWebViewPage初始化时控制是否启用bottomNav，默认自动根据实际情况控制是否显示；
2. CommonWebViewLogic新增在启用bottomNav的情况下，控制是否显示bottomNav；

## 2.7.1

1. Nav页面跳转添加返回值；
2. base_main里runMyApp中baseBeforeRun和beforeRun改为异步函数，只有异步执行完毕后才能runApp；

## 2.7.0

1. network_utils中新增getHttpClient和globalHttpClient，用以获取统一的网络请求httpClient，并实现https证书校验；
2. 允许http请求；
3. CommonWebViewPage忽略https证书；

## 2.6.4

1. 自定义mScrollbar统一样式；
2. mScrollConfig使用mScrollbar；

## 2.6.3

1. common_ui新增setSystemOverlayVisible设置系统状态栏和底部导航栏是否可见；

## 2.6.2

1. 新增NumExt扩展num，实现toAngle、toPx方法；

## 2.6.1

1. mImageView默认shape为rectangle；
2. mImageView新增clipBehavior参数；
3. 当设置mImageView的radius或borderRadius时，如果shape不是circle，自定改为rectangle；
4. example更新；

## 2.6.0

1. 集成并封装flutter_slidable库，使用方法请参照example/lib/page/home；

## 2.5.1

1. android支持应用名称国际化；
2. iOS应用名称、权限请求说明国际化；
3. iOS启动页面LaunchImage、LaunchScreen设置；
4. 扩展Double支持.toPx()转化px单位；

## 2.5.0

1. 重命名mLoadImageView为mImageView；
2. 修复mImageView无法正常显示assets资源的问题；
3. common_ui新增获取assets资源路径的方法；
4. 优化example中Android启动页面效果：全屏、带logo；
5. 重命名base_main中initBaseApp为runMyApp；
6. 优化base_main中初始化顺序，非必须想放到runApp之后执行；
7. ImagePreviewPage默认显示indicator；
8. mImageView新增width和height参数；

## 2.4.9

1. 修复mTextField无法主动换行的问题；

## 2.4.8

1. mAppBar默认title的font weight为bold；

## 2.4.7

1. example中，当使用url_launcher从外部浏览器打开网页时，需要提前声明，否则在api30及以上无法启动外部浏览器：
    1. AndroidManifest下在queries中添加https（http）；
    2. ios/Runner/info.plist下LSApplicationQueriesSchemes中新增https（http）；
2. MDialog.tip中消息内容默认最低高度为0；
3. ImagePreviewPage中当只有一个元素时不展示下标显示器；

## 2.4.6

1. ImagePreviewLogic新增构造参数showIndicator控制是否显示下标指示器；

## 2.4.5

1. 修正ImagePreviewLogic.deleteAt()之后_curIndex错误的问题；

## 2.4.4

1. MDialog.tip支持msgPadding；

## 2.4.3

1. MDialog.tip支持自定义title和content；
2. example更新；

## 2.4.2

1. CommonWebViewPage底部web导航栏可由构造参数控制是否显示；

## 2.4.1

1. CommonWebViewPage入参appBar替换为appBarBuilder，通过回调，在目标route被创建时再创建mAppBar，避免Nav.isPopEnable判断错误；

## 2.4.0

1. CommonWebViewPage新增WebPageBuilder，支持自定义页面内容；
2. 扩展WebViewController，新增init方法快速初始化；新增load快速加载内容；
3. CommonWebViewPageLogic支持底部web导航栏的显隐切换；

## 2.3.4

1. CommonWebViewPage支持popGesture；

## 2.3.3

1. ImagePreviewPage和CommonWebViewPage启动可设置fullscreenDialog参数；
2. mRoot在不设置onWillPop时不创建WillPopScope，避免popGesture失效；

## 2.3.2

1. ImagePreviewPage启动时如果imgList为空，则toast提示；
2. 新增清除ExtendedImage缓存；

## 2.3.1

1. url_launcher_utils函数调用结果日志输出；
2. ImagePreviewPage不使用safeArea，全屏展示。通过自定义bottomPadding来避免遮挡；
3. HomePage新增示例；

## 2.3.0

1. 导出url_launcher_utils：新增mailto、tel方法（须配置queries，参考url_launcher_utils文件注释）；
2. String扩展encodeUrl中文编码；
3. CommonWebViewPage新增urlOrData为空的log提示；

## 2.2.0

1. CommonWebViewPage支持传入userAgent，request method、body、headers等;
2. CommonWebViewPage新增创建回调，暴露当前page的WebViewController，供外部使用（须注意方法的调用时机，回调时webView还未绘制）；

## 2.1.11

1. toast()新增支持自定义颜色、ToastLevel、自定义位置等;

## 2.1.10

1. Nav.startImagePreview(...)由Nav.to()转发;
2. Nav.startImagePreview(...)新增支持非singleTop模式，此模式下必须传递tag；

## 2.1.9

1. Nav.to()新增非SingleTop模式下必须传入唯一tag的toast提示;

## 2.1.8

1. mAppBar文字title非必须；
2. mAppBar新增入参;
3. 完善README;

## 2.1.7

1. ListFooterView新增frozen(...)方法获取固定状态ListFooterView；
2. ListFooterView支持自定义宽度;

## 2.1.6

1. MDialog.tip支持自定义最大内容高度；
2. 新增mScrollConfig，支持添加scrollbar;

## 2.1.5

1. getSystemOverlayStyle新增支持配置底部系统导航栏(不一定存在)样式；
2. MyGet新增记录当前应用系统UI样式属性，默认应用到getSystemOverlayStyle中；

## 2.1.4

1. 调整ImagePreviewPage的默认启动动画为fadeIn；
2. 调整setGlobalStatusBarStyle默认状态栏配色为深底白字；
3.

mAppBar新增systemOverlayStyle入参，可独立配置状态栏配色，如果某个页面的状态栏配色与预想不一致，请先查看页面appBar是否独立配置了systemOverlayStyle或被覆盖；

## 2.1.3

1. 更新harmony_plugin版本，支持ios默认返回；
2. 调整README；
3. 调整example版本号，新增build number;
4. 修改ios下info.plist，增加第三方跳转生命、相册、摄像头权限申请描述；

## 2.1.2

1. 更新harmony_plugin版本；

## 2.1.1

1. 调整ImagePreviewPage的safeArea背景颜色为透明，避免hero动画被遮盖；
2. 修改最低flutter版本为3.3.0;

## 2.1.0

1. 新增PackageUtils获取应用信息；
2. 修改mAppBar默认样式;

## 2.0.5

1. 修改title默认字体大小；
2. 修改mAppBar默认样式;

## 2.0.4

1. 删除Header，由mAppBar替代；
2. mRoot默认添加SafeArea，默认顶部不进行safe处理（会导致设置状态栏颜色无效）；

## 2.0.3

1. 丰富mAppBar、Header的入参；
2. 修改默认appBar高度为56；
3. 修改example默认路由调整动画；

## 2.0.2

1. 新增DataUtils，支持本地数据存储；
2. 修改README，去除项目依赖部分；

## 2.0.1

1. 修改BaseRoutes及example中Routes的继承方法getPages来汇集routes；

## 2.0.0

1. 调整部分基础类与其对应扩展的实现方式；
2. 新增非singleTop方式启动页面，并通过tag获取相同页面不同实例的controller；
3. 新增CommonWebView，支持打开url、html文本、本地html文件和html asset；
4. 新增Header组件；
5. 新增url_launcher pub及使用；
6. 新增mOverSizeScrollView支持view超过指定尺寸可滚动；

## 1.4.0

1. 将TestPage移动到example项目中；
2. 新增CommonWebViewPage，支持快速打开远程html页面;

## 1.3.1

1. 导出ListFooter、新增MySalomonBottomBar；

## 1.3.0

1. 新增ListFooter组件，可用于分页加载；
2. 新增MySalomonBottomBar，由salomonBottomBar修改而来，增加了双击回调，自定义高度；

## 1.2.4

1. 添加静态ImagePreviewLogic；

## 1.2.3

1. 私有化ImagePreviewLogic不必须暴露的属性和方法，只暴露需要暴露的；
2. 通过library、part、part of管理一组类及文件，可通过对类(_ClassName)私有化类并通过part对同组成员可见；

## 1.2.2

1. 修正example中预览下标值；
2. ScrollControllerExt新增toggleScroll方法：如果在顶部，滚动到底部；否则滚动到顶部；

## 1.2.1

1. 修复ImagePreviewPage切换page index后，bottomView和actionView中无法更新相应index状态的bug;
2. ImagePreviewPage新增onPreviewIndexChanged回调；

## 1.2.0

1. ImagePreviewPage新增支持添加右上角的actionView;
2. README修改；

## 1.1.1

1. common_utils新增vibrate震动方法；
2. pub更新;

## 1.1.0

1. pub更新;
2. 基于flutter 3.13.3;

## 0.0.1

* 初始化版本；

## 0.0.2

* 基础调整

1. pub精简；
2. 部分util统一管理，子项目无需引用；
    1. toast；
3. 启动调整；

## 0.0.3

* export调整，一次导入；

## 0.0.4

* 目录调整；

## 0.0.5

* file_utils 日志调整；

## 0.0.6

* aes_utils调整；

## 0.0.7

* 自动发布；

## 0.0.8

* 精简log；

## 0.0.9

* 测试自动发布；

## 0.1.0

* 新增network_utils；

## 0.1.1

* 导出network_utils；

## 0.1.2

1. network_utils新增get、post通用请求方法；
2. 简化log格式；

## 0.1.3

1. 网络请求日志格式调整；

## 0.1.4

1. 更新Trs；
2. 网络请求实例初始化不自动发起；

## 0.1.5

1. 新增通用转圈；

## 0.1.6

1. 调整通用转圈样式；

## 0.1.7

1. 调整通用转圈样式；

## 0.1.8

1. 切换日志输出模式，由Get.log()输出，去除前缀“I/flutter (29368):”；

## 0.1.9

1. 调整日志格式；
2. 依赖项目中Image.asset()必须传package，子项目引用依赖中的资源也需要；
3. 调整assets目录；

## 0.2.0

1. 新增example项目，方便lib自身测试；
2. 调整BaseDimens.dStatusBarHeight值的获取方式；
3. 调整ImagePreview样式；
4. 调整log样式；

## 0.2.1

1. 调整ImagePreview支持显示文字；

## 0.2.2

1. 调整ImagePreview支持显示文字，支持修改文字及背景颜色；
2. 新增mFadeInView，动画显示View；

## 0.2.3

1. 调整ImagePreview支持显示文字，参数调整；

## 1.0.0

1. 完善README，新增英文版本（机器翻译）；
2. 去掉部分警告；

## 1.0.1

1. 修改README;

## 1.0.2

1. 修改 README;
2. 升级 pub 'permission_handler';
3. 修改license；

## 1.0.3

1. 修复mFadeInView不显示的bug;
2. 调整ImagePreview页面中底部ui布局;

## 1.0.4

1. 更新日志格式;

## 1.0.5

1. 修复ImagePreviewPage hero中image显示动画闪动的问题;
2. 修改mLoadImageView加载成功动画仅在异步加载成功时显示；

## 1.0.6

1. 删除ImagePreviewPage中无用参数;
2. 默认开启mLoadImageView加载成功动画；

## 1.0.7

1. mLoadImageView支持添加背景颜色;
2. mLoadImageView支持设置网络图片超时时间;

## 1.0.8

1. 修改dio默认连接超时时间;
2. common_utils新增doDelayOn、doInterval方法；

## 1.0.9

1. mLoadImageView默认无背景颜色;
2. 修复api日志格式错误；

## 1.0.10

1. 新增KeepAliveWrapper，保持TabBarView、ViewPager状态；
2. 新增GetTicker，支持创建TabController；

## 1.0.11

1. 导出；