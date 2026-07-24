import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/data/model/weather_model.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherRepository _repository;

  WeatherProvider(this._repository);

  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String cityName) async {
    if (cityName.trim().isEmpty) {
      _errorMessage = "Please enter a city name";
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final result = await _repository.getCurrentWeather(cityName);
      _weather = result;
    } catch (e) {
      _errorMessage =
          e.toString().replaceAll("Exception: ", "");
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearWeather() {
    _weather = null;
    _errorMessage = null;
    notifyListeners();
  }
}