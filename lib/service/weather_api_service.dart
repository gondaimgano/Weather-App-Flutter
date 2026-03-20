import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:dvt_weather_app/utils/util.dart';
import 'package:logging/logging.dart' as logging;

part 'weather_api_service.chopper.dart';

@ChopperApi(baseUrl: Util.apiVersion)
abstract class WeatherApiService extends ChopperService {
  static WeatherApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.parse(Util.baseUrl),
      services: [
        _$WeatherApiService(),
      ],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        _ApiKeyInterceptor(),
        HttpLoggingInterceptor(
          level: Level.basic,
          logger: logging.Logger('Chopper'),
        ),
      ],
    );

    return client.getService<WeatherApiService>();
  }

  @GET(path: '/weather')
  Future<Response<Map<String, dynamic>>> getCurrentWeather(
    @Query('lon') double lon,
    @Query('lat') double lat, {
    @Query('units') String units = 'metric',
  });

  @GET(path: '/forecast')
  Future<Response<Map<String, dynamic>>> getForcastLastFiveDays(
    @Query('lon') double lon,
    @Query('lat') double lat,
    @Query('cnt') int cnt, {
    @Query('units') String units = 'metric',
  });
}

class _ApiKeyInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    final parameters = Map<String, dynamic>.from(request.parameters)
      ..['appid'] = Util.token;
    return chain.proceed(
      request.copyWith(parameters: parameters),
    );
  }
}
