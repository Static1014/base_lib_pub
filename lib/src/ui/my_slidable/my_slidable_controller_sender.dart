import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Name: my_slidable_controller_sender.dart
///
/// Created by Static4u
/// Date : 2023/10/12 10:20
class MySlidableControllerSender extends StatefulWidget {
  const MySlidableControllerSender({
    Key? key,
    required this.child,
    this.slideSet,
  }) : super(key: key);

  final Widget child;
  final Set<SlidableController>? slideSet;

  @override
  State<MySlidableControllerSender> createState() => _MySlidableControllerSenderState();
}

class _MySlidableControllerSenderState extends State<MySlidableControllerSender> {
  SlidableController? controller;

  @override
  void initState() {
    super.initState();
    controller = Slidable.of(context);
    widget.slideSet?.add(controller!);
  }

  @override
  void dispose() {
    widget.slideSet?.remove(controller!);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
