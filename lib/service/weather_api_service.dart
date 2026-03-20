import 'dart:convert';

import 'package:dvt_weather_app/exception/failure_exception.dart';
import 'package:dvt_weather_app/model/error_response.dart';
import 'package:dvt_weather_app/utils/util.dart';
import 'package:http/http.dart' as http;

class WeatherApiService {
  const WeatherApiService();

  static WeatherApiService create() => const WeatherApiService();

  Future<Map<String, dynamic>> getCurrentWeather(
    double lon,
    double lat, {
    String units = 'metric',
  }) {
    return _get(
      '/weather',
      {
        'lon': lon.toString(),
        'lat': lat.toString(),
        'units': units,
      },
    );
  }

  Future<Map<String, dynamic>> getForcastLastFiveDays(
    double lon,
    double lat,
    int cnt, {
    String units = 'metric',
  }) {
    return _get(
      '/forecast',
      {
        'lon': lon.toString(),
        'lat': lat.toString(),
        'cnt': cnt.toString(),
        'units': units,
      },
    );
  }

  Future<Map<String, dynamic>> _get(
    String path,
    Map<String, String> queryParameters,
  ) async {
    final uri = Uri.parse('${Util.baseUrl}${Util.apiVersion}$path').replace(
      queryParameters: {
        ...queryParameters,
        'appid': Util.token,
      },
    );
    final response = await http.get(uri);
    final body = response.body.isEmpty ? null : jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body is Map<String, dynamic>) {
        return body;
      }
      throw FailureException(
        ErrorResponse(message: 'Unexpected response from weather service.'),
      );
    }

    final message = body is Map<String, dynamic>
        ? ErrorResponse.fromJson(body).message
        : null;
    throw FailureException(
      ErrorResponse(
        message: message ?? 'Weather request failed (${response.statusCode}).',
      ),
    );
  }
}
