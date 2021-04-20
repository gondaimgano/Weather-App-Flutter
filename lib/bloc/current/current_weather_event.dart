part of 'current_weather_bloc.dart';

abstract class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();
}

class FetchCurrentWeather extends CurrentWeatherEvent{
  @override
  List<Object> get props => [];
}
