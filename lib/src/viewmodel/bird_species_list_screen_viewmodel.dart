
import 'dart:typed_data';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/bird_species_response.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:get/get.dart';

class BirdSpeciesListScreenViewModel extends GetxController {
  BirdRepository repository = locator<BirdRepository>();
  Rx<Status> status = Status.started.obs;
  Rxn<BaseResponse> data = Rxn();

  RxBool get isError => (status.value == Status.error).obs;
  RxBool get isLoading => (status.value == Status.loading).obs;



  @override
  void onInit() {
    super.onInit();
    getSpeciesList();
  }

  Future<Uint8List?> getPreviewImage(String id) async {
    BaseResponse<dynamic> pathResult = await repository.getSpeciesListPreviewImagePath(id);
    BaseResponse<dynamic> result = await repository.getSpeciesListPreviewImage(id,pathResult.data);
    if(result.statusCode == 200) {
      return result.data;
    }
  }



  Future<Uint8List?> getCachePreviewImage(int id) async {
    Uint8List? imgCache = await repository.readBirdSpeciesListCache(id);
    return imgCache;
  }

  Future<void> addSpeciesListCache(Uint8List data, int id) async {
    await repository.addSpeciesListCache(data, id);
  }

  getSpeciesList() async {
    status.value = Status.loading;
    BaseResponse<dynamic> result = await repository.getSpeciesList();
    if(result.status == Status.success) {
      data.value = result;
      status.value = Status.success;
    } else {
      data.value = result;
      // statusMessage = result.message ?? 'Error';
      status.value = Status.error;
    }
  }

}