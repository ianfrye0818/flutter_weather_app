import 'package:flutter/material.dart';
import 'package:personal/screens/location_screen.dart';
import 'package:personal/services/weather_service.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String _weatherDataError = '';

  void _initLocation() async {
    try {
      final weatherData = await WeatherService().getWeatherByUserLocation();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LocationScreen(
            weatherData: weatherData.weatherData,
            cityname: weatherData.cityName,
            statename: weatherData.stateName,
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _weatherDataError = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _weatherDataError.isEmpty
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'Error: $_weatherDataError',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
