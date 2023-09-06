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
            _buildTestFunc('toast', () {
              toast('xxx');
            }),
            _buildTestFunc('ImagePreview', () {
              Nav.startImagePreview(
                imgList: [
                  'https://static1014.gitee.io/pm_data/gallery/images/1/34d40d52a4.jpg',
                  'https://p7.itc.cn/images01/20200529/7fba45f763c445be964badee248ed321.png',
                ],
                defaultIndex: 0,
                pageBgColor: BaseColors.cTransparent,
                enableHeroTag: false,
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTestFunc(String title, GestureTapCallback? onTap) {
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
            child: Text(title),
          ),
        ),
      ),
    );
  }
}
