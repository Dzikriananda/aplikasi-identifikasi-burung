import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:get/get.dart';

class SettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SystemController());
  }
}