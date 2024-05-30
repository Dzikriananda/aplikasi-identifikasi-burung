
import 'package:bird_guard/src/core/util/locator.dart';
import 'package:bird_guard/src/data/local/secure_storage/secure_storage.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:bird_guard/src/data/model/login_response.dart';
import 'package:bird_guard/src/data/network/api_client.dart';
import 'package:bird_guard/src/data/network/error_handler.dart';
import 'package:bird_guard/src/route/route_name.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/route_manager.dart';

import '../../core/classes/enum.dart';

class AuthRepository {
  ApiClient apiClient = locator<ApiClient>();
  SecureStorage secureStorage = locator<SecureStorage>();

  Future<BaseResponse> login(Map<String,String> loginCredential) async {
    try {
      Response result = await apiClient.login(loginCredential);
      return BaseResponse.fromJson(
        result.statusCode,
        null,
        Status.success,
        LoginResponse.fromJson(result.data)
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleError(e);
      if(errorResult.statusCode == 400) {
        errorResult.message = 'Wrong Credential!';
      }
      return errorResult;
    } catch(e) {
      return BaseResponse.fromJson(null,'$e',Status.failed,null);
    }
  }

  Future<BaseResponse> register(Map<String,dynamic> registerInfo) async {
    try {
      Response result = await apiClient.register(registerInfo);
      return BaseResponse.fromJson(
          result.statusCode,
          null,
          Status.success,
          LoginResponse.fromJson(result.data)
      );
    } on DioException catch(e) {
      BaseResponse errorResult = ErrorHandler.handleError(e);
      if(errorResult.statusCode == 409) {
        if (e.response != null) {
          errorResult.message = e.response!.data['message'];
        }
      }
      return errorResult;
    } catch(e) {
      return BaseResponse.fromJson(null,'$e',Status.failed,null);
    }
  }

  Future<void> saveToken(String value) async {
    await secureStorage.writeSecureData('token', value);
  }

  Future<String?> readToken() async {
    return await secureStorage.readSecureData('token');
  }

  Future<void> logOut() async {
    await deleteToken();
  }

  Future<void> deleteToken() async {
    return await secureStorage.deleteSecureData('token');
  }
}