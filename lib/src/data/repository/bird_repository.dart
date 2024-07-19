import 'dart:typed_data';

import 'package:bird_guard/src/core/classes/enum.dart';
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
import 'package:dio/dio.dart';

class BirdRepository {
  ApiClient apiClient = locator<ApiClient>();
  AuthRepository authRepository = locator<AuthRepository>();
  LocalStorage localStorage = locator<LocalStorage>();

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

  Future<BaseResponse> getPredictionHistoryImage(String id) async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.getPredictionHistoryImage(token!,id);
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

  Future<Uint8List?> readHistoryCache(int id) async {
    var val = await localStorage.readSingleObject(boxType.history, id.toString());
    if(val!=null) {
      HistoryCache? cache = val;
      return cache?.imageData;
    } else {
      return null;
    }
  }

  Future<Uint8List?> readBirdSpeciesListCache(int id) async {
    var val = await localStorage.readSingleObject(boxType.speciesList, id.toString());
    if(val!=null) {
      SpeciesListCache? cache = val;
      return cache?.imageData;
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
  
  void addHistoryCache(Uint8List data, int id) {
    HistoryCache cache = HistoryCache(id: id, imageData: data);
    localStorage.saveObject(boxType.history,cache);
  }

  addSpeciesListCache(Uint8List data,int id) {
    SpeciesListCache cache = SpeciesListCache(id: id, imageData: data);
    localStorage.saveObject(boxType.speciesList, cache);
  }

  deleteObject(int id) {
    localStorage.deleteObject(id);
  }

  deleteAll() {
    localStorage.deleteCache();
  }





}