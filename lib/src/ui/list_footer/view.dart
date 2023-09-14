library list_footer;

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

part 'logic.dart';

class ListFooterView extends StatelessWidget {
  final double height;
  final ListFooterLogic logic;
  final Callback? retryCallback;

  const ListFooterView({
    Key? key,
    this.height = 40,
    required this.logic,
    this.retryCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: height,
      child: Obx(() => switch (logic.state.value) {
            ListFooterState.noMore => mText(
                msg: baseTrs.noMore.tr,
                textAlign: TextAlign.center,
                color: BaseColors.cFontGrayLight,
                fontSize: 14,
              ),
            ListFooterState.loading => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  mProgressIndicator(),
                  mDividerH(width: 4),
                  mText(
                    msg: baseTrs.loading.tr,
                    textAlign: TextAlign.center,
                    color: BaseColors.cFontGrayLight,
                    fontSize: 14,
                  ),
                ],
              ),
            ListFooterState.failed => GestureDetector(
                onTap: retryCallback,
                child: mText(
                  msg: '${logic.failedMsg.value}   ${baseTrs.retry.tr}',
                  textAlign: TextAlign.center,
                  color: BaseColors.cFontGrayLight,
                  fontSize: 14,
                ),
              ),
          }),
    );
  }
}
