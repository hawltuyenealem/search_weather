
import 'package:equatable/equatable.dart';

import '../data/models/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  const WeatherInitial();
  @override
  List<Object> get props => [];
}
class WeatherLoading extends WeatherState{
  const WeatherLoading();
  @override
  List<Object> get props => [];
}
class WeatherLoaded extends WeatherState{
  Weather weather;
  WeatherLoaded(this.weather);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class WeatherError extends WeatherState{
  String message;
  WeatherError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [];

}