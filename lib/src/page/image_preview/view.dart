import 'dart:math';

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreviewPage extends StatelessWidget {
  /// 根据url、index生成hero tag
  static String generateHeroTag(String url, int index) {
    return '$url--$index';
  }

  // 默认显示下标
  int defaultIndex = 0;

  // 图片源
  List<String> imgList = [];

  // 底部自定义视图
  Widget? bottomView;

  // 点击图片关闭预览
  bool enableTapImgClose = true;

  // 左上角返回按钮
  bool closeBtnVisible = true;

  // hero过渡动画
  bool enableHeroTag = true;

  // 自定义图片heroTag
  List<String>? heroTags;

  // 是否允许拖动图片关闭预览
  bool enableSlideOutPage = true;
  Color? imgBgColor;
  double imgBgOpacityBase = 1.0;
  Color? pageBgColor;

  // 页面padding
  EdgeInsets? pagePadding;
  Decoration? pageDecoration;

  // 让bottomView独立于image，放在页面底部
  bool splitBottomView = false;

  ImagePreviewPage({
    Key? key,
    this.defaultIndex = 0,
    required this.imgList,
    this.bottomView,
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
  }) : super(key: key) {
    assert(imgList.isNotEmpty);
    assert(defaultIndex >= 0 && defaultIndex < imgList.length);

    logic.curIndex(defaultIndex);
    imgBgColor ??= BaseColors.cBlack;
    logic.imgList(imgList);
  }

  final logic = Get.put(ImagePreviewLogic());
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
    return mRoot(
      child: Scaffold(
        backgroundColor: pageBgColor,
        body: Padding(
          padding: pagePadding ?? EdgeInsets.zero,
          child: Stack(
            children: [
              buildPreviewView(),
              closeBtnVisible
                  ? Obx(
                      () => logic.isSliding.value
                          ? const SizedBox.shrink()
                          : Positioned(
                              left: 4,
                              top: BaseDimens.dStatusBarHeight,
                              child: FloatingActionButton(
                                onPressed: () {
                                  logic.close();
                                },
                                backgroundColor: BaseColors.cBlackTrans,
                                child: const Icon(Icons.arrow_back_ios_new_outlined),
                              ),
                            ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  /// 图片播放器
  Widget buildPreviewView() {
    return splitBottomView
        ? Column(
            children: [
              Flexible(
                child: Stack(
                  children: [
                    buildImageView(),
                    buildIndicatorView(),
                  ],
                ),
              ),
              mDividerH(height: 8),
              buildBottomView(),
            ],
          )
        : Stack(
            children: [
              buildImageView(),
              buildIndicatorView(),
            ],
          );
  }

  Widget buildIndicatorView() {
    // 初始创建时，肯定显示
    logic.isSliding(false);
    return Obx(
      () => logic.isSliding.value
          ? const SizedBox.shrink()
          : Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    (bottomView != null && logic.imgList.length > 1 && !splitBottomView) ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                children: [
                  Obx(
                    () => logic.imgList.length > 1
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: mSimpleBoxDecoration(solidColor: BaseColors.cBlackTrans),
                              child: Obx(() {
                                return mText(
                                  msg: "${logic.curIndex.value + 1} / ${logic.imgList.length}",
                                  color: BaseColors.cFontWhite,
                                );
                              }),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                  bottomView != null && !splitBottomView ? Flexible(child: buildBottomView()) : const SizedBox.shrink(),
                ],
              ),
            ),
    );
  }

  Widget buildBottomView() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100),
      child: bottomView!,
    );
  }

  Widget buildImageView() {
    return Container(
      decoration: pageDecoration,
      clipBehavior: pageDecoration == null ? Clip.none : Clip.antiAlias,
      child: Obx(
        () => ExtendedImageGesturePageView.builder(
          itemCount: logic.imgList.length,
          onPageChanged: (i) {
            logic.curIndex(i);
          },
          controller: ExtendedPageController(initialPage: defaultIndex),
          itemBuilder: (ctx, index) {
            String url = logic.imgList[index];
            GlobalKey<ExtendedImageSlidePageState> gk = GlobalKey<ExtendedImageSlidePageState>();

            Widget iv = mLoadImageView(
              url,
              enableSlideOutPage: enableSlideOutPage,
              fit: BoxFit.contain,
              mode: ExtendedImageMode.gesture,
              initGestureConfigHandler: (_) => _gestureConfig,
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
                logic.isSliding(state.isSliding);
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
                        logic.close();
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
