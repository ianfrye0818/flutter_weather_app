import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  double _longitude = 0.0;
  double _latitude = 0.0;

  Map<LocationKey, double> get currentLocation =>
      {LocationKey.latitude: _latitude, LocationKey.longitude: _longitude};

  Future<void> getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
      _longitude = position.longitude;
      _latitude = position.latitude;
    } on TimeoutException {
      throw TimeoutException(
          'Location is taking too long to retrieve, Please try again later');
    } on PermissionDefinitionsNotFoundException {
      throw const PermissionDefinitionsNotFoundException(
          'Could not determine location permissions. Please try again later');
    } catch (error) {
      rethrow;
    }
  }
}

enum LocationKey {
  latitude,
  longitude,
}
