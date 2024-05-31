import 'dart:convert';

List<GeoLocationDto> geoLocationDtoFromJson(String str) =>
    List<GeoLocationDto>.from(
        json.decode(str).map((x) => GeoLocationDto.fromJson(x)));

String geoLocationDtoToJson(List<GeoLocationDto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeoLocationDto {
  String name;
  double lat;
  double lon;
  String? country;
  String? state;

  GeoLocationDto({
    required this.name,
    required this.lat,
    required this.lon,
    this.country,
    this.state,
  });

  factory GeoLocationDto.fromJson(Map<String, dynamic> json) => GeoLocationDto(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
