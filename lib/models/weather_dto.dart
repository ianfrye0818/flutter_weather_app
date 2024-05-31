import 'dart:convert';

WeatherDTO weatherDtoFromJson(String str) =>
    WeatherDTO.fromJson(json.decode(str));

class WeatherDTO {
  double lat;
  double lon;
  String? timezone;
  Current? current;
  List<Current> hourly;
  List<Daily> daily;

  WeatherDTO(
      {required this.lat,
      required this.lon,
      this.timezone,
      this.current,
      required this.hourly,
      required this.daily});

  factory WeatherDTO.fromJson(Map<String, dynamic> json) => WeatherDTO(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        current: Current.fromJson(json["current"]),
        hourly:
            List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
        daily: List<Daily>.from(json["daily"].map((x) => Daily.fromJson(x))),
      );
}

class Current {
  DateTime dt;
  DateTime? sunrise;
  DateTime? sunset;
  double? temp;
  double? feelsLike;
  int? humidity;
  double? dewPoint;
  double? uvi;
  double? windSpeed;
  double? windGusts;
  Weather weather;

  Current(
      {required this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feelsLike,
      this.dewPoint,
      this.humidity,
      this.uvi,
      this.windGusts,
      this.windSpeed,
      required this.weather});

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
        sunrise: json["sunrise"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["sunrise"] * 1000)
            : null,
        sunset: json["sunset"] != null
            ? DateTime.fromMillisecondsSinceEpoch(json["sunset"] * 1000)
            : null,
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        windSpeed: json["wind_speed"]?.toDouble(),
        windGusts: json["wind_gust"]?.toDouble(),
        weather: Weather.fromJson(json["weather"][0]),
      );
}

class Weather {
  int id;
  String? main;
  String? description;
  String? icon;

  Weather({required this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );
}

class Daily {
  DateTime dt;
  DateTime? sunrise;
  DateTime? sunset;
  DateTime? moonrise;
  DateTime? moonset;
  String? summary;
  DailyTemp dailyTemp;
  FeelsLike feelsLike;
  List<Weather> weather;

  Daily(
      {required this.dt,
      this.sunrise,
      this.sunset,
      this.moonrise,
      this.moonset,
      this.summary,
      required this.dailyTemp,
      required this.feelsLike,
      required this.weather});

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: DateTime.fromMillisecondsSinceEpoch(json["dt"] * 1000),
        sunrise: DateTime.fromMillisecondsSinceEpoch(json["sunrise"] * 1000),
        sunset: DateTime.fromMillisecondsSinceEpoch(json["sunset"] * 1000),
        moonrise: DateTime.fromMillisecondsSinceEpoch(json["moonrise"] * 1000),
        moonset: DateTime.fromMillisecondsSinceEpoch(json["moonset"] * 1000),
        summary: json["summary"],
        dailyTemp: DailyTemp.fromJson(json["temp"]),
        feelsLike: FeelsLike.fromJson(json["feels_like"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );
}

class DailyTemp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  DailyTemp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  factory DailyTemp.fromJson(Map<String, dynamic> json) => DailyTemp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );
}

class FeelsLike {
  double? day;
  double? night;
  double? eve;
  double? morn;

  FeelsLike({this.day, this.night, this.eve, this.morn});

  factory FeelsLike.fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );
}
