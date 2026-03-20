part of 'current_weather_bloc.dart';

abstract class CurrentWeatherState extends Equatable {
  final CurrentWeatherResponse? currentWeatherResponse;
  final ForecastResponse? forecastResponse;
  final Map<String, List<Item>> formattedData;
  final bool firstRun;

  const CurrentWeatherState({
    this.currentWeatherResponse,
    this.forecastResponse,
    this.formattedData = const {},
    this.firstRun = false,
  });

  @override
  List<Object?> get props => [
        currentWeatherResponse,
        forecastResponse,
        formattedData,
        firstRun,
      ];
}

class CurrentWeatherInProgress extends CurrentWeatherState {
  const CurrentWeatherInProgress({
    super.currentWeatherResponse,
    super.forecastResponse,
    super.formattedData,
  });
}

class CurrentWeatherLoaded extends CurrentWeatherState {
  const CurrentWeatherLoaded({
    required CurrentWeatherResponse currentWeatherResponse,
    required ForecastResponse forecastResponse,
    required Map<String, List<Item>> formattedData,
    required bool firstRun,
  }) : super(
          currentWeatherResponse: currentWeatherResponse,
          forecastResponse: forecastResponse,
          formattedData: formattedData,
          firstRun: firstRun,
        );
}

class CurrentWeatherFailed extends CurrentWeatherState {
  final String message;

  const CurrentWeatherFailed(
    this.message, {
    super.currentWeatherResponse,
    super.forecastResponse,
    super.formattedData,
  });

  @override
  List<Object?> get props => [...super.props, message];
}
