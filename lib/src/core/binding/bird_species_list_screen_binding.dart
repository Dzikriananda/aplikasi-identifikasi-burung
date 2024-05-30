import 'package:bird_guard/src/viewmodel/bird_species_list_screen_viewmodel.dart';
import 'package:get/get.dart';

class BirdSpeciesListScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BirdSpeciesListScreenViewModel());
  }
}