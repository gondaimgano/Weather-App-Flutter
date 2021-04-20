part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  final CurrentWeatherResponse currentWeatherResponse;
  final ForecastResponse forecastResponse;
  final Map<String, List<Item>> formattedData;
  final bool firstRun;
  const CurrentWeatherState(
      this.currentWeatherResponse, this.forecastResponse, this.formattedData,this.firstRun);

  @override
  List<Object> get props => [currentWeatherResponse, forecastResponse,formattedData,firstRun];
}

class CurrentWeatherInProgress extends CurrentWeatherState {
  CurrentWeatherInProgress(
      {CurrentWeatherResponse currentWeatherResponse,
      ForecastResponse forecastResponse,
      Map<String, List<Item>> formattedData})
      : super(currentWeatherResponse, forecastResponse, formattedData,false);
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  CurrentWeatherLoaded(CurrentWeatherResponse currentWeatherResponse,
      ForecastResponse forecastResponse,
      [Map<String, List<Item>> formattedData,bool firstRun])
      : super(currentWeatherResponse, forecastResponse, formattedData,firstRun);


}

class CurrentWeatherFailed extends CurrentWeatherState {
  final String message;

  CurrentWeatherFailed(this.message,
      [CurrentWeatherResponse currentWeatherResponse,
      ForecastResponse forecastResponse,
      Map<String, List<Item>> formattedData])
      : super(currentWeatherResponse, forecastResponse, formattedData,false);

}
