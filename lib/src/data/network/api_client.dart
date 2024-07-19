import 'package:bird_guard/src/core/environment_settings.dart';
import 'package:bird_guard/src/data/network/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentSettings.baseUrl,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 15),
        sendTimeout: Duration(seconds: 5),
        contentType: "application/json",
      ),
    );
    _dio.interceptors.add(ApiClientInterceptor());
  }

  Future<Response> login(Map<String,String> map) async {
    Response response = await _dio.post('login',data: map);
    return response;
  }

  Future<Response> register(Map<String,dynamic> map) async {
    Response response = await _dio.post('signup',data: map);
    return response;
  }

  Future<Response> getSpeciesList(String token) async {
    Response response = await _dio.get(
        'species',
        options: Options(
            headers: {
              "token" : token
            }
        ),
    );
    return response;
  }

  Future<Response> getSpeciesListPreviewImagePath(String token,String id) async {
    Response response = await _dio.get(
      'species/$id/images',
      options: Options(
          headers: {
            "token" : token
          }
      ),
    );
    return response;
  }

  Future<Response> getSpeciesListPreviewImage(String token,String id,String imgPath) async {
    Response response = await _dio.get(
          imgPath,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          headers: {
            "token" : token
          }
      ),
    );
    return response;
  }

  Future<Response> getPredictionHistoryImage(String token,String id) async {
    Response response = await _dio.get(
      'predictions/$id/image',
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          headers: {
            "token" : token
          }
      ),
    );
    return response;
  }

  Future<Response> getUserData(String token) async {
    Response response = await _dio.get(
        'users/auth',
        options: Options(
            headers: {
              "token" : token
            }
      ),
    );
    return response;
  }

  Future<Response> getPredictionHistory(String id,String token) async {
    Response response = await _dio.get(
      'users/$id/predictions',
      options: Options(
          headers: {
            "token" : token
          }
      ),
    );
    return response;
  }



  Future<Response> predict(String imagePath,String token) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
          imagePath,
          contentType: MediaType("image", "jpeg")
      ),
    });
    Response response = await _dio.post(
      'predictions',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'Multipart/form-data',
          "token" : token
        }
      ),
      onSendProgress: (count,total) {
        print(count/total);
      }
    );
    return response;
  }




}