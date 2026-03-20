import 'package:dvt_weather_app/model/error_response.dart';

class FailureException implements Exception {
  final ErrorResponse _errorResponse;

  FailureException(this._errorResponse);

  @override
  String toString() => _errorResponse.message ?? 'Unknown error';
}
