

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:dio/dio.dart';

class ErrorHandler {

  static BaseResponse handleError(DioException e) {
    // print('eror krn : ${e.type}');
    // print('statusCode : ${e.response?.statusCode}');
    // print('data: ${e.response?.data}');
    // print('statusMessage : ${e.response?.statusMessage}');
    if(e.response != null) {
      if(e.response!.statusCode != null) {
        String message = getStatusCodeDescription(e.response!.statusCode!);
        return BaseResponse.fromJson(e.response!.statusCode,message,Status.failed,null);
      } else {
        return BaseResponse.fromJson(null,'Error Because $e',Status.failed,e.response!.data);
      }
    } else if(e.type != DioExceptionType.unknown) {
      String? errorMessage;
      switch (e.type) {
        case DioExceptionType.connectionError: errorMessage = "No Connection!";
        case DioExceptionType.connectionTimeout : errorMessage = "No Connection!";
        case DioExceptionType.receiveTimeout : errorMessage = "No Connection!";
        default : null;
      }
      return BaseResponse.fromJson(null,'$errorMessage!',Status.failed,null);
    } else {
      print('eror krnr $e');
      return BaseResponse.fromJson(null,'$e',Status.failed,null);

    }
  }

  static String getStatusCodeDescription(int status) {
    switch(status) {
      case 409 : return 'Request conflict with the current state of the target resource';
      case 404 : return 'Server Not Found';
      case 400 : return 'Bad Request';
      default : return 'Coba lagi nanti';
    }
  }

}