import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_weather/data/weather_repository.dart';

import 'bloc.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository);
  @override
  // TODO: implement initialState
  get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async*{
    // TODO: implement mapEventToState
    yield WeatherLoading();
    if(event is GetWeather){
      try{
        final weather  =  await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      }on NetworkError{
        yield WeatherError("couldn't fetch the Weather , Is your device online? ");
      }

    }
    else if (event is GetWeatherDetail){
      try{
        final weather  = await weatherRepository.fetchDetailedWeather(event.cityName);
      }on NetworkError{
        yield WeatherError("couldn't fetch the Weather , Is your device online? ");
      }
    }
  }
 
  }

