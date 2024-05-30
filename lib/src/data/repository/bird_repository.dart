
import 'dart:convert';
import 'dart:io';

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/local_storage/local_storage.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/bird_species_response.dart';
import 'package:bird_guard/src/data/model/detail_model/detail_model.dart';
import 'package:bird_guard/src/data/model/prediction_response/prediction_response.dart';
import 'package:bird_guard/src/data/network/api_client.dart';
import 'package:bird_guard/src/data/network/error_handler.dart';
import 'package:bird_guard/src/data/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BirdRepository {
  ApiClient apiClient = locator<ApiClient>();
  AuthRepository authRepository = locator<AuthRepository>();
  LocalStorage localStorage = locator<LocalStorage>();

  Future<BaseResponse<dynamic>> predict(String imagePath) async {
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
      BaseResponse errorResult = ErrorHandler.handleError(e);
      return errorResult;
    } catch(e){
      late String errorMessage;
      int? errorCode;
      if(token == null) {
        errorMessage = 'Login credential expired, please relogin';
        errorCode = 401;
      }
      return BaseResponse.fromJson(
          errorCode,
          errorMessage,
          Status.failed,
          null
      );
    }
  }

  Future<BaseResponse> getSpeciesListPreviewImage(String id) async {
    String? token = await authRepository.readToken();
    try {
      Response result = await apiClient.getSpeciesListPreviewImage(token!,id);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          result.data
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleError(e);
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
      BaseResponse errorResult = ErrorHandler.handleError(e);
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

  Future<List<DetailModel>?> getHistory() async {
    try {
      var val = await localStorage.readAllObject()..toList();
      List<dynamic> list = val.map((e) => e).toList();
      List<DetailModel> convertedList = List<DetailModel>.from(list);
      return convertedList;
    } catch (e) {
    }
  }

  deleteObject(int id) {
    localStorage.deleteObject(id);
  }

  deleteAll() {
    localStorage.resetDatabase();
  }





}