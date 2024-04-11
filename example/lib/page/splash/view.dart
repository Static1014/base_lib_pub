import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../trans/lang.dart';
import 'logic.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key}) {
    onBuildFinished((duration) {
      logic.start();
    });
  }

  final logic = Get.put(SplashLogic());

  @override
  Widget build(BuildContext context) {
    return mRoot(
      child: Container(
        width: Get.width,
        height: Get.height,
        color: Theme.of(context).colorScheme.surface,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 启动页logo
                mImageView(getImagePath('logo_192'), size: 40.toPx(), enableFadeIn: false),
                // mDividerH(height: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: mText(
                    Trs.appName.tr,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                    textAlign: TextAlign.center,
                    weight: FontWeight.bold,
                  ),
                ),
                // mText(msg: Trs.appName.tr, color: BaseColors.cFontWhite, fontSize: BaseDimens.dFontSizeTitle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
