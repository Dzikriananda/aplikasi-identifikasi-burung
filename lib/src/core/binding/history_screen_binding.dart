import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:get/get.dart';

class HistoryScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryScreenViewModel());
  }
}