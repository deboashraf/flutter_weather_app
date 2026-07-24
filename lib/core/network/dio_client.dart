import 'package:dio/dio.dart';

class DioClient{
  late Dio dio;

  DioClient(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://api.weatherapi.com/v1/',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      )
    );
    _addInterceptors();
  }

  void _addInterceptors(){
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      )
    );
  }
}