import 'package:flutter/material.dart';

extension GlobalKeyExt on GlobalKey<NavigatorState> {
  /// Get the overlay context
  BuildContext? get overlayContext {
    BuildContext? overlay;
    currentState?.overlay?.context.visitChildElements((element) {
      overlay = element;
    });
    return overlay;
  }
}
