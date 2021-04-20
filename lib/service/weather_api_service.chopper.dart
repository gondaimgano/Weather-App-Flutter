// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$WeatherApiService extends WeatherApiService {
  _$WeatherApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = WeatherApiService;

  Future<Response> getCurrentWeather(double lon, double lat,
      {String units = "metric"}) {
    final $url = '/2.5/weather';
    final Map<String, dynamic> $params = {
      'lon': lon,
      'lat': lat,
      'units': units
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getForcastLastFiveDays(double lon, double lat, int cnt,
      {String units = "metric"}) {
    final $url = '/2.5/forecast';
    final Map<String, dynamic> $params = {
      'lon': lon,
      'lat': lat,
      'cnt': cnt,
      'units': units
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
