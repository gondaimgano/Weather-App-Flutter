part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  final CurrentWeatherResponse currentWeatherResponse;
  final ForecastResponse forecastResponse;
  final Map<String, List<Item>> formattedData;

  const CurrentWeatherState(
      this.currentWeatherResponse, this.forecastResponse, this.formattedData);

  @override
  List<Object> get props => [currentWeatherResponse, forecastResponse,formattedData];
}

class CurrentWeatherInProgress extends CurrentWeatherState {
  CurrentWeatherInProgress(
      {CurrentWeatherResponse currentWeatherResponse,
      ForecastResponse forecastResponse,
      Map<String, List<Item>> formattedData})
      : super(currentWeatherResponse, forecastResponse, formattedData);
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  CurrentWeatherLoaded(CurrentWeatherResponse currentWeatherResponse,
      ForecastResponse forecastResponse,
      [Map<String, List<Item>> formattedData])
      : super(currentWeatherResponse, forecastResponse, formattedData);


}

class CurrentWeatherFailed extends CurrentWeatherState {
  final String message;

  CurrentWeatherFailed(this.message,
      [CurrentWeatherResponse currentWeatherResponse,
      ForecastResponse forecastResponse,
      Map<String, List<Item>> formattedData])
      : super(currentWeatherResponse, forecastResponse, formattedData);

}
