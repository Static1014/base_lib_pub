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