
import 'dart:developer';
import 'dart:typed_data';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/data/network/cancel_token_store.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/data/repository/system_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HistoryDetailScreenViewModel extends GetxController {
  BirdRepository repository = locator<BirdRepository>();
  SystemRepository systemRepository = locator<SystemRepository>();
  Rxn<HistoryResponse> data = Rxn();
  Rx<Status> status = Status.started.obs;
  Rxn<BaseResponse> response = Rxn();
  RxBool hasImage = false.obs;
  RxBool canCallApi = true.obs;

  @override
  void onInit() {
    super.onInit();
    data.value = Get.arguments;
    fetchDetailData();
  }

  Future<void> fetchDetailData() async {
    status.value = Status.loading;
    response.value = await repository.getSpeciesDetail(data.value!.result!);
    if(response.value!.status == Status.success) {
      status.value = Status.success;
    } else {
      status.value = Status.error;
    }
  }

  //cancelnya pake token aja disini
  Future<String?> configureImage() async {
    String? cache = await getCachePreviewImage(data.value!.id!);
    print('telah mengambil cache');
    if(cache==null) {
      print('mengambil dr net');
      Uint8List? dataImage = await getPreviewImage(data.value!.id!.toString());
      if(dataImage!=null) {
        await addHistoryCache(dataImage, data.value!.id!);
        hasImage.value = true;
        print('menyimpan cache');
      }
      String? path = await getCachePreviewImage(data.value!.id!);
      return path;
    } else {
      return cache;
    }
  }

  Future<int> getCompressionLevel() async {
    int? result = await systemRepository.getImageCompressionLevel();
    return result!;
  }


  Future<void> addHistoryCache(Uint8List data, int id) async {
    int? imageCompressionLevel = await systemRepository.getImageCompressionLevel();
    await repository.addHistoryCache(data, id,imageCompressionLevel!);
  }

  Future<String?> getCachePreviewImage(int id) async {
    String? imgCache = await repository.readHistoryCache(id);
    return imgCache;
  }

  cancelApiRequest(String id) async {
    repository.cancelApiRequest = id;
  }

  Future<Uint8List?> getPreviewImage(String id) async {
    BaseResponse<dynamic> result = await repository.spawnGetPredictionHistoryImageIsolate(id);
    if(result.statusCode == 200) {
      return result.data;
    } else {
      return null;
    }
  }

}