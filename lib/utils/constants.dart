// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 50.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 75.0,
);
const kInputDecordation = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter US City Name',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);

const OPEN_WEATHERMAP_BASE_URL =
    'https://api.openweathermap.org/data/3.0/onecall';
const OPEN_GEOCODE_BASE_URL_REVERSE =
    'http://api.openweathermap.org/geo/1.0/reverse';
const OPEN_GEOCODE_WEATHER_URL_DIRECT =
    'http://api.openweathermap.org/geo/1.0/direct';
