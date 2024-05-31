import 'package:personal/models/weather_dto.dart';
import 'package:personal/services/api_service.dart';
import 'package:personal/services/location_service.dart';

class WeatherService {
  Future<WeatherData> getWeatherByUserLocation() async {
    try {
      final locationService = LocationService();
      await locationService.getLocation();

      double latitude = locationService.currentLocation[LocationKey.latitude]!;
      double longitude =
          locationService.currentLocation[LocationKey.longitude]!;
      final weatherData =
          await WeatherAPI(latitude, longitude).getWeatherData();
      final cityData =
          await (GeoAPI(lat: latitude, lon: longitude).getCityByCoords());
      if (cityData.isEmpty) throw Exception('City not found');
      return WeatherData(
          stateName: cityData[0].state,
          cityName: cityData[0].name,
          weatherData: weatherData);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<WeatherData> getWeatherByCity(String city) async {
    try {
      final cityCoords = await GeoAPI(city: city).getCoordsByCity();
      if (cityCoords.isEmpty) throw Exception('City not found');
      return getWeatherByCityCoords(cityCoords[0].lat, cityCoords[0].lon);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<WeatherData> getWeatherByCityCoords(double lat, double lon) async {
    try {
      final cityData = await GeoAPI(lat: lat, lon: lon).getCityByCoords();
      final weatherData = await WeatherAPI(lat, lon).getWeatherData();
      return WeatherData(
          stateName: cityData[0].state,
          cityName: cityData[0].name,
          weatherData: weatherData);
    } on Exception catch (_) {
      rethrow;
    }
  }
}

class WeatherData {
  final String cityName;
  final WeatherDTO weatherData;
  final String? stateName;

  WeatherData(
      {required this.cityName, required this.weatherData, this.stateName});
}
