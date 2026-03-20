import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:dvt_weather_app/exception/failure_exception.dart';
import 'package:dvt_weather_app/model/current_weather_response.dart';
import 'package:dvt_weather_app/model/forecast_response.dart';
import 'package:dvt_weather_app/repos/weather_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final WeatherRepository _repository;
  CurrentWeatherResponse? _currentWeatherResponse;
  ForecastResponse? _forecastResponse;
  Map<String, List<Item>> _formattedData = const {};

  CurrentWeatherBloc(this._repository)
      : super(const CurrentWeatherInProgress()) {
    on<FetchCurrentWeather>(_onFetchCurrentWeather);
  }

  Future<void> _onFetchCurrentWeather(
    FetchCurrentWeather event,
    Emitter<CurrentWeatherState> emit,
  ) async {
    emit(
      CurrentWeatherInProgress(
        currentWeatherResponse: _currentWeatherResponse,
        forecastResponse: _forecastResponse,
        formattedData: _formattedData,
      ),
    );

    try {
      final currentWeatherResponse =
          await _repository.fetchCurrentLocationWeather();
      final forecastResponse = await _repository.fetchForecastForLast(days: 30);
      final isFirstRun = await _repository.ensureFirstTimeRun();

      _currentWeatherResponse = currentWeatherResponse;
      _forecastResponse = forecastResponse;
      _formattedData = groupBy(
        forecastResponse.list,
        (value) => DateFormat.yMd().format(DateTime.parse(value.dtTxt)),
      );

      emit(
        CurrentWeatherLoaded(
          currentWeatherResponse: currentWeatherResponse,
          forecastResponse: forecastResponse,
          formattedData: _formattedData,
          firstRun: isFirstRun,
        ),
      );
    } on SocketException {
      emit(
        CurrentWeatherFailed(
          'Network error',
          currentWeatherResponse: _currentWeatherResponse,
          forecastResponse: _forecastResponse,
          formattedData: _formattedData,
        ),
      );
    } on HandshakeException {
      emit(
        CurrentWeatherFailed(
          'Connection interrupted',
          currentWeatherResponse: _currentWeatherResponse,
          forecastResponse: _forecastResponse,
          formattedData: _formattedData,
        ),
      );
    } on PlatformException catch (error) {
      emit(
        CurrentWeatherFailed(
          error.message ?? 'Location permission denied',
          currentWeatherResponse: _currentWeatherResponse,
          forecastResponse: _forecastResponse,
          formattedData: _formattedData,
        ),
      );
    } on FailureException catch (error) {
      emit(
        CurrentWeatherFailed(
          error.toString(),
          currentWeatherResponse: _currentWeatherResponse,
          forecastResponse: _forecastResponse,
          formattedData: _formattedData,
        ),
      );
    } catch (error) {
      emit(
        CurrentWeatherFailed(
          error.toString(),
          currentWeatherResponse: _currentWeatherResponse,
          forecastResponse: _forecastResponse,
          formattedData: _formattedData,
        ),
      );
    }
  }
}
