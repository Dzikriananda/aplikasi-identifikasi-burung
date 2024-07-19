

import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:bird_guard/src/data/model/base_response.dart';
import 'package:dio/dio.dart';

class ErrorHandler {

  static BaseResponse handleDioError(DioException e) {
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
        case DioExceptionType.connectionError: errorMessage = "No Connection";
        case DioExceptionType.connectionTimeout : errorMessage = "No Connection";
        case DioExceptionType.receiveTimeout : errorMessage = "No Connection";
        default : null;
      }
      return BaseResponse.fromJson(null,'$errorMessage',Status.failed,null);
    } else {
      return BaseResponse.fromJson(null,'$e',Status.failed,null);

    }
  }

  // static BaseResponse handleError(Exception e) {
  //   late String errorMessage;
  //   int? errorCode;
  //   if(token == null) {
  //     errorMessage = 'Login credential expired, please relogin';
  //     errorCode = 401;
  //   }
  //   return BaseResponse.fromJson(
  //       errorCode,
  //       errorMessage,
  //       Status.failed,
  //       null
  //   );
  // }

  static String getStatusCodeDescription(int status) {
    switch(status) {
      case 409 : return 'Request conflict with the current state of the target resource';
      case 404 : return 'Server Not Found';
      case 400 : return 'Bad Request';
      case 403 : return 'Forbidden';
      case 401 : return 'Expired credential, please relogin';
      default : return 'Coba lagi nanti';
    }
  }

}