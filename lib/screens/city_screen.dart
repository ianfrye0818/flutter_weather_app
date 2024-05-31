import 'package:flutter/material.dart';
import 'package:personal/services/weather_service.dart';
import 'package:personal/widgets/error_snackbar.dart';

import '../utils/constants.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  final TextEditingController _cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<WeatherData> getWeatherByCity() async {
      final city = _cityController.text;
      try {
        return await WeatherService().getWeatherByCity(city);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          ErrorSnackBar(city: city).buildSnackBar(context),
        );
        rethrow;
      } finally {
        _cityController.clear();
      }
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 35.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: const TextStyle(color: Colors.black),
                  decoration: kInputDecordation,
                  controller: _cityController,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final weatherData = await getWeatherByCity();
                  Navigator.pop(context, weatherData);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Get Weather',
                    style: kButtonTextStyle,
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
