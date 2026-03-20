import 'package:chopper/chopper.dart';
import 'package:dvt_weather_app/exception/failure_exception.dart';
import 'package:dvt_weather_app/model/current_weather_response.dart';
import 'package:dvt_weather_app/model/error_response.dart';
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
    return _parseCurrentWeatherResponse(response);
  }

  Future<ForecastResponse> fetchForecastForLast({int days = 30}) async {
    final locationData = await _determinePosition();
    final response = await _apiService.getForcastLastFiveDays(
      locationData.longitude!,
      locationData.latitude!,
      days,
    );
    return _parseForecastResponse(response);
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

  CurrentWeatherResponse _parseCurrentWeatherResponse(
    Response<Map<String, dynamic>> response,
  ) {
    if (response.isSuccessful && response.body != null) {
      return CurrentWeatherResponse.fromJson(response.body!);
    }
    throw FailureException(_parseErrorResponse(response));
  }

  ForecastResponse _parseForecastResponse(
    Response<Map<String, dynamic>> response,
  ) {
    if (response.isSuccessful && response.body != null) {
      return ForecastResponse.fromJson(response.body!);
    }
    throw FailureException(_parseErrorResponse(response));
  }

  ErrorResponse _parseErrorResponse(Response<Map<String, dynamic>> response) {
    final error = response.error;
    if (error is Map<String, dynamic>) {
      return ErrorResponse.fromJson(error);
    }
    return ErrorResponse(
      cod: response.statusCode.toString(),
      message: 'Weather request failed (${response.statusCode}).',
    );
  }
}
