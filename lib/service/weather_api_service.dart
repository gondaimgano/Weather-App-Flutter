import 'package:chopper/chopper.dart';
import 'package:dvt_weather_app/utils/util.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'weather_api_service.chopper.dart';

@ChopperApi(baseUrl: Util.apiVersion)
abstract class WeatherApiService extends ChopperService {

  @Get(path: "/weather")
  Future<Response> getCurrentWeather(
      @Query("lon") double lon,
      @Query("lat") double lat,
      {@Query("units") String units ="metric"}
      );
  @Get(path:"/forecast")
  Future<Response> getForcastLastFiveDays(
      @Query("lon") double lon,
      @Query("lat") double lat,
      @Query("cnt") int cnt,
      {@Query("units") String units ="metric"}
      );


  static WeatherApiService create() {
    final client = ChopperClient(
      baseUrl: Util.baseUrl,
      interceptors: [
        HttpLoggingInterceptor(),
            (Request request) async {
              final params = Map<String, dynamic>.from(request.parameters);
              params['appid'] = Util.token;
          return request.copyWith(parameters: params);
        },
      ],
      services: [

        // The generated implementation
        _$WeatherApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$WeatherApiService(client);
  }
}