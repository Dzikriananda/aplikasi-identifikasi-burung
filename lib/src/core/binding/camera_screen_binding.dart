import 'package:bird_guard/src/viewmodel/camera_screen_viewmodel.dart';
import 'package:get/get.dart';

class CameraScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CameraScreenViewModel());
  }
}