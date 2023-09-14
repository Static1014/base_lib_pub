import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('base_lib_pub example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
              },
              child: buildImage('https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png', 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage(String url, int index) {
    return Card(
      child: Stack(
        children: [
          Hero(
            tag: ImagePreviewPage.generateHeroTag(url, 0),
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
