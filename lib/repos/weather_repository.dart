import 'package:chopper/chopper.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:location/location.dart';

class WeatherRepository {
  final WeatherApiService _apiService;
  LocationData _locationData ;
  WeatherRepository(this._apiService);

  Future<Response> fetchCurrentLocationWeather() async {
    _locationData= await _requestCurrentLocation();
    var response = await _apiService.getCurrentWeather(
      _locationData.longitude,
      _locationData.latitude,
    );

    return response;
  }

  Future<Response> fetchForecastForLast({int days}) async {
    _locationData= await _requestCurrentLocation();
    var response = await _apiService.getForcastLastFiveDays(
      _locationData.longitude,
      _locationData.latitude,
      days,
    );

    return response;
  }

  Future<LocationData> _requestCurrentLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception("To use this app need to enable location service");
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception("May you please enable location service");
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }
}
