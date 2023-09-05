import 'dart:io';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../const/global_const.dart';
import '../theme/base_colors.dart';
import '../theme/base_dimens.dart';
import '../util/common_utils.dart';

/// Name: common_ui.dart
///
/// Created by Static4u
/// Date : 2023/7/13 11:15

/// 设置全局状态栏样式
void setGlobalStatusBarStyle({
  Color statusBarColor = BaseColors.cTransparent,
  Brightness iconBrightness = Brightness.light,
  Brightness barBrightness = Brightness.light,
}) {
  SystemChrome.setSystemUIOverlayStyle(getStatusBarStyle(
    statusBarColor: statusBarColor,
    iconBrightness: iconBrightness,
    barBrightness: barBrightness,
  ));
}

/// 获得状态栏样式
SystemUiOverlayStyle getStatusBarStyle({
  Color statusBarColor = BaseColors.cTransparent,
  Brightness iconBrightness = Brightness.light,
  Brightness barBrightness = Brightness.light,
}) {
  return SystemUiOverlayStyle.light.copyWith(
    statusBarColor: statusBarColor,
    statusBarIconBrightness: iconBrightness,
    statusBarBrightness: barBrightness,
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

/// 双击退出
Widget mWillPopScope({required Widget child, WillPopCallback? onWillPop}) {
  return WillPopScope(
    onWillPop: onWillPop ?? clickBack,
    child: child,
  );
}

/// 点击空白处关闭键盘
Widget mRoot({required Widget child, WillPopCallback? onWillPop}) {
  return WillPopScope(
    onWillPop: onWillPop ?? clickBack,
    child: GestureDetector(onTap: hideKeyboard, child: child),
  );
}

/// 快速生成根视图
/// SafeArea(GestureDetector(CupertinoScrollbar(SingleChildScrollView)))
Widget mSafeRoot({
  bool clickable = true, // 是否点击空白处隐藏键盘
  bool fullScreenScroll = false, // 是否全屏ScrollView，防止固定布局超出屏幕高度
  bool showScrollbar = false, // 是否显示滚动条
//    double appBarHeight = 0,
//    double tabBarHeight = 0,
  bool isCupertinoStyle = false,
  EdgeInsets? margin,
  required Widget child,
}) {
  var lastChild = isCupertinoStyle ? Material(child: child) : child;
//    var h = max(0, screenContentHeight - appBarHeight - tabBarHeight - (margin != null ? (margin.top + margin.bottom) : 0));
//    i(msg: "safe root height: $h");
  var wInBar = SingleChildScrollView(
    child: Container(margin: margin, child: lastChild),
  );
  var secChild = fullScreenScroll ? (showScrollbar ? CupertinoScrollbar(child: wInBar) : wInBar) : lastChild;
  return SafeArea(
    child: clickable ? GestureDetector(onTap: hideKeyboard, child: secChild) : secChild,
  );
}

Widget mAppBar() {
  return AppBar(elevation: 0);
}

Widget mBackBtn() {
  return IconButton(
    onPressed: () {
      clickBack();
    },
    icon: const Icon(Icons.arrow_back_ios_new),
  );
}

/// 获取普通Text
Widget mText({
  required String msg,
  double fontSize = 16,
  FontWeight weight = FontWeight.normal,
  Color? color,
  TextAlign textAlign = TextAlign.start,
  int? maxLines = 1000,
  TextOverflow overflow = TextOverflow.ellipsis,
  double? lineHeightFactor = 1.3, // 1.3基本保证文字上下居中
  FontStyle fontStyle = FontStyle.normal,
  Color? bgColor,
  TextStyle? style,
}) {
  if (style != null) {
    return Text(msg, textAlign: textAlign, maxLines: maxLines, overflow: overflow, style: style);
  }
  return Text(msg,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
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
  if (minLines > 1) {
    /// 如果是多行输入框，允许主动换行输入
    keyboardType = TextInputType.multiline;
    textInputAction = TextInputAction.newline;
  }
  if (isNumOnly) {
    formatters = [FilteringTextInputFormatter.allow(RegExp(GlobalConst.regexpStrNumber))];
  }
  border ??= borderWidth == 0 ? const Border() : Border(bottom: BorderSide(width: borderWidth, color: BaseColors.cGrayLine));
  if (minLines >= maxLines) {
    maxLines = minLines;
  }

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

bool isLocalImage(String url) => !url.startsWith("http://") && !url.startsWith("https://");

/// 加载网络图片或者本地文件图片
Widget mLoadImageView(
  String url, {
  String placeholderImgPath = GlobalConst.defaultPlaceholderImg,
  String errorImgPath = GlobalConst.defaultErrorImg,
  double placeholderSize = 30,
  double errorSize = 30,
  BoxFit? fit = BoxFit.cover,
  Color borderColor = BaseColors.cGrayLine,
  double borderWidth = 0,
  BoxShape? shape,
  double radius = 0,
  BorderRadius? borderRadius,
  bool enableSlideOutPage = false,
  InitGestureConfigHandler? initGestureConfigHandler,
  ExtendedImageMode mode = ExtendedImageMode.none,
  Widget? loadingWidget,
  double minWidth = 0,
  double minHeight = 0,
  double? compressionRatio,
}) {
  bool isAsset = url.startsWith("assets");
  bool isLocal = isLocalImage(url);

  if (radius != 0) {
    borderRadius = BorderRadius.all(Radius.circular(radius));
  }

  LoadStateChanged stateChanged = _getLoadStateChanged(loadingWidget: loadingWidget, errorSize: errorSize, errorImgPath: errorImgPath);

  Widget iv;
  if (isAsset) {
    iv = ExtendedImage.asset(
      url,
      enableSlideOutPage: enableSlideOutPage,
      initGestureConfigHandler: initGestureConfigHandler,
      mode: mode,
      compressionRatio: compressionRatio,
      clipBehavior: Clip.antiAlias,
      fit: fit,
      shape: shape,
      border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
      borderRadius: borderRadius,
      loadStateChanged: stateChanged,
    );
  }

  iv = isLocal
      ? ExtendedImage.file(
          File(url),
          enableSlideOutPage: enableSlideOutPage,
          initGestureConfigHandler: initGestureConfigHandler,
          mode: mode,
          compressionRatio: compressionRatio,
          clipBehavior: Clip.antiAlias,
          fit: fit,
          shape: shape,
          border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
          borderRadius: borderRadius,
          loadStateChanged: stateChanged,
        )
      : ExtendedImage.network(
          url,
          enableSlideOutPage: enableSlideOutPage,
          initGestureConfigHandler: initGestureConfigHandler,
          mode: mode,
          compressionRatio: compressionRatio,
          clipBehavior: Clip.antiAlias,
          retries: 3,
          fit: fit,
          shape: shape,
          border: borderWidth == 0 ? null : Border.all(color: borderColor, width: borderWidth),
          borderRadius: borderRadius,
          loadStateChanged: stateChanged,
        );
  return ConstrainedBox(
    constraints: BoxConstraints(minHeight: minHeight, minWidth: minWidth),
    child: iv,
  );
}

/// 获取图片加载各阶段展示视图
LoadStateChanged _getLoadStateChanged({
  Widget? loadingWidget,
  double errorSize = 30,
  String errorImgPath = GlobalConst.defaultErrorImg,
}) {
  return (state) {
    switch (state.extendedImageLoadState) {
      case LoadState.loading:
        if (loadingWidget != null) {
          return loadingWidget;
        } else {
          return const Center(child: CupertinoActivityIndicator(radius: 10));
        }
      case LoadState.completed:
        return state.completedWidget;
      case LoadState.failed:
        if (errorSize == 0) {
          return Image.asset(errorImgPath, fit: BoxFit.cover);
        }
        return Center(
          child: SizedBox(width: errorSize, height: errorSize, child: Image.asset(errorImgPath, fit: BoxFit.cover)),
        );
    }
  };
}

/// 头像框
Widget mAvatar({
  required String url,
  required double size,
  bool isLocal = false,
  double borderWidth = 1,
  Color borderColor = BaseColors.cYellow,
  BoxShape? shape,
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
          child: mLoadImageView(
            url,
            borderWidth: borderWidth,
            borderColor: borderColor,
            radius: radius,
            shape: shape,
            errorImgPath: GlobalConst.defaultAvatarImg,
            errorSize: size,
            placeholderSize: size,
            placeholderImgPath: GlobalConst.defaultAvatarImg,
          )),
    ],
  );
}

/// 获取简单BoxDecoration
BoxDecoration mSimpleBoxDecoration({
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
  double size = 24,
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
