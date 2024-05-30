import 'package:bird_guard/src/data/network/interceptor.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
class ApiClient {
  late final Dio _dio;
  final _baseUrl = 'https://43f2-182-2-132-136.ngrok-free.app/';


  ApiClient() {
    _dio = Dio(
      BaseOptions(
        // baseUrl: 'https://f851-182-2-166-45.ngrok-free.app/',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 15),
        sendTimeout: Duration(seconds: 5),
        contentType: "application/json",
      ),
    );
    _dio.interceptors.add(ApiClientInterceptor());
  }

  Future<Response> login(Map<String,String> map) async {
    Response response = await _dio.post('${_baseUrl}login',data: map);
    return response;
  }

  Future<Response> register(Map<String,dynamic> map) async {
    Response response = await _dio.post('${_baseUrl}signup',data: map);
    return response;
  }

  Future<Response> getSpeciesList(String token) async {
    Response response = await _dio.get(
        '${_baseUrl}species',
        options: Options(
            headers: {
              "token" : token
            }
        ),
    );
    return response;
  }

  Future<Response> getSpeciesListPreviewImage(String token,String id) async {
    Response response = await _dio.get(
      '${_baseUrl}species/$id/images/train/001.jpg',
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



  Future<Response> predict(String imagePath,String token) async {
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
          imagePath,
          // filename: 'image',
          contentType: MediaType("image", "jpeg")
      ),
    });
    Response response = await _dio.post(
      '${_baseUrl}predictions',
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