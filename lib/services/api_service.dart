import 'dart:async';
import 'package:personal/main.dart';
import 'package:personal/models/geolocation_dto.dart';
import 'package:personal/utils/constants.dart';
import '../models/weather_dto.dart';
import '../utils/network_helper.dart';

class WeatherAPI {
  final double lat;
  final double lon;

  WeatherAPI(this.lat, this.lon);

  FutureOr<WeatherDTO> getWeatherData() async {
    String apiKey = AppConfig.apiKey;
    try {
      final data = NetworkHelper(
          '$OPEN_WEATHERMAP_BASE_URL?lat=$lat&lon=$lon&appid=$apiKey&exclude=minutely,alerts&units=imperial');

      return weatherDtoFromJson(await data.getData());
    } on Exception catch (_) {
      rethrow;
    }
  }
}

class GeoAPI {
  final double? lat;
  final double? lon;
  final String? city;

  GeoAPI({this.lat, this.lon, this.city = ''});

  Future<List<GeoLocationDto>> getCoordsByCity() async {
    String apiKey = AppConfig.apiKey;
    try {
      final data = NetworkHelper(
          '$OPEN_GEOCODE_WEATHER_URL_DIRECT?q=$city,us&appid=$apiKey');
      return geoLocationDtoFromJson(await data.getData());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<GeoLocationDto>> getCityByCoords() async {
    String apiKey = AppConfig.apiKey;
    try {
      final data = NetworkHelper(
          '$OPEN_GEOCODE_BASE_URL_REVERSE?lat=$lat&lon=$lon&appid=$apiKey');
      return geoLocationDtoFromJson(await data.getData());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
