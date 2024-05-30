import 'package:get/get.dart';

import '../../viewmodel/login_screen_viewmodel.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenViewModel());
  }
}