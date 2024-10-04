

import 'dart:typed_data';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/bird_species_response.dart';
import 'package:bird_guard/src/data/model/prediction_response/prediction_response.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:get/get.dart';

class BirdDetailScreenViewModel extends GetxController {
  Rxn<BirdSpeciesResponse> data = Rxn();
  Rx<Status> status = Status.started.obs;
  BirdRepository repository = locator<BirdRepository>();
  Rxn<String> imagePath = Rxn();

  @override
  void onInit() async {
    super.onInit();
    data.value = Get.arguments;
    await configureImage();
  }

  Future<Uint8List?> getPreviewImage(String id) async {
    BaseResponse<dynamic> pathResult = await repository.getSpeciesListPreviewImagePath(id);
    BaseResponse<dynamic> result = await repository.getSpeciesListPreviewImage(id,pathResult.data);
    if(result.statusCode == 200) {
      return result.data;
    }
  }
  Future<void> configureImage() async {
    status.value = Status.loading;
    String? cache = await getCachePreviewImage(data.value!.id!);
    if(cache==null) {
      Uint8List? dataImage = await getPreviewImage(data.value!.id!.toString());
      if(dataImage!=null) {
        addSpeciesListCache(dataImage, data.value!.id!);
        String? path = await getCachePreviewImage(data.value!.id!);
        imagePath.value = path;
        status.value = Status.success;
      } else {
        status.value = Status.error;
      }
    } else {
      imagePath.value = cache;
      status.value = Status.success;
    }
  }

  Future<String?> getCachePreviewImage(int id) async {
    String? imgCachePath = await repository.readBirdSpeciesListCache(id);
    return imgCachePath;
  }

  Future<void> addSpeciesListCache(Uint8List data, int id) async {
    await repository.addSpeciesListCache(data, id);
  }


}