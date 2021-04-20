import 'package:chopper/chopper.dart';
import 'package:dvt_weather_app/service/weather_api_service.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class WeatherRepository {
  final WeatherApiService _apiService;
  LocationData _locationData ;
  WeatherRepository(this._apiService);

  Future<bool> ensureFirstTimeRun()async{
    var prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("first_run")??true){
      prefs.setBool("first_run", false);
      return true;
    }
    return false;
  }

  Future<Response> fetchCurrentLocationWeather() async {
    print("request location");
    _locationData= await _determinePosition();
    print(_locationData);
    var response = await _apiService.getCurrentWeather(
      _locationData.longitude,
      _locationData.latitude,
    );
 print(response);
    return response;
  }

  Future<Response> fetchForecastForLast({int days}) async {
    print("request location");
    _locationData= await _determinePosition();

    var response = await _apiService.getForcastLastFiveDays(
      _locationData.longitude,
      _locationData.latitude,
      days,
    );

    return response;
  }

  Future<LocationData> _determinePosition() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw Exception("Permission not granted");
      }
    }
    await p.Permission.byValue(1).request().isGranted;
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw Exception("Location Permission denied");
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }
}
