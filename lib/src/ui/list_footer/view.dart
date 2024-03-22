library list_footer;

import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

part 'logic.dart';

// 返回当前ListFooterView的ListFooterLogic
typedef OnListFooterViewCreated = Function(ListFooterLogic logic);

class ListFooterView extends StatelessWidget {
  /// 不能切换状态的ListFooterView
  static Widget frozen({
    double height = 40,
    double width = double.infinity,
    required ListFooterState state,
    Callback? retryCallback,
    String? msg,
  }) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: _buildStateView(
        state: state,
        retryCallback: retryCallback,
        msg: msg ?? _getDefaultMsg(state),
      ),
    );
  }

  final double height;
  final double width;
  late final ListFooterLogic logic;
  final Callback? retryCallback;
  final String tag;
  final OnListFooterViewCreated? onListFooterViewCreated;
  final String? defaultNoMoreMsg;
  final String? defaultLoadingMsg;
  final String? defaultFailedMsg;
  final Color? failedColor;

  ListFooterView({
    super.key,
    required this.tag,
    this.height = 40,
    this.width = double.infinity,
    this.retryCallback,
    this.onListFooterViewCreated,
    this.defaultNoMoreMsg,
    this.defaultLoadingMsg,
    this.defaultFailedMsg,
    this.failedColor,
  }) {
    assert(tag.isNotEmpty, 'ListFooterView needs a unique tag for ListFooterLogic.');
    bool existed = Get.isRegistered<ListFooterLogic>(tag: tag);
    // assert(!existed, 'ListFooterView needs a unique tag for ListFooterLogic.');
    if (existed) {
      logic = Get.find<ListFooterLogic>(tag: tag);
    } else {
      logic = Get.put(ListFooterLogic(), tag: tag);
    }
    onListFooterViewCreated?.call(logic);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      child: Obx(
        () => _buildStateView(
          state: logic._state.value,
          retryCallback: retryCallback,
          msg: logic._msg.value,
          width: width,
          height: height,
          defaultNoMoreMsg: defaultNoMoreMsg,
          defaultLoadingMsg: defaultLoadingMsg,
          defaultFailedMsg: defaultFailedMsg,
          failedColor: failedColor,
        ),
      ),
    );
  }

  static String _getDefaultMsg(ListFooterState state) => switch (state) {
        ListFooterState.noMore => BaseTrs.noMore.tr,
        ListFooterState.loading => BaseTrs.loading.tr,
        ListFooterState.failed => BaseTrs.retry.tr,
      };

  static Widget _buildStateView({
    ListFooterState state = ListFooterState.noMore,
    Callback? retryCallback,
    required String msg,
    double? width,
    double? height,
    String? defaultNoMoreMsg,
    String? defaultLoadingMsg,
    String? defaultFailedMsg,
    Color? failedColor,
  }) {
    return switch (state) {
      ListFooterState.noMore => mText(
          msg.isEmpty ? (defaultNoMoreMsg ?? BaseTrs.noMore.tr) : msg,
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
              msg.isEmpty ? (defaultLoadingMsg ?? BaseTrs.loading.tr) : msg,
              textAlign: TextAlign.center,
              color: BaseColors.cFontGrayLight,
              fontSize: 14,
            ),
          ],
        ),
      ListFooterState.failed => GestureDetector(
          onTap: retryCallback,
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            color: BaseColors.cTransparent,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
            child: Builder(
              builder: (ctx) => mText(
                msg.isEmpty ? (defaultFailedMsg ?? BaseTrs.retry.tr) : msg,
                textAlign: TextAlign.center,
                color: failedColor ?? Theme.of(ctx).colorScheme.error,
                fontSize: 14,
              ),
            ),
          ),
        ),
    };
  }
}
