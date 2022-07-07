
import 'dart:math';

import 'models/weather.dart';


abstract class WeatherRepository{
   Future<Weather> fetchWeather(String cityName);
   Future<Weather>  fetchDetailedWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository{
  late double cachedTemperatureCelsius;
  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1),(){
      final random = Random();

      if(random.nextBool()){
        throw NetworkError();
      }
     cachedTemperatureCelsius = 20 + random.nextInt(15) + random.nextDouble();

      return Weather(cityName: cityName, temperatureCelsius: cachedTemperatureCelsius);
    });
  }

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1),(){
      return Weather(cityName: cityName, temperatureCelsius: cachedTemperatureCelsius,temperatureFahrenheit: cachedTemperatureCelsius * 1.8+32);
    });
  }

}

class NetworkError  extends Error{
}
