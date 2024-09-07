import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:base_lib_pub_example/page/test/logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  final String? tag;

  const TestPage({super.key, this.tag});

  @override
  Widget build(BuildContext context) {
    final TestLogic logic = Get.find(tag: tag);
    return mRoot(
      child: Scaffold(
        appBar: mAppBar(
          title: BaseTrs.testTitle.tr,
        ),
        body: Container(
          color: Colors.green.withAlpha(100),
          child: Obx(() => Text('${BaseTrs.testTitle.tr} - ${logic.count.value}')),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            logic.count(logic.count.value + 1);

            // Get.find<TestLogic>(tag: 'test1').count.value.logE();
            // Get.find<TestLogic>(tag: 'test2').count.value.logE();
            Get.findLogic<TestLogic>(tag: 'test1')?.count.value.logE();
            Get.findLogic<TestLogic>()?.count.value.logE();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
