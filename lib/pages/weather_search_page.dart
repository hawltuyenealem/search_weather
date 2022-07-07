import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_weather/bloc/bloc.dart';
import 'package:search_weather/data/models/weather.dart';
import 'package:search_weather/pages/weather_detail_page.dart';

class WeatherSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: BlocListener<WeatherBloc,WeatherState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is WeatherError){
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherInitial) {
                return buildIntialInput();
              }
              else if (state is WeatherLoading) {
                return buildLoading();
              }
              else if (state is WeatherLoaded) {
                return buildColumnData(context, state.weather);
              }
              else {
                return Center(child: Text('No Data !!'),);
              }
            },
          ),
        ),
      ),

    );
  }

  Widget buildIntialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator(),);
  }

  Column buildColumnData(BuildContext context, Weather weather) {
    return Column(
      children: [
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),),
        Text(
          '${weather.temperatureCelsius.toStringAsFixed(1)} C',
          style: TextStyle(fontSize: 80),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute( 
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<WeatherBloc>(context),
                      child: WeatherDetailPage(weather: weather),
                    )
                ));
          },
          child: Text('See Details'),
          color: Colors.lightBlue,

        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  void submitCity(BuildContext context, String cityName) {
    final weatherBloc  = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(GetWeather(cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCity(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

}