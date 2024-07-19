import 'package:bird_guard/src/viewmodel/bird_detail_screen_viewmodel.dart';
import 'package:get/get.dart';

class BirdDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BirdDetailScreenViewModel());
  }
}