import 'dart:developer';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/file_manager.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/bird_species_response.dart';
import 'package:bird_guard/src/data/model/history_cache/history_cache.dart';
import 'package:bird_guard/src/data/model/history_response.dart';
import 'package:bird_guard/src/data/model/prediction_response/prediction_response.dart';
import 'package:bird_guard/src/data/model/species_list_cache/species_list_cache.dart';
import 'package:bird_guard/src/data/network/api_client.dart';
import 'package:bird_guard/src/data/network/error_handler.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:bird_guard/src/viewmodel/history_screen_viewmodel.dart';
import 'package:bird_guard/src/viewmodel/system_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BirdRepository {
  static ApiClient apiClient = locator<ApiClient>();
  AuthRepository authRepository = locator<AuthRepository>();
  LocalStorage localStorage = locator<LocalStorage>();
  FileManager fileManager = FileManager();
  ValueNotifier<List<String>> cancelApiList = ValueNotifier<List<String>>([]);
  VoidCallback? onChange;

  set cancelApiRequest(String id) {
    final newList = List<String>.from(cancelApiList.value)..add(id);
    cancelApiList.value = newList;
  }

  clearCancelList() {
    cancelApiList.value = [];
  }

  Future<BaseResponse<dynamic>> predictV2(String imagePath) async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.predict(imagePath,token!);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          PredictionResponse.fromJson(result.data)
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      return errorResult;
    } catch(e){
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = e.toString();
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }
  }

  Future<BaseResponse> getSpeciesListPreviewImagePath(String id) async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.getSpeciesListPreviewImagePath(token!,id);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          result.data[0]
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      return errorResult;
    } catch(e){
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = 'Unknown';
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }

  }

  Future<BaseResponse> getSpeciesListPreviewImage(String id,String path) async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.getSpeciesListPreviewImage(token!,id,path);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          result.data
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      return errorResult;
    } catch(e){
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = 'Unknown';
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }

  }

  Future<BaseResponse> getSpeciesList() async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.getSpeciesList(token!);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          birdSpeciesResponseFromJson(result.data)
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      return errorResult;
    } catch(e){
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = 'Unknown';
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }
  }

  Future<BaseResponse> getSpeciesDetail(String id) async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.getSpeciesDetail(token!,id);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          BirdSpeciesResponse.fromJson(result.data)
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      return errorResult;
    } catch(e) {
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = e.toString();
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }
  }



  Future<BaseResponse> getHistory() async {
    String? token = await authRepository.readToken();
    int userId = await authRepository.getUserId();
    try {
      Response result = await apiClient.getPredictionHistory(userId.toString(), token!);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          historyResponseFromJson(result.data)
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      return errorResult;
    } catch(e) {
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = e.toString();
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }
  }


  //Api call untuk history list image menggunakan isolate dikarenakan
  //terjadi lag saat penampilan gambar dikarenakan library dio performanya
  //jelek saat parsing bytes jika ukuran lebih dari 3mb
  Future<BaseResponse> spawnGetPredictionHistoryImageIsolate(String id) async {
    Isolate? isolate;
    String? token = await authRepository.readToken();
    // onChange = () {
    //   // print('value skrg adalah ${cancelApiList.value}');
    //   if(cancelApiList.value.contains(id)) {
    //     print('api progress : req cancel $id');
    //     // print('value skrg $id adalah ${cancelApiList.value}');
    //     // cancelApiList.value.remove(id);
    //     // print('value after $id adalah ${cancelApiList.value}');
    //     // cancelApiList.removeListener(onChange!);
    //     isolate!.kill(priority: Isolate.immediate);
    //     print('api progress : cancelled $id');
    //     cancelApiList.value.remove(id);
    //     // print('api progress : after cancelled $id');
    //
    //
    //   }
    // };
    // cancelApiList.addListener(onChange!);
    ReceivePort myReceivePort = ReceivePort();
    isolate = await Isolate.spawn(
      getPredictionHistoryImage,
      [id,token!,myReceivePort.sendPort],
    );
    onChange = () {
      if(cancelApiList.value.contains(id)) {
        isolate!.kill(priority: Isolate.immediate);
        cancelApiList.value.remove(id);
        log('kill id $id');
        cancelApiList.removeListener(onChange!);
      }
    };
    cancelApiList.addListener(onChange!);
    BaseResponse response = await myReceivePort.first;
    if(cancelApiList.hasListeners) {
      cancelApiList.removeListener(onChange!);
    }
    return response;
  }

  static Future<void> getPredictionHistoryImage(List<dynamic> args) async {
    String id = args[0];
    String token = args[1];
    SendPort port = args[2];
    try {
      print('api progress : call $id');
      Response result = await ApiClient().getPredictionHistoryImage(token,id);
      BaseResponse res = BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          result.data
      );
      Isolate.exit(port,res);
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleDioError(e);
      Isolate.exit(port,errorResult);
    } catch(e,stacktrace){
      debugPrint('Error at getPredictionHistoryImage : ${stacktrace}');
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      } else {
        errorMessage = 'Unknown';
      }
      BaseResponse res = BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
      Isolate.exit(port,res);
    }

  }

  Future<String?> readHistoryCache(int id) async {
    var val = await localStorage.readSingleObject(boxType.history, id.toString());
    if(val!=null) {
      HistoryCache? cache = val;
      return cache?.imagePath;
    } else {
      return null;
    }
  }

  Future<void> addSpeciesListCache(Uint8List data,int id) async {
    String imagePath = await fileManager.saveImage(data,id.toString(),boxType.speciesList,null);
    SpeciesListCache cache = SpeciesListCache(id: id, imagePath: imagePath);
    localStorage.saveObject(boxType.speciesList, cache);
  }

  Future<String?> readBirdSpeciesListCache(int id) async {
    var val = await localStorage.readSingleObject(boxType.speciesList, id.toString());
    if(val!=null) {
      SpeciesListCache? cache = val;
      return cache?.imagePath;
    } else {
      return null;
    }
  }


  Future<List<HistoryCache>?> readAllHistoryCache() async {
    var val = await localStorage.readAllObject(boxType.history);
    if(val!=null) {
      List<HistoryCache> list = val.cast<HistoryCache>();
      return list;
    } else {
      return null;
    }
  }
  
  Future<void> addHistoryCache(Uint8List data, int id,int imageCompressionLevel) async {
    String imagePath = await fileManager.saveImage(data,id.toString(),boxType.history,imageCompressionLevel);
    HistoryCache cache = HistoryCache(id: id, imagePath: imagePath);
    await localStorage.saveObject(boxType.history,cache);
  }

  deleteObject(int id) {
    localStorage.deleteObject(id);
  }

  deleteAll() {
    localStorage.deleteCache();
  }





}