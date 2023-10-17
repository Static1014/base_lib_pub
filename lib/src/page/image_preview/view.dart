library image_preview;

import 'dart:math';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'logic.dart';

/// 定义预览页页面切换回调
typedef OnPreviewIndexChanged = void Function(int index);

/// 自定义文字展示视图
typedef TextViewBuilder = Widget Function(String text);

class ImagePreviewPage extends StatelessWidget {
  /// 根据url、index生成hero tag
  static String generateHeroTag(String url, int index) {
    return '$url--$index';
  }

  // logic tag
  final String? tag;

  // 默认显示下标
  final int defaultIndex;
  final OnPreviewIndexChanged? onPreviewIndexChanged;

  // 图片源
  final List<String> imgList;

  // 文字标识源，当对应index的值为true，imgList对应index的元素不是图片，是文字
  final List<(bool isText, Color? textColor, Color? textBgColor)?>? textTagList;
  final TextViewBuilder? textBuilder;

  // 底部自定义视图
  final Widget? bottomView;
  final Widget? actionView;

  // 点击图片关闭预览
  final bool enableTapImgClose;

  // 是否显示下标指示器
  final bool showIndicator;

  // 左上角返回按钮
  final bool closeBtnVisible;

  // hero过渡动画
  final bool enableHeroTag;

  // 自定义图片heroTag
  final List<String>? heroTags;

  // 是否允许拖动图片关闭预览
  final bool enableSlideOutPage;
  final Color? imgBgColor;
  final double imgBgOpacityBase;
  final Color? pageBgColor;

  // 页面padding
  final EdgeInsets? pagePadding;
  final Decoration? pageDecoration;

  // 让bottomView独立于image，放在页面底部
  final bool splitBottomView;

  ImagePreviewPage({
    Key? key,
    this.defaultIndex = 0,
    this.onPreviewIndexChanged,
    required this.imgList,
    this.textTagList,
    this.bottomView,
    this.actionView,
    this.enableTapImgClose = true,
    this.enableHeroTag = true,
    this.heroTags,
    this.enableSlideOutPage = true,
    this.closeBtnVisible = true,
    this.pagePadding,
    this.pageDecoration,
    this.pageBgColor = BaseColors.cTransparent,
    this.imgBgColor,
    this.imgBgOpacityBase = 1.0,
    this.splitBottomView = false,
    this.tag,
    this.showIndicator = true,
    this.textBuilder,
  }) : super(key: key) {
    assert(imgList.isNotEmpty, 'the size of preview imgList must be over 0');
    // assert(defaultIndex >= 0 && defaultIndex < imgList.length, 'default index should between 0 and the size of imgList');

    var logic = Get.find<ImagePreviewLogic>(tag: tag);
    logic._initPageController(defaultIndex < 0 && defaultIndex >= imgList.length ? 0 : defaultIndex);
    logic._imgList(imgList);
    logic.onPreviewIndexChanged = onPreviewIndexChanged;
  }

  final _gestureConfig = GestureConfig(
    //you must set inPageView true if you want to use ExtendedImageGesturePageView
    inPageView: true,
    initialScale: 1.0,
    maxScale: 5.0,
    animationMaxScale: 6.0,
    initialAlignment: InitialAlignment.center,
  );

  @override
  Widget build(BuildContext context) {
    var logic = Get.find<ImagePreviewLogic>(tag: tag);

    return mRoot(
      safeArea: false,
      child: Scaffold(
        backgroundColor: pageBgColor,
        body: Padding(
          padding: pagePadding ?? EdgeInsets.zero,
          child: Stack(
            children: [
              buildPreviewView(logic),
              closeBtnVisible
                  ? Obx(
                      () => logic._isSliding.value
                          ? const SizedBox.shrink()
                          : Positioned(
                              left: 4,
                              top: BaseDimens.dStatusBarHeight,
                              child: FloatingActionButton(
                                onPressed: () {
                                  logic._close();
                                },
                                backgroundColor: BaseColors.cTransparent,
                                elevation: 0,
                                child: const Icon(Icons.arrow_back_ios_new_outlined),
                              ),
                            ),
                    )
                  : const SizedBox.shrink(),
              _buildActionView(logic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionView(ImagePreviewLogic logic) {
    return actionView != null
        ? Obx(() => logic._isSliding.value
            ? const SizedBox.shrink()
            : Positioned(
                right: 8,
                top: BaseDimens.dStatusBarHeight,
                child: Container(
                  height: BaseDimens.dAppBarHeight,
                  constraints: BoxConstraints(maxWidth: Get.width - 100),
                  alignment: Alignment.centerRight,
                  child: actionView!,
                ),
              ))
        : const SizedBox.shrink();
  }

  /// 图片播放器
  Widget buildPreviewView(ImagePreviewLogic logic) {
    return splitBottomView
        ? Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    buildImageView(logic),
                    buildIndicatorView(logic),
                  ],
                ),
              ),
              mDividerH(height: 8),
              buildBottomView(),
            ],
          )
        : Stack(
            children: [
              buildImageView(logic),
              buildIndicatorView(logic),
            ],
          );
  }

  Widget buildIndicatorView(ImagePreviewLogic logic) {
    // 初始创建时，肯定显示
    logic._isSliding(false);
    return Obx(
      () => logic._isSliding.value
          ? const SizedBox.shrink()
          : Positioned(
              bottom: 8 + (!splitBottomView ? MediaQuery.of(Get.context!).padding.bottom : 0),
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showIndicator
                      ? Obx(
                          () => logic._imgList.length > 1
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: mSimpleBoxDecoration(solidColor: BaseColors.cBlackTrans),
                                    child: Obx(() {
                                      return mText(
                                        msg: "${logic._curIndex.value + 1} / ${logic._imgList.length}",
                                        color: BaseColors.cFontWhite,
                                      );
                                    }),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        )
                      : const SizedBox.shrink(),
                  bottomView != null && !splitBottomView ? Flexible(child: buildBottomView()) : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }

  Widget buildBottomView() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: bottomView!,
    );
  }

  (bool isText, Color? textColor, Color? textBgColor) _isText(int index) {
    var exit = textTagList != null && (textTagList?.length ?? 0) > index;
    if (exit) {
      return textTagList?[index] ?? (false, null, null);
    }
    return (false, null, null);
  }

  Widget buildImageView(ImagePreviewLogic logic) {
    return Container(
      decoration: pageDecoration,
      clipBehavior: pageDecoration == null ? Clip.none : Clip.antiAlias,
      child: Obx(
        () => ExtendedImageGesturePageView.builder(
          itemCount: logic._imgList.length,
          onPageChanged: (i) {
            logic._curIndex(i);
            onPreviewIndexChanged?.call(i);
          },
          controller: logic._epc,
          itemBuilder: (ctx, index) {
            String url = logic._imgList[index];
            GlobalKey<ExtendedImageSlidePageState> gk = GlobalKey<ExtendedImageSlidePageState>();

            (bool isText, Color? textColor, Color? textBgColor) isText = _isText(index);
            Widget iv = isText.$1
                ? _buildText(txt: url, bgColor: isText.$3, textColor: isText.$2)
                : mImageView(
                    url,
                    enableSlideOutPage: enableSlideOutPage,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (_) => _gestureConfig,
                    enableFadeIn: index != defaultIndex,
                  );

            Widget child;
            if (enableHeroTag) {
              String tag = generateHeroTag(url, index);
              if (heroTags != null && heroTags!.isNotEmpty) {
                tag = heroTags![index];
              }
              child = index != defaultIndex
                  ? ExtendedImageSlidePageHandler(
                      child: iv,
                      heroBuilderForSlidingPage: (Widget result) {
                        return Hero(
                          tag: tag,
                          child: result,
                          flightShuttleBuilder: (BuildContext flightContext, Animation<double> animation, HeroFlightDirection flightDirection,
                              BuildContext fromHeroContext, BuildContext toHeroContext) {
                            final Hero hero = (flightDirection == HeroFlightDirection.pop ? fromHeroContext.widget : toHeroContext.widget) as Hero;
                            return hero.child;
                          },
                        );
                      },
                    )
                  // : HeroWidget(
                  //     tag: tag,
                  //     slideType: SlideType.onlyImage,
                  //     slidePageKey: gk,
                  //     child: iv,
                  //   );
                  : Hero(tag: tag, child: iv);
            } else {
              child = iv;
            }

            return ExtendedImageSlidePage(
              key: gk,
              onSlidingPage: (state) {
                logic._isSliding(state.isSliding);
              },
              slidePageBackgroundHandler: (offset, pageSize) {
                Color bg = imgBgColor ?? BaseColors.cBlack;
                return getSlidePageBgColor(offset, pageSize, bg, SlideAxis.both);
              },
              slideAxis: SlideAxis.both,
              slideType: SlideType.onlyImage,
              child: enableTapImgClose
                  ? GestureDetector(
                      onTap: () {
                        gk.currentState!.popPage();
                        logic._close();
                      },
                      child: child,
                    )
                  : child,
            );
          },
        ),
      ),
    );
  }

  Widget _buildText({
    required String txt,
    Color? bgColor,
    Color? textColor,
  }) {
    if (textBuilder != null) {
      return textBuilder!.call(txt);
    } else {
      return Container(
        padding: const EdgeInsets.all(12),
        color: bgColor,
        alignment: Alignment.center,
        child: mOverSizeScrollView(
          showScrollBar: true,
          maxSize: Get.height * 3 / 4,
          children: [
            mText(
              msg: txt * 100,
              color: textColor ?? BaseColors.cFontBlack,
              fontSize: 14,
            ),
          ],
        ),
      );
    }
  }

  Color getSlidePageBgColor(
    Offset offset,
    Size pageSize,
    Color bg,
    SlideAxis pageGestureAxis,
  ) {
    double opacity = 0.0;
    if (pageGestureAxis == SlideAxis.both) {
      opacity = offset.distance / (Offset(pageSize.width, pageSize.height).distance / 2.0);
    } else if (pageGestureAxis == SlideAxis.horizontal) {
      opacity = offset.dx.abs() / (pageSize.width / 2.0);
    } else if (pageGestureAxis == SlideAxis.vertical) {
      opacity = offset.dy.abs() / (pageSize.height / 2.0);
    }
    return bg.withOpacity(imgBgOpacityBase * min(1.0, max(1.0 - opacity, 0.0)));
  }
}
