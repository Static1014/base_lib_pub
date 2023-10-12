import 'package:flutter_slidable/flutter_slidable.dart';

/// Name: my_slidable_manager.dart
///
/// Created by Static4u
/// Date : 2023/10/12 11:30
class MySlidableManager {
  final Set<SlidableController> slideSet = <SlidableController>{};

  void close() {
    for (var value in slideSet) {
      value.close();
    }
  }
}
