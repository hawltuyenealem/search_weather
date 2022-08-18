import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:search_weather/data/weather_repository.dart';

import '../bloc/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherRepository weatherRepository;
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());


  Future<void> getWeather(String cityName)async{
    try{
      emit(new WeatherLoading());
      final weather = await weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    }on NetworkError{
      emit(WeatherError(""));
    }
  }

}
