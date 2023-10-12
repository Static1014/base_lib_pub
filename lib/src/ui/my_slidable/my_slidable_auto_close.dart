import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Name: my_slidable_auto_close.dart
///
/// Created by Static4u
/// Date : 2023/10/12 11:43
class MySlidableAutoClose extends StatelessWidget {
  final Widget child;

  /// Indicates whether all the [Slidable] within the same group should be
  /// closed when one of the group is opened.
  ///
  /// Defaults to true.
  final bool closeWhenOpened;

  /// Indicates whether all the [Slidable] within the same group should be
  /// closed when one of the group is tapped while one is opened.
  ///
  /// Defaults to true.
  final bool closeWhenTapped;

  const MySlidableAutoClose({
    super.key,
    required this.child,
    this.closeWhenOpened = true,
    this.closeWhenTapped = true,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      closeWhenOpened: closeWhenOpened,
      closeWhenTapped: closeWhenTapped,
      child: child,
    );
  }
}
