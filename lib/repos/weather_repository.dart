import 'package:dvt_weather_app/model/current_weather_response.dart';
import 'package:dvt_weather_app/model/forecast_response.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherRepository {
  final WeatherApiService _apiService;

  WeatherRepository(this._apiService);

  Future<bool> ensureFirstTimeRun() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await prefs.setBool('first_run', false);
      return true;
    }
    return false;
  }

  Future<CurrentWeatherResponse> fetchCurrentLocationWeather() async {
    final locationData = await _determinePosition();
    final response = await _apiService.getCurrentWeather(
      locationData.longitude!,
      locationData.latitude!,
    );
    return CurrentWeatherResponse.fromJson(response);
  }

  Future<ForecastResponse> fetchForecastForLast({int days = 30}) async {
    final locationData = await _determinePosition();
    final response = await _apiService.getForcastLastFiveDays(
      locationData.longitude!,
      locationData.latitude!,
      days,
    );
    return ForecastResponse.fromJson(response);
  }

  Future<LocationData> _determinePosition() async {
    final location = Location();

    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw Exception('Location service is disabled.');
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }

    if (permissionGranted != PermissionStatus.granted) {
      throw Exception('Location permission denied.');
    }

    final locationData = await location.getLocation();
    if (locationData.latitude == null || locationData.longitude == null) {
      throw Exception('Unable to determine your current location.');
    }
    return locationData;
  }
}
