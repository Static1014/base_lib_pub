part of 'view.dart';

enum ListFooterState {
  noMore,
  loading,
  failed,
}

class ListFooterLogic extends GetxController {
  final _state = ListFooterState.noMore.obs;
  final _msg = ''.obs;

  void change(ListFooterState state, {String? msg}) {
    _state(state);
    _msg(msg ?? '');
  }
}
