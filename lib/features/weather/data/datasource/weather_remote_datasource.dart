import 'package:dio/dio.dart';
import 'package:weather_app/core/network/dio_client.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/features/weather/data/model/weather_model.dart';

class WeatherRemoteDatasource {
  final Dio _dio = DioClient().dio;

  Future<WeatherModel> getCurrentWeather(String cityName) async {
    try {
      final Response = await _dio.get(
        "current.json",
        queryParameters: {
          'key': AppConstants.apiKey,
          'q': cityName,
        },
      );
      return WeatherModel.fromJson(Response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout");
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception("No internet connection");
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid city name');
      } else {
        throw Exception('Something went wrong');
      }
    }
  }
}
