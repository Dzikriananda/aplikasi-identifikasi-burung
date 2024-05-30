
import 'package:bird_guard/src/core/classes/enum.dart';
import 'package:dio/dio.dart';

class BaseResponse<T> {
  late T? data;
  late String? message;
  late int? statusCode;
  late Status status;

  BaseResponse.fromJson(int? statusCode,String? message, Status status,T? data) {
    this.status = status;
    this.message = message;
    this.data = data;
    this.statusCode = statusCode;
  }
  


}