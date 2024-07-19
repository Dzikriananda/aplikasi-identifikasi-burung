import 'dart:typed_data';

import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/history_cache/history_cache.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/data/repository/bird_repository.dart';
import 'package:get/get.dart';

import '../core/classes/enum.dart';

class HistoryScreenViewModel extends GetxController {
  BirdRepository repository = locator<BirdRepository>();
  AuthRepository authRepository = locator<AuthRepository>();
  Status status = Status.loading;
  BaseResponse? data;

  bool get isError => (status == Status.error);
  bool get isLoading => (status== Status.loading);
  bool get isEmpty => (status== Status.empty);


  @override
  void onInit() {
    super.onInit();
    configureList();
  }

  void deleteHistory() {
    repository.deleteAll();
  }

  void configureList() async {
    status = Status.loading;
    update();
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
    update();
  }

  Future<void> addHistoryCache(Uint8List data, int id) async {
    repository.addHistoryCache(data, id);
    update();
  }

  Future<Uint8List?> getCachePreviewImage(int id) async {
    Uint8List? imgCache = await repository.readHistoryCache(id);
    return imgCache;
  }

  Future<Uint8List?> getPreviewImage(String id) async {
    BaseResponse<dynamic> result = await repository.getPredictionHistoryImage(id);
    if(result.statusCode == 200) {
      return result.data;
    } else {
      return null;
    }
  }
}