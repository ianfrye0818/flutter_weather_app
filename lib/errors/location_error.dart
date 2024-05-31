class LocationError implements Exception {
  final String message;

  LocationError(this.message);

  @override
  String toString() => message;
}
