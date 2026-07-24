import 'package:weather_app/features/weather/data/datasource/weather_remote_datasource.dart';
import 'package:weather_app/features/weather/data/model/weather_model.dart';

class WeatherRepository {
  final WeatherRemoteDatasource _remoteDataSource;
  WeatherRepository(this._remoteDataSource);

  Future<WeatherModel> getCurrentWeather(String cityName) async {
    return await _remoteDataSource.getCurrentWeather(cityName);
  }
}
