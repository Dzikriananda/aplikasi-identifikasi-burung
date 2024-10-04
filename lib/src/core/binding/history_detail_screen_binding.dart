import 'package:bird_guard/src/viewmodel/detail_screen_viewmodel.dart';
import 'package:bird_guard/src/viewmodel/history_detail_screen_viewmodel.dart';
import 'package:get/get.dart';

class HistoryDetailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryDetailScreenViewModel());
  }
}