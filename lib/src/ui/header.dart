import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

/// Name: Header.dart
///
/// Created by Static4u
/// Date : 2023/9/15 10:02
class Header extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;
  final double _height = BaseDimens.dAppBarHeight;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final double titleSpacing;
  final Color backgroundColor;
  final Color titleColor;
  final bool showBack;
  final bool centerTitle;
  final Widget? titleView;
  final Callback? onBackClick;

  const Header(
    this._title, {
    super.key,
    this.showBack = true,
    this.onBackClick,
    this.centerTitle = true,
    this.actions,
    this.bottom,
    this.elevation = 0,
    this.backgroundColor = BaseColors.cPrimaryColor,
    this.titleColor = BaseColors.cFontWhite,
    this.titleView,
    this.titleSpacing = 12,
  });

  @override
  Widget build(BuildContext context) {
    return mAppBar(
      title: _title ?? '',
      titleView: titleView,
      height: _height,
      elevation: elevation,
      titleColor: titleColor,
      backgroundColor: backgroundColor,
      leading: showBack
          ? IconButton(
              onPressed: onBackClick ?? clickBack,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: BaseColors.cFontWhite,
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: centerTitle,
      leadingWidth: showBack ? BaseDimens.dAppBarHeight : 0,
      titleSpacing: titleSpacing,
      actions: actions,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize {
    double height = _height;
    if (bottom?.preferredSize != null) {
      height += bottom!.preferredSize.height;
    }
    return Size.fromHeight(height);
  }
}
