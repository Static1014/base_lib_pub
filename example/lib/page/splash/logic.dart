import 'package:base_lib_pub/base_lib_pub.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../route/routes.dart';

class SplashLogic extends GetxController {
  void start() {
    goHome();
  }

  void goHome() {
    doDelay(1000, () {
      Nav.replace(Routes.home);
    });
  }
}
