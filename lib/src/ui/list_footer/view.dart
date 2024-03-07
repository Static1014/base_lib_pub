library list_footer;

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

part 'logic.dart';

class ListFooterView extends StatelessWidget {
  /// 不能切换状态的ListFooterView
  static Widget frozen({
    double height = 40,
    double width = double.infinity,
    required ListFooterState state,
    Callback? retryCallback,
    String? failedMsg = '',
  }) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: _buildStateView(
        state: state,
        retryCallback: retryCallback,
        failedMsg: failedMsg,
      ),
    );
  }

  final double height;
  final double width;
  final ListFooterLogic logic;
  final Callback? retryCallback;

  const ListFooterView({
    super.key,
    this.height = 40,
    this.width = double.infinity,
    required this.logic,
    this.retryCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Obx(
        () => _buildStateView(
          state: logic.state.value,
          retryCallback: retryCallback,
          failedMsg: logic.failedMsg.value,
        ),
      ),
    );
  }

  static Widget _buildStateView({
    ListFooterState state = ListFooterState.noMore,
    Callback? retryCallback,
    String? failedMsg = '',
  }) {
    return switch (state) {
      ListFooterState.noMore => mText(
          msg: BaseTrs.noMore.tr,
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
              msg: BaseTrs.loading.tr,
              textAlign: TextAlign.center,
              color: BaseColors.cFontGrayLight,
              fontSize: 14,
            ),
          ],
        ),
      ListFooterState.failed => GestureDetector(
          onTap: retryCallback,
          child: mText(
            msg: '$failedMsg   ${BaseTrs.retry.tr}',
            textAlign: TextAlign.center,
            color: BaseColors.cFontGrayLight,
            fontSize: 14,
          ),
        ),
    };
  }
}
