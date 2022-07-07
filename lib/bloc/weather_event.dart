import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class GetWeather extends WeatherEvent {
  final String cityName;
  GetWeather(this.cityName);
  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}

class GetWeatherDetail extends WeatherEvent{
  final String cityName;
  GetWeatherDetail(this.cityName);
  @override
  // TODO: implement props
  List<Object?> get props => [cityName];
}
