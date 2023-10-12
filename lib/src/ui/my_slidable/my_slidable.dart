import 'package:base_lib_pub/src/ui/my_slidable/my_slidable_controller_sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'my_slidable_manager.dart';

/// Name: my_slidable.dart
///
/// Created by Static4u
/// Date : 2023/10/12 11:17
class MySlidable extends StatelessWidget {
  final Widget child;
  final String groupTag;
  final double extentRatio;
  final MySlidableManager? manager;
  final Function? onDismissed;
  final Widget motion;
  final List<Widget> actions;

  const MySlidable({
    super.key,
    required this.child,
    required this.actions,
    this.groupTag = '0',
    this.extentRatio = 0.3,
    this.manager,
    this.onDismissed,
    this.motion = const StretchMotion(),
  }) : assert(onDismissed == null || key != null, 'You must have a key when onDismissed is used.');

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      // 相同的groupTag只能同时打开一个
      groupTag: groupTag,
      endActionPane: ActionPane(
        extentRatio: extentRatio,
        motion: motion,
        dismissible: onDismissed != null
            ? DismissiblePane(
                onDismissed: () {
                  // 侧滑直接删除
                  onDismissed?.call();
                },
              )
            : null,
        children: actions,
      ),
      child: MySlidableControllerSender(
        slideSet: manager?.slideSet,
        child: child,
      ),
    );
  }
}
