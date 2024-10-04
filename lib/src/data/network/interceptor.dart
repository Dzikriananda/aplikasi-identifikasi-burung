import 'package:dio/dio.dart';

class ApiClientInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    print('REQUEST DATA [${options.data}] => PATH: ${options.path}');
    print('REQUEST DATA [${options.data.toString()}] => PATH: ${options.path}');
    print('REQUEST HEADERS [${options.headers}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    // print(
    //   'RESPONSE DATA => ${response.data}',
    // );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    print(
      'ERROR[${err.response?.statusMessage}] => PATH: ${err.requestOptions.path}',
    );
    // print(
    //   'ERROR DATA => [${err.response?.data}]}',
    // );
    return super.onError(err, handler);
  }
}