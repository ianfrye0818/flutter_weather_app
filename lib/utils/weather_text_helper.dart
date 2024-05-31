import 'package:flutter/material.dart';

class WeatherHelper {
  String getWeatherIcon(int condition) {
    switch (condition) {
      case < 300:
        return '🌩';
      case < 400:
        return '🌧';
      case < 600:
        return '☔️';
      case < 700:
        return '☃️';
      case < 800:
        return '🌫';
      case 800:
        return '☀️';
      case <= 804:
        return '☁️';
      default:
        return '🤷‍';
    }
  }

  String getMessage(int temp) {
    switch (temp) {
      case > 25:
        return 'It\'s 🍦 time';
      case > 20:
        return 'Time for shorts and 👕';
      case < 10:
        return 'You\'ll need 🧣 and 🧤';
      default:
        return 'Bring a 🧥 just in case';
    }
  }

  Image weatherIcon(String icon) =>
      Image.network('https://openweathermap.org/img/wn/$icon.png',
          width: 100, height: 100, fit: BoxFit.fill);
}
