import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../translation/lang.dart';
import 'logic.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  final logic = Get.put(TestLogic());
  final state = Get.find<TestLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BaseTrs.testTitle.tr),
      ),
      body: Container(
        color: Colors.green.withAlpha(100),
        child: Text(BaseTrs.testTitle.tr),
      ),
    );
  }
}
