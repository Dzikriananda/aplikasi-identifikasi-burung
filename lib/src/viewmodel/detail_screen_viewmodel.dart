
import 'dart:ffi';

import 'package:bird_guard/src/core/util/string_util.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/prediction_response/prediction_response.dart';
import 'package:get/get.dart';

class DetailScreenViewModel extends GetxController {
  Rxn<BaseResponse<dynamic>> response = Rxn();
  Rxn<List<Map<String,double>>> predictResult = Rxn();

  String imagePath = Get.arguments['imagePath'];

  @override
  void onInit() {
    super.onInit();
    response.value = Get.arguments['response'];
    // imagePath.value = Get.arguments['response'];
    configureList();
  }


  void configureList() {
    PredictionResponse predictData = response.value!.data!;
    List<MapEntry<String,double>> sortedList = predictData.confidence.entries.toList()..sort((a,b) => a.value.compareTo(b.value));
    var percentageOnly = sortedList.map((e) => e.value).toList();
    var roundedValue = StringUtil.roundValue(percentageOnly);
    List<Map<String,double>> newList = [];
    sortedList.forEach((element) {
      newList.add(
        {StringUtil.configureBirdName(element.key) : element.value}
      );
    });
    for(int i = 0 ; i < newList.length ; i++) {
      newList[i].update(newList[i].keys.first, (value) => roundedValue[i]);
    }
    predictResult.value = newList;
  }

}