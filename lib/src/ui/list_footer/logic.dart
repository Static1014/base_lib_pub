part of list_footer;

enum ListFooterState {
  noMore,
  loading,
  failed,
}

class ListFooterLogic extends GetxController {
  final state = ListFooterState.noMore.obs;
  final failedMsg = ''.obs;
}
