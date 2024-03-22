import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get.dart';

import '../../../theme/my_themes.dart';

class SettingLogic extends GetxController {
  final version = ''.obs;
  final device = ''.obs;

  @override
  void onInit() {
    super.onInit();
    PackageUtils.versionName.then((value) {
      version(value);
    });
    DeviceUtils.getPhoneDisplayName().then((value) {
      device(value);
    });
  }

  void changeTheme() {
    // todo 切换时会一次让所有页面刷新，且有过渡渐变效果。
    // todo 如果当前路由栈中route过多，会在成卡顿
    // todo 当某些特殊widget需要从themeData中手动获取颜色时，须使用Theme.of(context).xxx.xxx获取，Get.theme.xxx.xxx不会立即刷新
    Get.changeTheme(Get.theme.primaryColor != MyThemes.primaryColorRed ? MyThemes.red : MyThemes.light);
  }
}
