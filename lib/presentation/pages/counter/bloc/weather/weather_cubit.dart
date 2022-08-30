import 'package:counter_weather/domain/repositories/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherRepository) : super(WeatherStateInitial());

  final WeatherRepository weatherRepository;

  Future<void> loadCurrentWeather() async {
    emit(WeatherStateInProgress());
    try {
      var response = await weatherRepository.getWeather();
      emit(WeatherStateCompleted(response!));
    } catch (e) {
      debugPrint(e.toString());
      emit(WeatherStateFailed(e.toString()));
    }
  }
}
