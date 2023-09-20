import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub_example/page/test/logic.dart';
import 'package:base_lib_pub_example/route/nav_ext.dart';
import 'package:base_lib_pub_example/translation/lang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return mRoot(
      child: Scaffold(
        appBar: mAppBar(
          title: Trs.appName.tr,
          backEnable: false,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
              _buildTestFunc('WebView', () {
                // 打开多个webview page
                CommonWebViewPage.start(
                  'https://www.baidu.com',
                  tag: 'web1',
                  title: '百度',
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
              _buildTestFuncWithChild(Obx(() => Text('Timer on :  ${logic.tick.value}')), () {
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
                toast('xxx');
              }),
              _buildTestFunc('ImagePreview', () {
                Nav.startImagePreview(
                  imgList: [
                    'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4.jpg',
                    'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4',
                    'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                  ],
                  textTagList: [null, (true, null, null)],
                  defaultIndex: 0,
                  pageBgColor: BaseColors.cTransparent,
                  enableHeroTag: false,
                  bottomView: Container(
                    child: mText(msg: '你好啊'),
                  ),
                );
              }),
              mText(msg: 'ImagePreview with bottomView and actionView in list'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      logic.index(0);
                      Nav.startImagePreview(
                        imgList: [
                          'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4.jpg',
                          'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                          // 'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4',
                        ],
                        textTagList: [null, null, (true, null, null)],
                        defaultIndex: 0,
                        pageBgColor: BaseColors.cTransparent,
                        enableHeroTag: true,
                        bottomView: Container(
                          child: mText(msg: '你好啊'),
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
                    child: buildImage('https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4.jpg', 0),
                  ),
                  GestureDetector(
                    onTap: () {
                      logic.index(1);
                      // ImagePreviewLogic? previewLogic;
                      Nav.startImagePreview(
                        imgList: [
                          'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4.jpg',
                          'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                        ],
                        textTagList: [null, null, (true, null, null)],
                        defaultIndex: 1,
                        pageBgColor: BaseColors.cTransparent,
                        enableHeroTag: true,
                        singleTop: false,
                        bottomView: GestureDetector(
                          onTap: () {
                            Get.find<ImagePreviewLogic>().deleteAt(1);
                          },
                          child: mText(msg: '你好啊'),
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
                      // Nav.startImagePreview(
                      //   imgList: [
                      //     'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4.jpg',
                      //     'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                      //   ],
                      //   textTagList: [null, null, (true, null, null)],
                      //   defaultIndex: 1,
                      //   singleTop: false,
                      //   pageBgColor: BaseColors.cTransparent,
                      //   enableHeroTag: true,
                      //   bottomView: GestureDetector(
                      //     onTap: () {
                      //       Get.find<ImagePreviewLogic>().deleteAt(1);
                      //     },
                      //     child: mText(msg: '你好啊'),
                      //   ),
                      //   onPreviewIndexChanged: (i) {
                      //     logic.index(i);
                      //   },
                      //   actionView: GestureDetector(
                      //     onTap: () {
                      //       logic.list[logic.index.value] = !logic.list[logic.index.value];
                      //     },
                      //     child: Obx(
                      //       () => Icon(logic.list[logic.index.value] ? Icons.check_box : Icons.check_box_outline_blank_outlined),
                      //     ),
                      //   ),
                      // );
                    },
                    child: buildImage('https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png', 1),
                  ),
                ],
              ),
            ],
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
              child: mLoadImageView(
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
    return _buildTestFuncWithChild(Text(title), onTap);
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
