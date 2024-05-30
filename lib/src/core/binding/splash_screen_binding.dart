import 'package:bird_guard/src/viewmodel/splash_screen_viewmodel.dart';
import 'package:get/get.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenViewModel());
  }
}