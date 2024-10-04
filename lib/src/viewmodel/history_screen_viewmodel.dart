import 'dart:developer';
import 'dart:typed_data';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:bird_guard/src/data/repository/system_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../core/classes/enum.dart';

class HistoryScreenViewModel extends GetxController {
  BirdRepository repository = locator<BirdRepository>();
  AuthRepository authRepository = locator<AuthRepository>();
  SystemRepository systemRepository = locator<SystemRepository>();

  Status status = Status.loading;
  BaseResponse? data;
  int currentActiveApiCall = 0;
  bool canCallApi = true;
  RxList<String> cancelledApiCall = List<String>.from([]).obs;

  bool get isError => (status == Status.error);
  bool get isLoading => (status== Status.loading);
  bool get isEmpty => (status== Status.empty);

  closeErrorDialog() {
    status = Status.loading;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    repository.clearCancelList();
    configureList();

  }

  @override
  void onClose() {
    canCallApi = false;
    super.onClose();
  }

  Future<int> getCompressionLevel() async {
    int? result = await systemRepository.getImageCompressionLevel();
    return result!;
  }

  void deleteHistory() {
    repository.deleteAll();
  }

  void configureList() async {
    status = Status.loading;
    update();
    try {
      BaseResponse response = await repository.getHistory();
      if(response.status == Status.success) {
        if(response.data!.length!=0) {
          data = response;
          data!.data = List.from(response.data.reversed);
          status = Status.success;
        } else {
          status = Status.empty;
        }
      } else {
        data = response;
        status = Status.error;
      }
    } catch(e) {
      status = Status.error;
    }
    update();
  }

  Future<void> addHistoryCache(Uint8List data, int id) async {
    int? imageCompressionLevel = await systemRepository.getImageCompressionLevel()!;
    await repository.addHistoryCache(data, id,imageCompressionLevel ?? 0);
    update();
  }

  Future<String?> getCachePreviewImage(int id) async {
    String? imgCache = await repository.readHistoryCache(id);
    return imgCache;
  }

  cancelApiCall(String id) {
    repository.cancelApiRequest = id;
    cancelledApiCall.add(id);
    if(currentActiveApiCall>0) {
      currentActiveApiCall--;
    }
  }

  Future<Uint8List?> getPreviewImage(String id) async {
    bool shouldExit = false;

    // Register the callback to update the flag when cancellation is detected
    ever(cancelledApiCall, (value) {
      if (value.contains(id)) {
        cancelledApiCall.remove(id);
        currentActiveApiCall--;
        shouldExit = true;
      }
    });

    while (!shouldExit && canCallApi) {
      if (currentActiveApiCall < 1) {
        try {
          currentActiveApiCall++;
          BaseResponse<dynamic> result = await repository.spawnGetPredictionHistoryImageIsolate(id);
          currentActiveApiCall--;
          if (result.statusCode == 200) {
            return result.data;
          } else {
            return null;
          }
        } catch (e) {
          log('error while $e');
        }
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    log('cancelled for $id');
    return null; // Return null if exited due to cancellation
  }
}