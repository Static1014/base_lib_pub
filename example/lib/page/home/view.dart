import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub_example/page/test/logic.dart';
import 'package:base_lib_pub_example/route/nav_ext.dart';
import 'package:base_lib_pub_example/theme/my_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../route/routes.dart';
import '../../trans/lang.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final logic = Get.put(HomeLogic());
  final MySlidableManager slidableManager = MySlidableManager();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final myThemeData = context.theme.myThemeData;
    return mRoot(
      route: Routes.home,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: mAppBar(
          route: Routes.home,
          title: Trs.appName.tr,
          backEnable: false,
          autoBackEnable: false,
          actions: [
            IconButton(
              onPressed: () {
                Nav.push(Routes.setting);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: FloatingActionButton(
            onPressed: () {
              scrollController.toggleScroll();
            },
            child: Transform.rotate(
              angle: 90.toAngle(),
              child: const Icon(Icons.compare_arrows),
            ),
          ),
        ),
        body: mScrollConfig(
          scrollBar: true,
          controller: scrollController,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  color: myThemeData.record,
                  child: mText('自定义主题属性'),
                ),
                mTextField(hint: '请输入', prefixIconData: Icons.account_circle_rounded),
                FilledButton(
                  onPressed: () {
                    toast('msg');
                  },
                  child: const Text('你好，我是按钮'),
                ),
                FilledButton(
                  onPressed: () {
                    toast('msg');
                  },
                  child: mText('你好，我是按钮'),
                ),
                // _buildTestFunc('定位', () async {
                //   var position = await getLocation();
                //   position.toString().logI();
                //   // "geo:39.11270601,117.2167114".launch();
                //   toast(position.toString());
                // }),
                _buildTestFunc('log colorful', () async {
                  'Info log'.logI();
                  'Warning log'.logW();
                  'Error log'.logE();
                }),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mButton(text: '振动 tap', onClick: Shake.tap),
                    mDividerH(),
                    mButton(text: '振动 error', onClick: Shake.error),
                    mDividerH(),
                    mButton(text: '振动 notify', onClick: Shake.notify),
                  ],
                ),
                _buildTestFunc('振动1000ms, 255, 3', () async {
                  vibrate(duration: 500, repeat: 3);
                }),
                _buildTestFunc('振动2000ms, 1, 3', () async {
                  vibrate(duration: 1000, repeat: 3);
                }),
                _buildTestFunc('振动[100, 200, 100, 200]', () async {
                  vibrate(pattern: [100, 200, 100, 300, 100, 400, 100, 500], intensities: [1, 255]);
                }),
                // _buildTestFunc('打开高德地图导航', () async {
                //   var position = await getLocation();
                //   openAmap(position.longitude, position.latitude);
                // }),
                // _buildTestFunc('打开苹果地图', () async {
                //   var position = await getLocation();
                //   openAppleMap(position.longitude, position.latitude);
                // }),
                IconButton(
                    highlightColor: BaseColors.cBlue,
                    padding: const EdgeInsets.all(8),
                    onPressed: () {
                      logic.tapDialog = MDialog.simpleAnimate(
                          child: GestureDetector(
                        onDoubleTap: () {
                          logic.tapDialog?.hide();
                        },
                        child: InteractiveViewer(
                          maxScale: 4,
                          child: Center(
                            child: mImageView('https://pc.homedot.space/qrcode.png', size: 100),
                          ),
                        ),
                      )).show();
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                      color: BaseColors.cGreen,
                    )),
                mInkView(
                  splashShape: BoxShape.circle,
                  splashRadius: 40,
                  splashColor: BaseColors.cRed,
                  onClick: () {
                    toast('ink');
                  },
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: BaseColors.cBlue,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      showLoading(builder: (hide) {
                        return Container(
                          color: BaseColors.cGreen,
                          width: Get.width / 2,
                          height: Get.width / 2,
                          child: GestureDetector(
                            child: mText('我是自定义loading'),
                            onTap: () {
                              hide();
                            },
                          ),
                        );
                      });
                    },
                    child: mText('自定义loading')),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      pickImage(
                        context,
                        enablePreview: true,
                        selectedList: logic.pickEntity != null ? [logic.pickEntity!] : null,
                      ).then(
                        (list) {
                          if (list.isNotEmpty) {
                            logic.pickEntity = list[0];
                            list[0].file.then((file) {
                              var path = file?.path ?? '';
                              logic.pickUrl(path);
                            });
                          }
                        },
                      );
                    },
                    child: mImageView(logic.pickUrl.value, bgColor: BaseColors.cGrayBg, size: 100),
                  ),
                ),
                mImageView('https://pc.homedot.space/qrcode.png', size: 50),
                // Image(
                //   width: 50,
                //   image: MyExtendedImageProviderWithHttpClient('https://pc.homedot.space/qrcode.png',
                //       httpClient: MyExtendedImageWithHttpClient.myExtendedImageHttpClient),
                // ),
                Obx(
                  () => SizedBox(
                    height: logic.slideOne.value ? 60 : 120,
                    child: MySlidableAutoClose(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            MySlidable(
                              extentRatio: 0.5,
                              manager: slidableManager,
                              actions: [
                                MySlidableAction(
                                    autoClose: false,
                                    icon: Icons.touch_app,
                                    onPressed: (ctx) {
                                      toast('你好1');
                                    }),
                                MySlidableAction(
                                    backgroundColor: BaseColors.cRed,
                                    autoClose: false,
                                    flex: 2,
                                    icon: Icons.touch_app,
                                    onPressed: (ctx) {
                                      toast('你好2');
                                    })
                              ],
                              child: Container(
                                width: double.infinity,
                                height: 60,
                                alignment: Alignment.center,
                                color: Theme.of(context).primaryColor,
                                // color: Theme.of(context).primaryColor,
                                child: mText('你好，我有侧滑菜单1'),
                              ),
                            ),
                            logic.slideOne.value
                                ? const SizedBox.shrink()
                                : MySlidable(
                                    manager: slidableManager,
                                    key: const ValueKey(1),
                                    onDismissed: () {
                                      toast('xxx');
                                      logic.slideOne(true);
                                    },
                                    actions: [
                                      MySlidableAction(
                                          // autoClose: false,
                                          icon: Icons.touch_app,
                                          label: '点我',
                                          spacing: 8,
                                          onPressed: (ctx) {
                                            toast('你好2');
                                          })
                                    ],
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      alignment: Alignment.center,
                                      color: Theme.of(context).primaryColor,
                                      child: mText('你好，我有侧滑菜单2，侧滑够长可直接移除'),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildTestFunc('点我收起上面的侧滑菜单，\n并且恢复被移除的第2个(如果已经移除了)', () {
                  slidableManager.close();
                  logic.slideOne(false);
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mImageView(getImagePath('user'), width: 40, height: 40),
                    mImageView(getBaseImagePath('avatar'), width: 40, height: 40, radius: 12),
                  ],
                ),
                // ExtendedImage.asset('assets/images/user.png'),
                _buildTestFunc('mailto', () {
                  mailto(
                    target: '15022252451@139.com',
                    cc: 'static4u@163.com',
                    bcc: '1225939299@qq.com',
                    title: '标题',
                    body: '我是内容',
                  );
                }),
                _buildTestFunc('tel', () {
                  tel('15022252451');
                }),
                _buildTestFunc('tip id', () {
                  mShowTip(id: '111', title: 'test', msg: '你好啊，我很长', actions: [
                    TextButton(
                        onPressed: () {
                          mShowTip(
                            id: '111',
                            title: 'test',
                            msg: '你好啊，我是同id的dialog',
                          );
                        },
                        child: mText('再来一个'))
                  ]);
                  // mShowTip(
                  //   title: 'test',
                  //   msg: '你好啊，我很长，都装不下了' * 100,
                  // );
                }),
                _buildTestFunc('oversize tip dialog', () {
                  mShowTip(
                    title: 'test',
                    msg: '你好啊，我很长，都装不下了' * 100,
                  );
                }),
                _buildTestFunc('custom dialog', () {
                  mShowTip(
                    title: 'test',
                    titleColor: BaseColors.cRed,
                    contentWidget: Container(
                      constraints: const BoxConstraints(minHeight: 100),
                      alignment: Alignment.center,
                      child: mText('你好啊'),
                    ),
                  );
                }),
                _buildTestFunc('msg padding dialog', () {
                  mShowTip(
                    title: 'test',
                    titleColor: BaseColors.cRed,
                    msg: '你哈哈哈哈',
                    msgPadding: const EdgeInsets.symmetric(vertical: 20),
                  );
                }),
                Obx(
                  () => _buildTestFunc('device info${logic.displayName}${logic.deviceInfo}', () {
                    logic.deviceInfo('');
                    logic.displayName('');

                    DeviceUtils.getPhoneDisplayName().then((value) {
                      logic.displayName('\ndisplay_name: $value\n');
                    });
                    if (GetPlatform.isAndroid) {
                      DeviceUtils.androidInfo.then((value) {
                        // value.toString().logE();
                        logic.deviceInfo('\nandroid设备信息：$value');
                      });
                    } else if (GetPlatform.isIOS) {
                      DeviceUtils.iosInfo.then((value) {
                        logic.deviceInfo('\nios设备信息：$value');
                      });
                    }
                  }),
                ),
                Obx(
                  () => _buildTestFunc('package info${logic.pkgInfo}', () {
                    logic.pkgInfo('');
                    PackageUtils.appName.then((value) {
                      logic.pkgInfo('\napp名称：$value\n');
                    });
                    PackageUtils.pkgName.then((value) {
                      logic.pkgInfo('${logic.pkgInfo.value}包名：$value\n');
                    });
                    PackageUtils.versionName.then((value) {
                      logic.pkgInfo('${logic.pkgInfo.value}版本名称：$value\n');
                    });
                    PackageUtils.versionCode.then((value) {
                      logic.pkgInfo('${logic.pkgInfo.value}版本编号：$value');
                    });
                  }),
                ),
                _buildTestFunc('DataUtils', () async {
                  // DataUtils本地存储
                  DataUtils.set('i1', 1);
                  DataUtils.set('str', '11111');
                  DataUtils.getString('i1').then((value) => value.logE());
                  DataUtils.getString('str').then((value) => value.logE());
                }),
                _buildTestFunc('自定义WebView页面', () {
                  //  自定义页面
                  Nav.startCommonWebView(
                    urlOrData: 'https://www.baidu.com',
                    tag: '自定义WebView页面',
                    pageBuilder: (webLogic, webView, pb) {
                      return mRoot(
                        child: Scaffold(
                          appBar: mAppBar(title: '自定义WebView页面', actions: [
                            IconButton(
                                onPressed: () {
                                  webLogic.toggleBottomNav();
                                },
                                icon: const Icon(Icons.change_circle_outlined))
                          ]),
                          body: Column(
                            children: [
                              pb,
                              Container(
                                height: 100,
                                color: BaseColors.cGreen,
                                width: double.infinity,
                                child: Center(
                                  child: mText('我是一个控件'),
                                ),
                              ),
                              Flexible(child: webView),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
                _buildTestFunc('WebViewPage', () {
                  // 打开多个webview page
                  Nav.startCommonWebView(
                    popConfirm: true,
                    urlOrData: 'https://www.baidu.com',
                    tag: 'web1',
                    title: '百度',
                    onCommonWebViewPageCreate: (webController) {
                      // webController.setBackgroundColor(Colors.red);
                    },
                    // appBarBuilder: () => mAppBar(title: 'title'),
                  );
                  // CommonWebViewPage.start('https://www.bilibili.com', tag: 'web2', title: 'B站');
                  // CommonWebViewPage.start('https://blog.csdn.net/bluewn/article/details/104347506', tag: 'web1', title: '百度');
                }),
                _buildTestFunc('not singleTop（multi same pages with multi same logic instances）', () {
                  // 先启动一个singleTop的
                  Nav.startTest();
                  // 再启动一个非singleTop的
                  Nav.startTest(singleTop: false, tag: 'test1');
                  doDelay(4000, () {
                    Get.findLogic<TestLogic>(tag: 'test1')?.count.value.logE();
                    Get.findLogic<TestLogic>()?.count(1);
                  });
                }),
                _buildTestFuncWithChild(
                    Builder(
                      builder: (ctx) => Obx(
                        () => mText(
                          'Timer on :  ${logic.tick.value}',
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                        ),
                      ),
                    ), () {
                  if (logic.timer?.isActive ?? false) {
                    logic.timer?.cancel();
                    logic.tick(0);
                    return;
                  }
                  logic.timer = doInterval(const Duration(seconds: 1), (timer) {
                    logic.tick(timer?.tick);
                  });
                }),
                _buildTestFunc('toast', () {
                  toast(randomNum(1000).toString() * 10);
                }),
                _buildTestFunc('ImagePreview dialog', () {
                  Nav.startImagePreview(
                    imgList: ['https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'],
                    enableHeroTag: false,
                    enableSlideOutPage: false,
                    enableTapImgClose: false,
                    closeBtnVisible: false,
                    pageBgColor: BaseColors.cBlack.withOpacity(0.6),
                    bgColor: BaseColors.cBlack,
                    bgOpacityBase: 0.44,
                    pagePadding: EdgeInsets.symmetric(vertical: Get.size.height / 4 / 2, horizontal: 40),
                    pageDecoration: mBoxDecoration(borderRadius: 20),
                    bottomView: GestureDetector(
                      onTap: () {
                        Nav.pop();
                      },
                      child: Container(
                        width: double.infinity,
                        color: BaseColors.cGreen,
                        child: mText('点我关闭dialog'),
                      ),
                    ),
                    splitBottomView: true,
                  );
                }),
                _buildTestFunc('ImagePreview', () {
                  Nav.startImagePreview(
                    imgList: [
                      'https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                      'https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                      'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                    ],
                    textTagList: [null, (true, null, null)],
                    defaultIndex: 0,
                    pageBgColor: BaseColors.cTransparent,
                    enableHeroTag: false,
                    bottomView: Container(
                      child: mText('你好啊'),
                    ),
                  );
                }),
                mText('ImagePreview with bottomView and actionView in list'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        logic.index(0);
                        Nav.startImagePreview(
                          imgList: [
                            'https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                            'https://pc.homedot.space/qrcode.png',
                            'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                            'https://t7.baidu.com/it/u=3631608752,3069876728&fm=193&f=GIF',
                          ],
                          textTagList: [null, null, null, (true, BaseColors.cWhite, BaseColors.cGreen)],
                          defaultIndex: 0,
                          pageBgColor: BaseColors.cTransparent,
                          enableHeroTag: true,
                          textBuilder: (txt) => Container(
                            padding: const EdgeInsets.all(12),
                            color: BaseColors.cYellow,
                            alignment: Alignment.center,
                            child: mOverSizeScrollView(
                              showScrollBar: true,
                              maxSize: Get.height * 3 / 4,
                              children: [
                                mText(
                                  txt * 30,
                                  color: BaseColors.cFontWhite,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                          bottomView: GestureDetector(
                            onTap: () {
                              ImagePreviewLogic.to.deleteAt(logic.index.value);
                            },
                            child: mText('删除'),
                          ),
                          onPreviewIndexChanged: (i) {
                            logic.index(i);
                            i.logE(tag: 'change xxxx');
                          },
                          actionView: GestureDetector(
                            onTap: () {
                              logic.list[logic.index.value] = !logic.list[logic.index.value];
                            },
                            child: Obx(
                              () => Icon(logic.list[logic.index.value] ? Icons.check_box : Icons.check_box_outline_blank_outlined),
                            ),
                          ),
                        );
                      },
                      child: buildImage('https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', 0),
                    ),
                    GestureDetector(
                      onTap: () {
                        logic.index(1);
                        // ImagePreviewLogic? previewLogic;
                        Nav.startImagePreview(
                          imgList: [
                            'https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                            'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                          ],
                          textTagList: [null, null, (true, null, null)],
                          defaultIndex: 1,
                          pageBgColor: BaseColors.cTransparent,
                          enableHeroTag: true,
                          singleTop: false,
                          tag: 't1',
                          bottomView: GestureDetector(
                            onTap: () {
                              Get.find<ImagePreviewLogic>().deleteAt(1);
                            },
                            child: mText('你好啊'),
                          ),
                          onPreviewIndexChanged: (i) {
                            logic.index(i);
                          },
                          actionView: GestureDetector(
                            onTap: () {
                              logic.list[logic.index.value] = !logic.list[logic.index.value];
                            },
                            child: Obx(
                              () => Icon(logic.list[logic.index.value] ? Icons.check_box : Icons.check_box_outline_blank_outlined),
                            ),
                          ),
                        );
                        Nav.startImagePreview(
                          imgList: [
                            'https://img1.baidu.com/it/u=22553051,3834724655&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
                            'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                            'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.pnghttps://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.pnghttps://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                          ],
                          textTagList: [null, null, (true, null, null)],
                          defaultIndex: 1,
                          singleTop: false,
                          tag: 't2',
                          pageBgColor: BaseColors.cTransparent,
                          enableHeroTag: true,
                          bottomView: GestureDetector(
                            onTap: () {
                              Get.find<ImagePreviewLogic>().deleteAt(1);
                            },
                            child: mText('你好啊'),
                          ),
                          onPreviewIndexChanged: (i) {
                            logic.index(i);
                          },
                          actionView: GestureDetector(
                            onTap: () {
                              logic.list[logic.index.value] = !logic.list[logic.index.value];
                            },
                            child: Obx(
                              () => Icon(logic.list[logic.index.value] ? Icons.check_box : Icons.check_box_outline_blank_outlined),
                            ),
                          ),
                        );
                      },
                      child: buildImage('https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png', 1),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    logic.footerLogic.change(ListFooterState.failed);
                    // logic.footerLogic.change(ListFooterState.noMore, msg: '啊啊啊，真没了');
                  },
                  child: ListFooterView.frozen(state: ListFooterState.noMore, msg: '点我改变Footer状态'),
                ),
                ListFooterView(
                  tag: 'footer1',
                  defaultNoMoreMsg: '别拉了，到底了',
                  defaultLoadingMsg: '我已经很努力在干活了...',
                  defaultFailedMsg: '完了，出错了，不会扣我钱吧',
                  onListFooterViewCreated: (footerLogic) {
                    logic.footerLogic = footerLogic;
                  },
                  retryCallback: () {
                    logic.footerLogic.change(ListFooterState.noMore);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildImage(String url, int index) {
    return Card(
      child: Stack(
        children: [
          Hero(
            tag: ImagePreviewPage.generateHeroTag(url, index),
            child: SizedBox(
              width: 100,
              height: 100,
              child: mImageView(
                url,
                timeLimit: const Duration(seconds: 2),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                logic.list[index] = !logic.list[index];
              },
              child: Obx(
                () => Icon(logic.list[index] ? Icons.check_box : Icons.check_box_outline_blank_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestFunc(String title, GestureTapCallback? onTap) {
    return _buildTestFuncWithChild(
        Builder(
          builder: (context) => mText(
            title,
            color: Theme.of(context).colorScheme.surface,
            fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
          ),
        ),
        onTap);
  }

  Widget _buildTestFuncWithChild(Widget child, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Card(
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            width: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
