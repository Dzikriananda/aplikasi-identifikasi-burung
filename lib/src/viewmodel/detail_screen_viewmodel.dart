import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/prediction_response/prediction_response.dart';
import 'package:get/get.dart';

class DetailScreenViewModel extends GetxController {
  Rxn<BaseResponse<dynamic>> response = Rxn();
  Rxn<BirdSpecies> birdData = Rxn();
  String imagePath = Get.arguments['imagePath'];

  @override
  void onInit() {
    super.onInit();
    response.value = Get.arguments['response'];
    configureList();
  }
  void configureList() {
    PredictionResponse predictData = response.value!.data!;
    predictData.list!.forEach((key, value) {
      if(key == predictData.result) {
        birdData.value = value;
      }
    });
  }


}