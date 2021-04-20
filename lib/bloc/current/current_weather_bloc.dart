import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dvt_weather_app/exception/failure_exception.dart';
import 'package:dvt_weather_app/model/current_weather_response.dart';
import 'package:dvt_weather_app/model/error_response.dart';
import 'package:dvt_weather_app/model/forecast_response.dart';
import 'package:dvt_weather_app/repos/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

part 'current_weather_event.dart';

part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository _repository;
  CurrentWeatherResponse _currentWeatherResponse;
  ForecastResponse _forecastResponse;
  Map<String, List<Item>> _formattedData;

  CurrentWeatherBloc(this._repository) : super(CurrentWeatherInProgress());

  @override
  Stream<CurrentWeatherState> mapEventToState(
    CurrentWeatherEvent event,
  ) async* {
    if (event is FetchCurrentWeather) yield* _mapCurrentWeatherToState();
  }

  Stream<CurrentWeatherState> _mapCurrentWeatherToState() async* {
    try {
      yield CurrentWeatherInProgress(
          currentWeatherResponse: _currentWeatherResponse,
          forecastResponse: _forecastResponse,
          formattedData: _formattedData);

      var response = await _repository.fetchCurrentLocationWeather();
      var response0 = await _repository.fetchForecastForLast(days: 30);

      if (response.isSuccessful && response0.isSuccessful) {
        _currentWeatherResponse =
            CurrentWeatherResponse.fromJson(response.body);
        _forecastResponse = ForecastResponse.fromJson(response0.body);
        _formattedData = groupBy(_forecastResponse.list,
            (v) => DateFormat.yMd().format(DateTime.parse(v.dtTxt)));
        yield CurrentWeatherLoaded(
          _currentWeatherResponse,
          _forecastResponse,
          _formattedData,
        );
      } else {
        throw FailureException(
            ErrorResponse.fromJson(response.error ?? response0.error));
      }
    } on SocketException {
      yield CurrentWeatherFailed("Network error");
    } on HandshakeException {
      yield CurrentWeatherFailed("Connection Interrupted");
    } on PlatformException {
      add(FetchCurrentWeather());
    } catch (ex) {
      yield CurrentWeatherFailed(ex.toString());
      // rethrow;
    }
  }
}


