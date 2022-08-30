part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object?> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateInProgress extends WeatherState {}

class WeatherStateCompleted extends WeatherState {
  const WeatherStateCompleted(this.weatherData);
  final String weatherData;

  @override
  List<Object?> get props => [weatherData];
}

class WeatherStateFailed extends WeatherState {
  const WeatherStateFailed(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
