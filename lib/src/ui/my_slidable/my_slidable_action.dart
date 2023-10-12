import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

typedef MySlidableActionCallback = void Function(BuildContext context);

/// Name: my_slidable_action.dart
///
/// Created by Static4u
/// Date : 2023/10/12 11:27
class MySlidableAction extends StatelessWidget {
  final MySlidableActionCallback? onPressed;

  /// {@macro slidable.actions.flex}
  final int flex;

  /// {@macro slidable.actions.backgroundColor}
  final Color backgroundColor;

  /// {@macro slidable.actions.foregroundColor}
  final Color? foregroundColor;

  /// {@macro slidable.actions.autoClose}
  final bool autoClose;

  /// An icon to display above the [label].
  final IconData? icon;

  /// The space between [icon] and [label] if both set.
  ///
  /// Defaults to 4.
  final double spacing;

  /// A label to display below the [icon].
  final String? label;

  /// Padding of the OutlinedButton
  final BorderRadius borderRadius;

  /// Padding of the OutlinedButton
  final EdgeInsets? padding;

  const MySlidableAction({
    super.key,
    this.flex = 1,
    this.backgroundColor = BaseColors.cYellow,
    this.foregroundColor = BaseColors.cFontWhite,
    this.autoClose = true,
    required this.onPressed,
    this.icon,
    this.spacing = 4,
    this.label,
    this.borderRadius = BorderRadius.zero,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
        flex: flex,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        label: label,
        icon: icon,
        autoClose: autoClose,
        spacing: spacing,
        borderRadius: borderRadius,
        padding: padding,
        onPressed: onPressed);
  }
}
