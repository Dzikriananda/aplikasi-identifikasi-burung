import 'package:bird_guard/src/viewmodel/detail_screen_viewmodel.dart';
import 'package:get/get.dart';

class DetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailScreenViewModel());
  }
}