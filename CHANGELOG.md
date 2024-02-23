## 3.4.0

- Improved sdk versions: flutter 3.19.1, dart 3.3.0

1. Add the List extension to provide the method of element exchange location;
2. Add the int extension to provide the front fill character method;
3. Modify settings.gradle and build.gradle configurations in example/android.

## 3.3.2

1. Extend overlay_utils/showLoading.

## 3.3.1

1. log_utils/printLog prints the log, and the time is displayed to milliseconds;
2. overlay_utils/showLoading supports empty prompt text;

## 3.3.0

1. Replace WillPopScope with PopScope and adapt the related widgets.
2. Fix the failure of the Cancel button in the commonWebView close dialog.

## 3.2.3

1. Fix the internationalization failure of example/android project, that is, the resConfigs
   configuration in build.gradle must match the configuration in MyTrans;

## 3.2.2

1. image_utils Modified pickImage and added the description of storage and shooting permission
   application and failure.

## 3.2.1

1. example/android/app/build.gradle specified need packaging language resources, to remove
   third-party packages into a variety of languages, only keep this app specified language
   resources;
2. example/android/app/build.gradle specified abiFilters, give up support x86 execution;
3. ScrollControllerExt adds shake() method, which supports shaking on the scroll axis once.

## 3.2.0

1. Add goAppSetting() method in device_utils to route to the application setting page;
2. Modify the permission_utils to improve the process of permission grant;
3. Fix the problem that the application name is not displayed in the recent task list in
   MainActivity;
4. Modify the platform: iOS in the Podfile, from ' 11.0' to ' 12.0';

## 3.1.0

> Base on Flutter 3.16.7, Dart 3.2.4

1. Upgrade wechat_assets_picker: ^9.0.0-dev.2 and wechat_camera_picker: ^4.2.0-dev.3 to adapt
   Flutter 3.16.x to solve the problem that images cannot be displayed normally.
2. Upgrade the global kotlin version to 1.9.22;
3. Modify the default theme style.
4. Fix the error message when the url of common_ui/mImageView parameter is empty. If the url is
   empty, the errorWidget is displayed directly.
5. Upgrade other dependencies：
    1. permission_handler: ^11.1.0 -> ^11.2.0
    2. path_provider: ^2.1.1 -> ^2.1.2
    3. share_plus: ^7.1.0 -> ^7.2.1
    4. webview_flutter: ^4.4.2 -> ^4.4.4
    5. url_launcher: ^6.2.1 -> ^6.2.3

## 3.0.3

1. modify the default theme TabBarTheme of BaseTheme and cancel the dividing line;

## 3.0.2

1. Modify network_utils to support post and get user-defined dio.
2. MImageView support custom httpClient, default globalHttpClient, if globalHttpClient
   uninitialized, use the myExtendedImageHttpClient (default ignore certificate);

## 3.0.1

1. Set the default theme through base_main/baseApp. The default M2 theme style is set.
2. Log out all getx controllers when exiting the application through the base_main/runMyApp default
   Settings;

## 3.0.0

1. Update to Flutter SDK version 3.16.3;
2. Add base_theme and run the defaultTheme command to change the default theme effect to the M2
   theme style.
3. Modify the default theme style of sample.

## 2.9.1

1. Added actionsBeforeExitApp callback in MyGet and executed before common_utils/exitApp.

## 2.9.0

1. Update dart 3.2.1, flutter 3.16.1;
2. Fix the DecoderCallback not found problem in photo_manager dependency after upgrading flutter
   3.16.1;
3. Upgrade pubs;
4. Upgrade android AGP 8.1.3，gradle 8.0；

## 2.8.5

1. When mScrollConfig enables scrollbar, if ScrollView specifies a scrollController, the scrollbar
   must specify the same scrollController.

## 2.8.4

1. MDialog added isVisible Returns whether the dialog is being displayed.

## 2.8.3

1. MDialog adds simpleAnimate.

## 2.8.2

1. mAppBar uses the theme background color by default;

## 2.8.1

1. Add size parameter to mImageView to set size;
2. image_utils modifies pickImage and adds preview mode.

## 2.8.0

1. Add MyExtendedImageProviderWithHttpClient implement custom httpClient ImageProvider, to load
   HTTPS picture resources with the unofficial certificate;
2. Add MyExtendedImageWithHttpClient.network load images, use the default
   network_utils/globalHttpClient?? initHttpClient() loads network images.
3. Replace the ExtendedImage.net work with MyExtendedImageWithHttpClient.net in
   common_ui/mImageView, used to load the unofficial certificate HTTPS image resources;

## 2.7.3

1. ImagePreviewPage supports custom text Widgets;
2. textWidget in ImagePreviewPage supports long automatic scrolling;

## 2.7.2

1. CommonWebViewPage Specifies whether the bottomNav is enabled during initialization. By default,
   the BottomNav is displayed based on actual conditions.
2. CommonWebViewLogic added the function of controlling the bottomNav display when the bottomNav is
   enabled.

## 2.7.1

1. Nav page jumps add the return value;
2. In base_main, the baseBeforeRun and beforeRun of runMyApp are changed to asynchronous functions,
   which can runApp only after the asynchronous execution is complete.

## 2.7.0

1. Add getHttpClient and globalHttpClient to network_utils to obtain a unified network request
   httpClient and implement https certificate verification.
2. Allow http requests;
3. CommonWebViewPage ignores the https certificate.

## 2.6.4

1. Custom mScrollbar uniform style;
2. mScrollConfig uses mScrollbar;

## 2.6.3

1. common_ui added setSystemOverlayVisible to set whether the system status bar and bottom
   navigation bar are visible.

## 2.6.2

1. Add NumExt extension num to implement toAngle and toPx methods;

## 2.6.1

1. The default shape of mImageView is rectangle;
2. Add clipBehavior parameter to mImageView.
3. When setting radius or borderRadius of the mImageView, if the shape is not circle, change it to
   rectangle;
4. example update;

## 2.6.0

1. Integrate and encapsulate the flutter_slidable library. For details, see example/lib/page/home.

## 2.5.1

1. Internationalized application name on android;
2. Internationalized application name and description of iOS permissions request message;
3. Set the LaunchImage and LaunchScreen on the iOS launch page;
4. Extend Double support.toPx() to convert px units;

## 2.5.0

1. Rename mLoadImageView to mImageView.
2. Fixed mImageView cannot display assets normally.
3. Added the method of obtaining the path of assets in common_ui.
4. Optimize the effect of Android launch page in example: full screen with logo;
5. Rename initBaseApp in base_main to runMyApp in base_main.
6. Optimize the initialization sequence in base_main, do not want to be executed after runApp;
7. ImagePreviewPage displays indicator by default;
8. Add width and height parameters to mImageView;

## 2.4.9

1. Fixed the issue that mTextField could not actively wrap lines;

## 2.4.8

1. The default mAppBar title font weight is bold;

## 2.4.7

1. In example, when using url_launcher to open a web page from an external browser, it needs to be
   declared in advance, otherwise the external browser cannot be launched in api30 and above:
    1. Add https (http) to queries in android/app/src/main/AndroidManifest.xml;
    2. Add https (http) to LSApplicationQueriesSchemes in ios/Runner/info.plist;
2. The default minimum height of the message content in MDialog.tip is 0.
3. ImagePreviewPage does not display the bottom index indicator when there is only one element;

## 2.4.6

1. New construction parameter showIndicator is added to ImagePreviewLogic to control whether the
   index indicator is displayed.

## 2.4.5

1. Fix the bug that _curIndex is wrong after ImagePreviewLogic.deleteAt(int) was called;;

## 2.4.4

1. MDialog.tip supports msgPadding;

## 2.4.3

1. MDialog.tip supports custom title and content;
2. example update;

## 2.4.2

1. The web navigation bar at the bottom of the CommonWebViewPage can be controlled by construction
   parameters.

## 2.4.1

1. Replace appBar with appBarBuilder as the input parameter of CommonWebViewPage, and then create
   mAppBar when the target route is created through the callback to avoid Nav.isPopEnable error
   judgment.

## 2.4.0

1. CommonWebViewPage Added WebPageBuilder to support custom page content.
2. Expand WebViewController and add init method for quick initialization; Added the load fast
   loading content.
3. CommonWebViewPageLogic supports explicit and implicit switching of the web navigation bar at the
   bottom.

## 2.3.4

1. CommonWebViewPage supports popGesture;

## 2.3.3

1. The fullscreenDialog parameter can be set when ImagePreviewPage and CommonWebViewPage are
   started.
2. mRoot does not create WillPopScope when onWillPop is not set, or else popGesture will be invalid.

## 2.3.2

1. If imgList is empty when ImagePreviewPage is started, toast prompts.
2. Add Clear ExtendedImage cache.

## 2.3.1

1. url_launcher_utils function call result log output;
2. The ImagePreviewPage does not use safeArea and is displayed in full screen. Avoid occlusion by
   defining bottomPadding;
3. Add an example to the HomePage.

## 2.3.0

1. Export url_launcher_utils: Add the mailto and tel methods. (Configure queries and refer to the
   url_launcher_utils file comments.)
2. String Extended encodeUrl Chinese code;
3. A message indicating that urlOrData is empty is added on the CommonWebViewPage.

## 2.2.0

1. CommonWebViewPage supports userAgent, request method, body, and headers.
2. CommonWebViewPage added a callback to expose the WebViewController of the current page for
   external use (pay attention to the call time of the method, the webView is not drawn when the
   callback is performed).

## 2.1.11

1. toast() added support for custom colors, ToastLevel, and custom locations, etc.;

## 2.1.10

1. Nav.startImagePreview(...) Forwarded by Nav.to();
2. Nav.startImagePreview(...) Added support for non-SingleTOP mode, in which tag must be passed;

## 2.1.9

1. Nav.to() added a toast prompt that must pass a unique tag in non-SingleTop mode;

## 2.1.8

1. mAppBar text title is not required;
2. Added the mAppBar parameter.
3. Improve README;

## 2.1.7

1. ListFooterView added frozen(...) Method to obtain the fixed state ListFooterView;
2. ListFooterView supports custom width;

## 2.1.6

1. MDialog.tip supports custom maximum content height;
2. Add mScrollConfig and support scrollbar.

## 2.1.5

1. getSystemOverlayStyle added support for configuring the bottom system navigation bar (not
   necessarily existing) style;
2. MyGet adds the UI style attribute of the current application system, which is applied to
   getSystemOverlayStyle by default;

## 2.1.4

1. Change the default startup animation of the ImagePreviewPage to fadeIn;
2. Set the default setGlobalStatusBarStyle status bar to white characters with deep background;
3. Add systemOverlayStyle to mAppBar to configure the color of the status bar independently. If the
   color of the status bar of a page is inconsistent with the expected, check whether the appBar of
   the page is configured with systemOverlayStyle independently or is overwritten.

## 2.1.3

1. Update harmony_plugin to support ios default return.
2. Adjust README;
3. Adjust the version number of example and add build number.
4. Modify info.plist in ios to add the description of permission application for third-party skip
   life, album, and camera.

## 2.1.2

1. Update harmony_plugin.

## 2.1.1

1. Adjust the safeArea background color of the ImagePreviewPage to transparent to prevent the hero
   animation from being covered;
2. Change the minimum flutter version to 3.3.0;

## 2.1.0

1. Add PackageUtils to obtain application information.
2. Modify DataUtils.
3. mRoot adds the safeArea background color parameter.
4. Add DeviceUtils to obtain device information.
5. Add harmony_plugin to obtain great information;
6. Adjust the import;

## 2.0.5

1. Change the default font size of title.
2. Modify the default mAppBar style

## 2.0.4

1. Delete Header and replace it with mAppBar.
2. mRoot adds SafeArea by default, and does not handle safe at the top by default (the color of the
   status bar is invalid);

## 2.0.3

1. Specify parameters for the mAppBar and Header.
2. Change the default appBar height to 56.
3. Modify example default route adjustment animation.

## 2.0.2

1. Add DataUtils to support local data storage.
2. Modify README to remove project dependencies;

## 2.0.1

1. Modify getPages of Routes inheritance method in BaseRoutes and example to aggregate routes;

## 2.0.0

1. Adjust the implementation of some base classes and their corresponding extensions;
2. Add a non-SingleTop startup page, and obtain controllers of different instances of the same page through the tag.
3. Add CommonWebView, which supports opening urls, html text, local html files, and html assets.
4. Add the Header component.
5. Add url_launcher pub and use it;
6. Added mOverSizeScrollView support for view scrollable beyond the specified size;

## 1.3.1

1. Export the ListFooter and add the MySalomonBottomBar.

## 1.3.0

1. Add the ListFooter component for page loading.
2. Add MySalomonBottomBar, modified by salomonBottomBar, add double click callback, customize the height;

## 1.2.4

1. Add static ImagePreviewLogic;

## 1.2.3

1. Privatize the properties and methods that ImagePreviewLogic does not have to expose, exposing only those that need to be exposed;
2. Manage a group of classes and files through library, part, and part of. You can privatize the class by _ClassName and make it visible to members of the same group through part;

## 1.2.2

1. Correct the preview index value in example;
2. ScrollControllerExt adds a toggleScroll method: if at the top, scroll to the bottom; Otherwise, scroll to the top;

## 1.2.1

1. Fix the bug where the corresponding index status cannot be updated in bottomView and actionView after ImagePreviewPage switches to page index;
2. Added onPreviewIndexChanged callback to ImagePreviewPage;

## 1.2.0

1. The ImagePreviewPage has added support for adding an actionView in the upper right corner;
2. Update README;

## 1.1.1

1. Common_utils Added vibrate method;
2. pub update;

## 1.1.0

1. pub update;
2. base on flutter 3.13.3;

## 0.0.1

* Initial version;

## 0.0.2

* Base adjustment

1. pub streamlining;
2. Some util unified management, subprojects do not need to reference;
3. toast;
4. Start adjustment;

## 0.0.3

* export adjustment, import once;

## 0.0.4

* Directory adjustment;

## 0.0.5

* file_utils log adjustment;

## 0.0.6

* aes_utils adjustment;

## 0.0.7

* Automatic release;

## 0.0.8

* Thin log;

## 0.0.9

* Test automatic release;

## 0.1.0

* network_utils added;

## 0.1.1

* Export network_utils;

## 0.1.2

1. network_utils adds a common request method for get and post.
2. Simplify the log format.

## 0.1.3

1. Adjust the format of network request logs.

## 0.1.4

1. Update Trs;
2. Network request instance initialization is not automatically initiated.

## 0.1.5

1. New universal turning circle;

## 0.1.6

1. Adjust the universal turning style;

## 0.1.7

1. Adjust the universal turning style;

## 0.1.8

1. Switch the log output mode to Get.log() and remove the prefix "I/flutter (29368):".

## 0.1.9

1. Adjust the log format.
2. Image.asset() in the dependent project must pass the package, and the subproject reference resources in the dependency also needs;
3. Adjust the assets directory.

## 0.2.0

1. Add the example project to facilitate lib testing;
2. Adjust the BaseDimens. DStatusBarHeight value access;
3. Adjust the ImagePreview style;
4. Adjust the log style.

## 0.2.1

1. Adjust ImagePreview to support text display;

## 0.2.2

1. Adjust ImagePreview to support the display of text, support to modify the text and background color;
2. Add mFadeInView, animation display View;

## 0.2.3

1. Adjust the ImagePreview support to display text, parameter adjustment;

## 1.0.0

1. Improve README, add English version (machine translation);
2. Remove some warnings;

## 1.0.1

1. modify README;

## 1.0.2

1. modify README;
2. update pub 'permission_handler';
3. update License;

## 1.0.3

1. fix mFadeInView invisible bug;
2. Adjust the bottom ui layout in the ImagePreview page;

## 1.0.4

1. update log format;

## 1.0.5

1. Fix the image display animation flash issue in ImagePreviewPage hero;
2. Modify the mLoadImageView loading success animation to be displayed only when the asynchronous loading succeeds.

## 1.0.6

1. Delete unnecessary parameters from the ImagePreviewPage.
2. The mLoadImageView loading success animation is enabled by default.

## 1.0.7

1. mLoadImageView supports adding background colors.
2. mLoadImageView supports setting the timeout period for network images.

## 1.0.8

1. Change the default connection timeout period of dio.
2. Add the doDelayOn and doInterval methods in common_utils.

## 1.0.9

1. mLoadImageView has no background color by default.
2. Rectify api log format errors.

## 1.0.10

1. Add KeepAliveWrapper to maintain TabBarView and ViewPager status;
2. Add GetTicker, supporting the creation of TabController;

## 1.0.11

1. export；