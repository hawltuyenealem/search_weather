
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_weather/bloc/bloc.dart';
import 'package:search_weather/pages/weather_search_page.dart';

import '../data/models/weather.dart';
class WeatherDetailPage extends StatefulWidget{
  final Weather weather;
  WeatherDetailPage({required this.weather});
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}
class _WeatherDetailPageState extends State<WeatherDetailPage>{
 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context).add(GetWeatherDetail(widget.weather.cityName));
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Detail Page'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:16 ),
        alignment: Alignment.center,
        child: BlocBuilder<WeatherBloc,WeatherState>(
          builder: (context,state){
            if(state is WeatherLoading){
              return buildLoading();
            }
            else if(state is WeatherLoaded){
              return buildColumnData(context, state.weather);
            }
            else {
              return Center(child: Text('No Data !!'),);
            }
          },
        ),
      ),
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