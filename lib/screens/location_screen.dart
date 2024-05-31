import 'package:flutter/material.dart';
import 'package:personal/models/weather_dto.dart';
import 'package:personal/screens/city_screen.dart';
import 'package:personal/services/weather_service.dart';
import 'package:personal/widgets/error_snackbar.dart';
import '../utils/weather_text_helper.dart';
import '/utils/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen(
      {super.key,
      required this.weatherData,
      required this.cityname,
      this.statename});

  final WeatherDTO weatherData;
  final String cityname;
  final String? statename;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherHelper weatherModel = WeatherHelper();
  late String temp;
  late String weatherIcon;
  late String message;
  late String cityname;
  late String statename;

  @override
  void initState() {
    temp = widget.weatherData.current!.temp!.toStringAsFixed(0);
    weatherIcon =
        weatherModel.getWeatherIcon(widget.weatherData.current!.weather.id);
    message =
        weatherModel.getMessage(widget.weatherData.current!.temp!.toInt());
    cityname = widget.cityname;
    statename = widget.statename ?? '';
    super.initState();
  }

  void refreshWeather() async {
    try {
      final weatherData = await WeatherService().getWeatherByUserLocation();
      if (weatherData.weatherData.current == null ||
          weatherData.cityName.isEmpty) {
        throw Exception('Weather data not found');
      }
      setState(() {
        temp = weatherData.weatherData.current!.temp!.toStringAsFixed(0);
        weatherIcon = weatherModel
            .getWeatherIcon(weatherData.weatherData.current!.weather.id);
        message = weatherModel
            .getMessage(weatherData.weatherData.current!.temp!.toInt());
        cityname = weatherData.cityName;
        statename = weatherData.stateName ?? '';
      });
    } on Exception catch (_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const ErrorSnackBar().buildSnackBar(context));
    }
  }

  void setNewWeatherData() async {
    final newCityWeatherData = await Navigator.push<WeatherData>(
        context, MaterialPageRoute(builder: (context) => const CityScreen()));
    if (newCityWeatherData != null) {
      setState(() {
        temp = newCityWeatherData.weatherData.current!.temp!.toStringAsFixed(0);
        weatherIcon = weatherModel
            .getWeatherIcon(newCityWeatherData.weatherData.current!.weather.id);
        message = weatherModel
            .getMessage(newCityWeatherData.weatherData.current!.temp!.toInt());
        cityname = newCityWeatherData.cityName;
        statename = newCityWeatherData.stateName ?? '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: refreshWeather,
                    icon: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: setNewWeatherData,
                    icon: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$temp°F',
                          style: kTempTextStyle,
                        ),
                        const SizedBox(width: 10.0),
                        Text(weatherIcon, style: kConditionTextStyle),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '$cityname, $statename',
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Column(
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: kMessageTextStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
