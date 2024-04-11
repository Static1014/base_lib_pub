import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

import '../../const/my_const.dart';
import '../../main_logic.dart';
import '../../trans/lang.dart';
import 'logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key}) {
    onBuildFinished((duration) {});
  }

  final logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return mRoot(
      child: Scaffold(
        appBar: mAppBar(
          title: Trs.setting.tr,
          actions: _buildActions(),
        ),
        body: mScrollConfig(
          scrollBar: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => _buildSettingItem(context, Icons.update_outlined, Trs.checkUpdate.tr, () {
                    // 检查更新
                    MainLogic.to.checkUpdate();
                  }, rightLabel: '${Trs.curVersionPrefix.tr}: v${logic.version}'),
                ),
                _buildSettingItem(context, Icons.feedback_outlined, Trs.feedback.tr, () {
                  // 邮箱反馈意见
                  mailto(target: MyConst.myMail, title: Trs.feedbackTitle.tr, body: '\n${_feedbackSuffix()}').then((value) {
                    if (!value) {
                      toast(Trs.feedbackFailed.tr);
                    }
                  });
                }, rightLabel: MyConst.myMail),
                _buildSettingItem(context, Icons.cleaning_services_sharp, Trs.clearCache.tr, () {
                  // 清理缓存
                  clearExtendedImageCache().then((value) {
                    toast(Trs.clearCacheSuc.tr);
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _feedbackSuffix() {
    return '\n${Trs.curVersionPrefix.tr}: v${logic.version}\n${Trs.curDevicePrefix.tr}: ${logic.device}';
  }

  List<Widget> _buildActions() {
    return [
      // 主题切换
      IconButton(
          onPressed: () {
            logic.changeTheme();
          },
          icon: const Icon(Icons.color_lens)),
      // IconButton(
      //     onPressed: () {
      //       logic.changeTheme();
      //     },
      //     icon: const Icon(Icons.nightlight_round)),
    ];
  }

  Widget _buildSettingItem(BuildContext context, IconData icon, String name, Callback action, {String? rightLabel}) {
    return mInkView(
      onClick: action,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 16),
        width: Get.width,
        height: BaseDimens.dIconBtnHeight,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: const Border(
            bottom: BorderSide(color: BaseColors.cGrayLine, width: 0.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: mText(name))),
            isEmptyOrNull(rightLabel) ? const SizedBox.shrink() : mText(rightLabel!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
