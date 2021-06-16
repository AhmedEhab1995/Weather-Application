import 'package:climate_application/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:climate_application/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.climateData});
  final climateData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel model = WeatherModel();

  int temperature;
  int condition;
  String cityName;
  String WeatherIcon;
  String message;
  @override
  void initState() {
    // TODO: implement initState
    updateUI(widget.climateData);
  }

  updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        double temp = 0.0;
        temperature = temp.toInt();
        condition = 0;
        cityName = 'Not found try again later';
        message = 'Error';

        return;
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      WeatherIcon = model.getWeatherIcon(condition);
      message = model.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await model.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
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
                      style: kTempTextStyle,
                    ),
                    Text(
                      WeatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$message in $cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// int condition = decodedData['weather'][0]['id'];
// double temp = decodedData['main']['temp'];
// String cityName = decodedData['name'];
// String weather = decodedData['weather'][0]['description'];
