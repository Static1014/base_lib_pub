import 'dart:io';
import 'dart:ui';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

/// Name: common_ui.dart
///
/// Created by Static4u
/// Date : 2023/7/13 11:15

/// 设置系统状态栏和底部导航栏是否可见
void setSystemOverlayVisible({
  bool isStatusBarVisible = true,
  bool isSysNavigationBarVisible = true,
}) {
  MyGet.isStatusBarVisible = isStatusBarVisible;
  MyGet.isSysNavigationBarVisible = isSysNavigationBarVisible;

  var list = <SystemUiOverlay>[];
  if (isStatusBarVisible) {
    list.add(SystemUiOverlay.top);
  }
  if (isSysNavigationBarVisible) {
    list.add(SystemUiOverlay.bottom);
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: list); //隐藏状态栏，底部按钮栏
}

/// 设置全局状态栏、系统导航栏样式（默认深底白字、黑底白字）
void setGlobalSystemOverlayStyle({
  Color statusBarColor = BaseColors.cTransparent,
  bool isStatusBarIconLight = true, // 深底白字
  Color sysNavigationBarColor = BaseColors.cBlack,
  bool isSysNavigationBarIconLight = true, // 深底白字
}) {
  MyGet.isStatusBarIconLight = isStatusBarIconLight;
  MyGet.statusBarBgColor = statusBarColor;
  MyGet.sysNavigationBarBgColor = sysNavigationBarColor;
  MyGet.isSysNavigationBarIconLight = isSysNavigationBarIconLight;

  SystemChrome.setSystemUIOverlayStyle(getSystemOverlayStyle(
    statusBarColor: statusBarColor,
    isStatusBarIconLight: isStatusBarIconLight,
    sysNavigationBarColor: sysNavigationBarColor,
    isSysNavigationBarIconLight: isSysNavigationBarIconLight,
  ));
}

/// 获得状态栏、系统导航栏样式（默认深底白字、黑底白字）
SystemUiOverlayStyle getSystemOverlayStyle({
  Color? statusBarColor,
  bool? isStatusBarIconLight, // 深底白字
  Color? sysNavigationBarColor,
  bool? isSysNavigationBarIconLight, // 深底白字
}) {
  statusBarColor ??= MyGet.statusBarBgColor;
  isStatusBarIconLight ??= MyGet.isStatusBarIconLight;
  sysNavigationBarColor ??= MyGet.sysNavigationBarBgColor;
  isSysNavigationBarIconLight ??= MyGet.isSysNavigationBarIconLight;

  return isStatusBarIconLight
      ? SystemUiOverlayStyle.light.copyWith(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: sysNavigationBarColor,
          systemNavigationBarIconBrightness: (isSysNavigationBarIconLight) ? Brightness.light : Brightness.dark,
        )
      : SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: sysNavigationBarColor,
          systemNavigationBarIconBrightness: (isSysNavigationBarIconLight) ? Brightness.light : Brightness.dark,
        );
}

/// widget build回调
/// @param firstFrameCallback: 第一帧完成回调
/// @param everyFrameCallback: 第二及以后帧完成回调
void onBuildFinished(FrameCallback firstFrameCallback, {FrameCallback? everyFrameCallback}) {
  WidgetsBinding.instance.addPostFrameCallback(firstFrameCallback);

  if (everyFrameCallback != null) {
    WidgetsBinding.instance.addPersistentFrameCallback(everyFrameCallback);
  }
}

Widget mPopScope({
  bool? canPop,
  PopInvokedCallback? onPopInvoked,
  required Widget child,
}) {
  return PopScope(
      canPop: canPop ?? Nav.isPopEnable(),
      onPopInvoked: onPopInvoked ??
          (didPop) {
            hideKeyboard();

            if (!didPop) {
              if (MyGet.lastTime == null || DateTime.now().difference(MyGet.lastTime!) > const Duration(seconds: 1)) {
                //   // 一秒之内点击两次返回键，提示再次点击退出
                MyGet.lastTime = DateTime.now();
                toast(BaseTrs.exitOnDoubleClick.tr);
              } else {
                exitApp();
              }
            }
          },
      child: child);
}

/// 点击空白处关闭键盘
Widget mRoot({
  required Widget child,
  bool? canPop,
  PopInvokedCallback? popInvokedCallback,
  bool safeArea = true,
  bool safeTop = false,
  bool safeBottom = true,
  bool safeLeft = true,
  bool safeRight = true,
  Color? safeAreaBgColor = BaseColors.cWhite, // 当有safeArea时，safeArea之外的区域需要手动设置背景色，否则会变黑；
}) {
  var cc = GestureDetector(
      onTap: hideKeyboard,
      child: safeArea
          ? Container(
              color: safeAreaBgColor,
              child: SafeArea(
                top: safeTop,
                bottom: safeBottom,
                left: safeLeft,
                right: safeRight,
                child: child,
              ),
            )
          : child);
  return (popInvokedCallback == null && canPop == null && Nav.isPopEnable()) // 没有手动拦截，且能返回，才不添加WillPopScope
      ? cc
      : mPopScope(
          canPop: canPop,
          onPopInvoked: popInvokedCallback,
          child: cc,
        );
}

/// 通过回调，在目标route被创建时再调用mAppBar，避免Nav.isPopEnable判断错误
typedef MAppBarBuilder = PreferredSizeWidget Function();

/// 统一appbar
PreferredSizeWidget mAppBar({
  String title = '',
  bool centerTitle = true,
  Color titleColor = BaseColors.cFontWhite,
  double titleFontSize = BaseDimens.dFontSizeTitle,
  FontWeight titleFontWeight = FontWeight.bold,
  int titleMaxLine = 1,
  double height = 0,
  double? elevation = 0,
  Color? backgroundColor,
  Widget? leading, // 自定义左侧按钮
  Color? backIconColor = Colors.white, // 左侧返回按钮
  bool backEnable = false,
  bool autoBackEnable = true,
  VoidCallback? backPressed,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
  double? titleSpacing,
  double? leadingWidth,
  double? backIconSize = 20,
  Widget? titleView,
  SystemUiOverlayStyle? systemOverlayStyle,
  bool automaticallyImplyLeading = true,
  String? semanticsLabel,
}) {
  if (autoBackEnable) {
    backEnable = Nav.isPopEnable();
  }

  /// 默认返回按钮
  final Widget leadingDefault = IconButton(
    icon: Icon(
      Icons.arrow_back_ios_new,
      color: backIconColor,
      size: backIconSize,
    ),
    onPressed: backPressed ?? clickBack,
  );
  Widget? leadingReal;
  if (leading != null) {
    leadingReal = leading;
  } else if (backEnable || backPressed != null) {
    leadingReal = leadingDefault;
  } else {
    leadingReal = const SizedBox.shrink();
    leadingWidth = 0;
  }
  var bar = AppBar(
    leading: leadingReal,
    elevation: elevation,
    backgroundColor: backgroundColor,
    centerTitle: centerTitle,
    automaticallyImplyLeading: automaticallyImplyLeading,
    title: titleView ??
        mText(
          maxLines: titleMaxLine,
          weight: titleFontWeight,
          msg: title,
          color: titleColor,
          fontSize: titleFontSize,
          semanticsLabel: semanticsLabel,
        ),
    actions: actions,
    bottom: bottom,
    titleSpacing: titleSpacing,
    leadingWidth: leadingWidth,
    systemOverlayStyle: systemOverlayStyle ?? getSystemOverlayStyle(),
  );

  double pHeight = (height != 0 ? height : BaseDimens.dAppBarHeight) + (bottom?.preferredSize.height ?? 0);

  return PreferredSize(preferredSize: Size.fromHeight(pHeight), child: bar);
}

/// 获取普通Text
Widget mText({
  required String msg,
  double fontSize = 15,
  FontWeight weight = FontWeight.normal,
  Color? color,
  TextAlign textAlign = TextAlign.start,
  int? maxLines = 1000,
  TextOverflow overflow = TextOverflow.ellipsis,
  double? lineHeightFactor = 1.3, // 1.3基本保证文字上下居中
  FontStyle fontStyle = FontStyle.normal,
  Color? bgColor,
  TextStyle? style,
  String? semanticsLabel,
}) {
  if (style != null) {
    return Text(
      msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
      semanticsLabel: semanticsLabel,
    );
  }
  return Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      semanticsLabel: semanticsLabel,
      style: TextStyle(
        fontWeight: weight,
        fontSize: fontSize,
        color: color ?? BaseColors.cFontBlack,
        height: lineHeightFactor,
        backgroundColor: bgColor,
        decoration: TextDecoration.none,
        fontStyle: fontStyle,
      ));
}

/// 获取普通输入框
Widget mTextField({
  String? hint,
  int maxLines = 1,
  int minLines = 1,
  IconData? prefixIconData,
  TextEditingController? controller,
  int? maxLength,
  Color iconColor = BaseColors.cPrimaryColor,
  double fontSize = BaseDimens.dFontSizeNormal,
  double paddingHorizontal = 6,
  double paddingVertical = BaseDimens.dPadding, // 可调节输入高度
  bool obscureText = false,
  TextInputAction? textInputAction,
  ValueChanged<String>? onSubmitted,
  FocusNode? focusNode,
  BoxBorder? border,
  double borderWidth = 0.5,
  TextInputType? keyboardType,
  List<TextInputFormatter>? formatters,
  bool isNumOnly = false,
  BoxDecoration? decoration,
  TextAlign textAlign = TextAlign.left,
  OverlayVisibilityMode clearButtonMode = OverlayVisibilityMode.editing,
  bool readOnly = false,
}) {
  if (minLines >= maxLines) {
    maxLines = minLines;
  }
  if (maxLines > 1) {
    /// 如果是多行输入框，允许主动换行输入
    keyboardType = TextInputType.multiline;
    textInputAction = TextInputAction.newline;
  }
  if (isNumOnly) {
    formatters = [FilteringTextInputFormatter.allow(RegExp(GlobalConst.regexpStrNumber))];
  }
  border ??= borderWidth == 0 ? const Border() : Border(bottom: BorderSide(width: borderWidth, color: BaseColors.cGrayLine));

  return CupertinoTextField(
    readOnly: readOnly,
    inputFormatters: formatters,
    keyboardType: keyboardType ?? TextInputType.text,
    maxLines: maxLines,
    minLines: minLines,
    textAlign: textAlign,
    style: TextStyle(fontSize: fontSize, height: 1.2),
    prefix: prefixIconData == null ? null : Padding(padding: const EdgeInsets.only(left: 6), child: Icon(prefixIconData, size: 20, color: iconColor)),
    padding: EdgeInsets.symmetric(
      vertical: paddingVertical,
      horizontal: paddingHorizontal,
    ),
    decoration: decoration ??
        BoxDecoration(
          border: border,
        ),
    controller: controller,
    maxLength: maxLength,
    placeholderStyle: TextStyle(
      color: BaseColors.cFontGrayLight,
      fontSize: fontSize,
    ),
    placeholder: hint,
    clearButtonMode: clearButtonMode,
    obscureText: obscureText,
    textInputAction: textInputAction,
    onSubmitted: onSubmitted,
    focusNode: focusNode,
  );
}

/// 获取共通border
Border mBorder({
  Color borderColor = BaseColors.cGrayLine,
  double width = 0,
  BorderStyle style = BorderStyle.solid,
}) {
  return Border(
    top: BorderSide(
      color: borderColor,
      width: width,
      style: style,
    ),
    bottom: BorderSide(
      color: borderColor,
      width: width,
      style: style,
    ),
    left: BorderSide(
      color: borderColor,
      width: width,
      style: style,
    ),
    right: BorderSide(
      color: borderColor,
      width: width,
      style: style,
    ),
  );
}

BorderSide mBorderSide({
  double width = 0.5,
  Color color = BaseColors.cGrayLine,
  BorderStyle style = BorderStyle.solid,
}) {
  return BorderSide(width: width, color: color, style: style);
}

/// 分割线
Widget mLineH({
  Color color = BaseColors.cGrayLine,
  double width = 1,
}) {
  return mDividerH(color: color, width: width);
}

/// 分割线
Widget mLine({
  Color color = BaseColors.cGrayLine,
  double height = 0.5,
}) {
  return mDivider(color: color, height: height);
}

/// 获取共通Divider
Widget mDivider({
  Color color = BaseColors.cTransparent,
  double height = 8,
}) {
  return Divider(
    color: color,
    height: height,
  );
}

/// 获取共通Divider
Widget mDividerH({
  Color color = BaseColors.cTransparent,
  double height = 20,
  double width = 1.5,
  double margin = 0,
}) {
  return Container(
    color: color,
    height: height,
    width: width,
    margin: EdgeInsets.symmetric(horizontal: margin),
  );
}

/// 通过assets资源路径
String getAssetPath(String name, {String type = "png", String dir = '/'}) {
  return "assets/$dir$name.$type";
}

/// 通过名称拼接assets图片路径
String getImagePath(String imgName, {String type = "png", String dir = 'images/'}) {
  return getAssetPath(imgName, type: type, dir: dir);
}

/// 通过名称拼接assets base_lib_pub路径
String getBaseAssetPath(String name, {String type = "", String dir = ''}) {
  return "${GlobalConst.baseAssetsPrefix}$dir$name.$type";
}

/// 通过名称拼接assets base_lib_pub图片路径
String getBaseImagePath(String imgName, {String type = "png"}) {
  return getBaseAssetPath(imgName, type: type, dir: 'images/');
}

/// 非网络图片即为本地图片
bool isLocalImage(String url) => !url.startsWith("http://") && !url.startsWith("https://");

/// 加载网络图片或者本地文件图片
Widget mImageView(
  String url, {
  double? size,
  double? width,
  double? height,
  String placeholderImgPath = GlobalConst.defaultPlaceholderImg,
  String errorImgPath = GlobalConst.defaultErrorImg,
  double placeholderSize = 30,
  double errorSize = 30,
  BoxFit? fit = BoxFit.cover,
  Color borderColor = BaseColors.cGrayLine,
  Color? bgColor,
  double borderWidth = 0,
  BoxShape? shape = BoxShape.rectangle,
  double radius = 0,
  BorderRadius? borderRadius,
  bool enableSlideOutPage = false,
  InitGestureConfigHandler? initGestureConfigHandler,
  ExtendedImageMode mode = ExtendedImageMode.none,
  Widget? loadingWidget,
  double minWidth = 0,
  double minHeight = 0,
  double? compressionRatio,
  //  当主项目引用的不是自身项目的assets时，必须指定assets的package；base_lib_pub本身引用自身assets也必须
  String? package,
  Widget? errorWidget,
  bool enableFadeIn = true,
  Duration fadeInDuration = const Duration(milliseconds: 600),
  Duration timeLimit = const Duration(seconds: 30),
  Duration timeRetry = const Duration(seconds: 5),
  int retries = 3,
  bool cache = true,
  Clip clipBehavior = Clip.antiAlias,
  HttpClient? httpClient,
  String? semanticLabel,
}) {
  if (size != null && size > 0 && width == null && height == null) {
    width = size;
    height = size;
  }

  Widget iv;
  if (isEmptyOrNull(url)) {
    iv = Center(
      child: SizedBox(
        width: errorSize,
        height: errorSize,
        child: Image.asset(
          errorImgPath,
          semanticLabel: semanticLabel,
          fit: BoxFit.cover,
          package: errorImgPath.startsWith(GlobalConst.baseAssetsPrefix) ? GlobalConst.packageName : package,
        ),
      ),
    );
  } else {
    bool isAsset = url.startsWith("assets");
    bool isLocal = false;
    if (!isAsset) {
      isLocal = isLocalImage(url);
    }
    // '$url - asset: $isAsset, local: $isLocal'.logI();
    if (radius != 0) {
      borderRadius = BorderRadius.all(Radius.circular(radius));
    }
    if (borderRadius != null && shape != BoxShape.circle) {
      // 要想设置圆角，shape必须指定为rectangle，想shape为circle时，圆角无效
      shape = BoxShape.rectangle;
    }

    LoadStateChanged stateChanged = _getLoadStateChanged(
      loadingWidget: loadingWidget,
      errorSize: errorSize,
      errorWidget: errorWidget,
      errorImgPath: errorImgPath,
      package: package,
      enableFadeIn: enableFadeIn,
      fadeInDuration: fadeInDuration,
    );

    if (isAsset) {
      iv = isEmptyOrNull(url)
          ? Center(
              child: SizedBox(
                width: errorSize,
                height: errorSize,
                child: Image.asset(
                  errorImgPath,
                  semanticLabel: semanticLabel,
                  fit: BoxFit.cover,
                  package: errorImgPath.startsWith(GlobalConst.baseAssetsPrefix) ? GlobalConst.packageName : package,
                ),
              ),
            )
          : ExtendedImage.asset(
              url,
              semanticLabel: semanticLabel,
              enableSlideOutPage: enableSlideOutPage,
              initGestureConfigHandler: initGestureConfigHandler,
              mode: mode,
              compressionRatio: compressionRatio,
              clipBehavior: clipBehavior,
              fit: fit,
              shape: shape,
              border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
              borderRadius: borderRadius,
              loadStateChanged: stateChanged,
              package: url.startsWith(GlobalConst.baseAssetsPrefix) ? GlobalConst.packageName : package,
            );
    } else {
      iv = isLocal
          ? ExtendedImage.file(
              File(url),
              semanticLabel: semanticLabel,
              enableSlideOutPage: enableSlideOutPage,
              initGestureConfigHandler: initGestureConfigHandler,
              mode: mode,
              compressionRatio: compressionRatio,
              clipBehavior: clipBehavior,
              fit: fit,
              shape: shape,
              border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
              borderRadius: borderRadius,
              loadStateChanged: stateChanged,
            )
          : MyExtendedImageWithHttpClient.network(
              url,
              semanticLabel: semanticLabel,
              enableSlideOutPage: enableSlideOutPage,
              initGestureConfigHandler: initGestureConfigHandler,
              mode: mode,
              compressionRatio: compressionRatio,
              clipBehavior: clipBehavior,
              retries: retries,
              fit: fit,
              shape: shape,
              border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
              borderRadius: borderRadius,
              loadStateChanged: stateChanged,
              cache: cache,
              timeLimit: timeLimit,
              timeRetry: timeRetry,
              client: httpClient ?? globalHttpClient,
            );
    }
  }
  return Container(
    color: bgColor,
    width: width,
    height: height,
    constraints: BoxConstraints(minHeight: minHeight, minWidth: minWidth),
    child: iv,
  );
}

/// 获取图片加载各阶段展示视图
LoadStateChanged _getLoadStateChanged({
  Widget? loadingWidget,
  Widget? errorWidget,
  double errorSize = 30,
  String errorImgPath = GlobalConst.defaultErrorImg,
  String? package,
  bool enableFadeIn = false,
  Duration fadeInDuration = const Duration(milliseconds: 600),
  String? semanticLabel,
}) {
  return (state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        if (loadingWidget != null) {
          return loadingWidget;
        } else {
          return Center(child: mProgressIndicator());
        }
      case LoadState.completed:
        return enableFadeIn && !state.wasSynchronouslyLoaded
            ? mFadeInView(
                child: state.completedWidget,
                duration: fadeInDuration,
              )
            : state.completedWidget;
      case LoadState.failed:
        if (errorWidget != null) {
          return errorWidget;
        }
        if (errorSize == 0) {
          return Image.asset(
            errorImgPath,
            semanticLabel: semanticLabel,
            fit: BoxFit.cover,
            package: errorImgPath.startsWith(GlobalConst.baseAssetsPrefix) ? GlobalConst.packageName : package,
          );
        }
        return Center(
          child: SizedBox(
              width: errorSize,
              height: errorSize,
              child: Image.asset(
                errorImgPath,
                semanticLabel: semanticLabel,
                fit: BoxFit.cover,
                package: errorImgPath.startsWith(GlobalConst.baseAssetsPrefix) ? GlobalConst.packageName : package,
              )),
        );
    }
  };
}

/// fadeInView
Widget mFadeInView({
  Duration duration = const Duration(milliseconds: 600),
  Duration delay = Duration.zero,
  Tween<double>? tween,
  required Widget child,
}) {
  return PlayAnimationBuilder<double>(
      tween: tween ?? Tween<double>(begin: 0, end: 1),
      duration: duration,
      delay: delay,
      builder: (ctx, opacity, _) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      });
}

/// 头像框
Widget mAvatar({
  required String url,
  required double size,
  bool isLocal = false,
  double borderWidth = 1,
  Color borderColor = BaseColors.cYellow,
  BoxShape? shape,
  String? package,
  String? semanticLabel,
}) {
  shape ??= BoxShape.circle;
  double radius = 0;
  if (shape == BoxShape.circle) {
    radius = size / 2;
  }
  return Stack(
    children: [
      Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: shape, color: BaseColors.cWhite),
      ),
      SizedBox(
          width: size,
          height: size,
          child: mImageView(
            url,
            semanticLabel: semanticLabel,
            borderWidth: borderWidth,
            borderColor: borderColor,
            radius: radius,
            shape: shape,
            errorImgPath: GlobalConst.defaultAvatarImg,
            errorSize: size,
            placeholderSize: size,
            placeholderImgPath: GlobalConst.defaultAvatarImg,
            package: package,
          )),
    ],
  );
}

/// 获取简单BoxDecoration
BoxDecoration mBoxDecoration({
  Color borderColor = BaseColors.cGrayLine,
  double borderWidth = 0,
  BorderStyle borderStyle = BorderStyle.solid,
  double borderRadius = 4,
  Color? solidColor,
  double? elevation,
  DecorationImage? image,
}) {
  return borderWidth == 0
      ? BoxDecoration(
          color: solidColor,
          borderRadius: BorderRadius.circular(borderRadius),
        )
      : BoxDecoration(
          border: mBorder(
            borderColor: borderColor,
            width: borderWidth,
            style: borderStyle,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          color: solidColor,
          image: image);
}

/// 自定义点击波纹的按钮
Widget mInkView({
  /// 当splashShape == BoxShape.circle时，splashRadius为波纹半径，要保证波纹覆盖整个child，需要大于等于圆形直径
  double? splashRadius,
  BoxShape splashShape = BoxShape.rectangle,
  Color? splashColor,
  Color? bgColor,
  Border? border,
  BorderRadius? borderRadius,
  required Callback onClick,
  required Widget child,
}) {
  bool isCircle = splashShape == BoxShape.circle;

  /// 圆形必须传波纹半径
  assert(!(isCircle && splashRadius == null));

  return Material(
    color: BaseColors.cTransparent,
    child: Ink(
      //设置背景
      decoration: BoxDecoration(
        color: bgColor,
        shape: splashShape,
        borderRadius: borderRadius,
        border: border,
      ),
      child: InkResponse(
        borderRadius: isCircle ? BorderRadius.all(Radius.circular(splashRadius ?? 0)) : borderRadius,
        radius: isCircle ? splashRadius : null,
        //水波纹的颜色
        splashColor: splashColor,
        highlightShape: BoxShape.rectangle,
        containedInkWell: true,
        onTap: onClick,
        child: child,
      ),
    ),
  );
}

/// 通用转圈
Widget mProgressIndicator({
  bool isIosStyle = true,
  Color? color,
  double size = 20,
  double strokeWidthInAndroid = 4,
}) {
  return isIosStyle
      ? CupertinoActivityIndicator(
          color: color,
          radius: size / 2,
        )
      : SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            backgroundColor: color,
            strokeWidth: strokeWidthInAndroid,
          ),
        );
}

/// 尺寸超过一定值后可滚动
Widget mOverSizeScrollView({
  required double maxSize,
  required List<Widget> children,
  double minSize = 0,
  Axis scrollDirection = Axis.vertical,
  double? crossSize = double.infinity,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
  bool showScrollBar = false,
  ScrollbarOrientation? scrollbarOrientation,
}) {
  bool isVertical = scrollDirection == Axis.vertical;
  Widget content = mScrollConfig(
    scrollbarOrientation: scrollbarOrientation,
    scrollBar: showScrollBar,
    child: SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: scrollDirection,
      child: Flex(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment,
        direction: scrollDirection,
        children: children,
      ),
    ),
  );
  return Container(
    padding: EdgeInsets.zero,
    width: isVertical ? crossSize : null,
    height: !isVertical ? crossSize : null,
    constraints: isVertical ? BoxConstraints(maxHeight: maxSize, minHeight: minSize) : BoxConstraints(maxWidth: maxSize, minWidth: minSize),
    child: content,
  );
}

/// 自定义scrollConfig，支持添加scrollbar
Widget mScrollConfig({
  ScrollBehavior scrollBehavior = const CupertinoScrollBehavior(),
  bool scrollBar = false,
  ScrollbarOrientation? scrollbarOrientation,
  ScrollController? controller,
  double radius = 2,
  required Widget child,
}) {
  // if (scrollBar && controller != null) {
  //   'There must be the same scrollController between Scrollbar and ScrollView '
  //           'while scrollBar is true and ScrollView has a controller.'
  //       .logW();
  // }
  return ScrollConfiguration(
    behavior: scrollBehavior,
    child: scrollBar
        ? mScrollbar(
            controller: controller,
            radius: radius,
            scrollbarOrientation: scrollbarOrientation,
            child: child,
          )
        : child,
  );
}

/// 自定义scrollbar
Widget mScrollbar({
  double radius = 2,
  ScrollbarOrientation? scrollbarOrientation,
  ScrollController? controller,
  required Widget child,
}) {
  return Scrollbar(
    controller: controller,
    radius: Radius.circular(radius),
    scrollbarOrientation: scrollbarOrientation,
    child: child,
  );
}

/// 通用简易按钮
Widget mButton({
  required VoidCallback onClick,
  String? text,
  double textFontSize = 15,
  Color textColor = BaseColors.cFontWhite,
  FontWeight textWeight = FontWeight.normal,
  EdgeInsets? iconPadding,
  EdgeInsets? textPadding,
  Color? bgColor,
  OutlinedBorder? shape,
  double borderRadius = 8,
  IconData? iconData,
  Icon? icon,
  Color? iconColor,
  double? iconSize = 24,
  double? height = 40,
  double? width,
  double minWidth = 0,
  double minHeight = 0,
  Widget? child,
  String? semanticsLabel,
}) {
  List<Widget> mChildren = [];
  if (icon != null) {
    mChildren.add(icon);
  } else if (iconData != null) {
    mChildren.add(iconPadding != null
        ? Padding(
            padding: iconPadding,
            child: Icon(iconData, size: iconSize, color: iconColor),
          )
        : Icon(iconData, size: iconSize, color: iconColor));
  }
  if (text != null) {
    mChildren.add(textPadding != null
        ? Padding(
            padding: textPadding,
            child: mText(
              msg: text,
              color: textColor,
              weight: textWeight,
              fontSize: textFontSize,
              semanticsLabel: semanticsLabel,
            ),
          )
        : mText(
            msg: text,
            color: textColor,
            weight: textWeight,
            fontSize: textFontSize,
            semanticsLabel: semanticsLabel,
          ));
  }

  Widget content = SizedBox(
    height: height,
    width: width,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: mChildren,
    ),
  );
  Widget box = minHeight > 0 || minWidth > 0
      ? ConstrainedBox(
          constraints: BoxConstraints(minHeight: minHeight, minWidth: minWidth),
          child: content,
        )
      : content;
  return FilledButton(
      onPressed: onClick,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        shape: MaterialStateProperty.all(shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius)))),
      ),
      child: child ?? box);
}
