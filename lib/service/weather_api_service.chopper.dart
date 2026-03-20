// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'weather_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherApiService extends WeatherApiService {
  _$WeatherApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherApiService;

  @override
  Future<Response<Map<String, dynamic>>> getCurrentWeather(
    double lon,
    double lat, {
    String units = 'metric',
  }) {
    final Uri $url = Uri.parse('/2.5/weather');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lon': lon,
      'lat': lat,
      'units': units,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }

  @override
  Future<Response<Map<String, dynamic>>> getForcastLastFiveDays(
    double lon,
    double lat,
    int cnt, {
    String units = 'metric',
  }) {
    final Uri $url = Uri.parse('/2.5/forecast');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lon': lon,
      'lat': lat,
      'cnt': cnt,
      'units': units,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
