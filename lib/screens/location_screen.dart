

import 'package:flutter/material.dart';
import 'package:weatherit/services/weather.dart';
import 'package:weather_widget/WeatherWidget.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.condition});

  final locationWeather;
  final condition;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temperature;
  Widget weatherbg;
  String cityName;
  String weatherMessage;

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
    getWeather(widget.condition);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;

        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();
      String condition = weatherData['weather'][0]['main'];
      print(condition);
      weatherbg = getWeather(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  



  Widget getWeather(condition) {

      switch (condition) {
        case "snow": setState(() {
          return WeatherWidget(
              size: Size.infinite, weather: 'Sunny', sunConfig: SunConfig());

        });
        return WeatherWidget(
            size: Size.infinite, weather: 'Sunny', sunConfig: SunConfig());
        case "Clouds": setState(() {
          return  WeatherWidget(
              size: Size.infinite,
              weather: 'Cloudy',
              cloudConfig: CloudConfig());
        });


          return WeatherWidget(
              size: Size.infinite,
              weather: 'Cloudy',
              cloudConfig: CloudConfig());

        case "Smoke":
          return WeatherWidget(
              size: Size.infinite,
              weather: 'Thunder',
              thunderConfig: ThunderConfig());
          break;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        weatherbg,
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $cityName',
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
