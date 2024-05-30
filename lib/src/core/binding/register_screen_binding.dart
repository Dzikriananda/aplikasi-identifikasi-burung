import 'package:get/get.dart';
import '../../viewmodel/register_screen_viewmodel.dart';

class RegisterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterScreenViewModel());
  }
}