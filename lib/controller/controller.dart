// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:weather_app/models/city_model.dart';
import 'package:weather_app/models/forecast_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather.dart';


class WeatherDataProvider extends ChangeNotifier {
  final WeatherAPIService _weatherAPIService = WeatherAPIService();

  CityModel? _cityModel;
  WeatherDatas? _weatherData;
  List<ForecastModel>? _forecastData;
  List<ForecastModel>? _weatherDataList;
  List<ForecastModel>? get weatherDataList => _weatherDataList;
  // Getter to access the forecast data list
  CityModel? get cityModel => _cityModel;
  WeatherDatas? get weatherData => _weatherData;
  List<ForecastModel>? get forecastData => _forecastData;

  Future<void> fetchCityInfo(String cityName) async {
    try {
      _cityModel = await _weatherAPIService.getCityInfo(cityName);
      notifyListeners();
    } catch (e) {
      print('Error fetching city info: $e');
    }
  }

  Future<void> fetchWeatherData(double lat, double lon) async {
    try {
      _weatherData = await _weatherAPIService.getWeatherData(lat, lon);
      notifyListeners();
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  Future<void> fetchWeatherDataList(double lat, double lon) async {
    try {
      _weatherDataList = await _weatherAPIService.getWeatherDataList(lat, lon);
      notifyListeners();
    } catch (error) {
      print('Error fetching weather data list: $error');
      // Handle error as per your requirement, like showing a snackbar or retry option.
    }
  }
}