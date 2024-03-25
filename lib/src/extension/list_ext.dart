import 'dart:typed_data';

import 'package:base_lib_pub/base_lib_pub.dart';

/// Name: list_ext.dart
///
/// Created by Static4u
/// Date : 2024/3/25 15:15
extension ExtList on List<int> {
  String toStringData() {
    return String.fromCharCodes(Uint8List.fromList(this));
  }
}

extension SwappableList<E> on List<E> {
  /// 交换位置
  bool swap(int first, int second) {
    if (first < 0 || first >= length) {
      'The first index is illegal, first: $first, length is $length.'.logE(tag: 'SwappableList');
      return false;
    }
    if (second < 0 || second >= length) {
      'The second index is illegal, second: $second, length is $length.'.logE(tag: 'SwappableList');
      return false;
    }

    if (first == second) {
      'Swap the same index, first: $first, second: $second.'.logW(tag: 'SwappableList');
      return false;
    }

    final tmp = this[first];
    this[first] = this[second];
    this[second] = tmp;
    return true;
  }

  /// 取下一个
  E? next(E? current) {
    if (length < 1) {
      return null;
    }
    if (length == 1) {
      return this[0];
    }
    int curIndex = 0;
    if (current != null) {
      curIndex = indexOf(current);
      if (curIndex < 0) {
        // 没找到，取第0个
        return this[0];
      }
    }
    int nextIndex = curIndex + 1;
    if (nextIndex >= length) {
      nextIndex = 0;
    }
    return this[nextIndex];
  }

  /// 取上一个
  E? previous(E? current) {
    if (length < 1) {
      return null;
    }
    if (length == 1) {
      return this[0];
    }
    int curIndex = 0;
    if (current != null) {
      curIndex = indexOf(current);
      if (curIndex < 0) {
        // 没找到，取第0个
        return this[0];
      }
    }
    int nextIndex = curIndex - 1;
    if (nextIndex < 0) {
      nextIndex = length - 1;
    }
    return this[nextIndex];
  }
}
