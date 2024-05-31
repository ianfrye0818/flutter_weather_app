import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:personal/screens/loading_screen.dart';

void main() async {
  final envFile =
      File('/Users/ianfrye/dev_projects/personal/flutter_weather_app/.env');
  if (!envFile.existsSync()) {
    throw Exception('Please create a .env file in the root directory');
  }
  await dotenv.load(
      fileName:
          '/Users/ianfrye/dev_projects/personal/flutter_weather_app/.env');
  AppConfig.initialize(dotenv.env['API_KEY']!);
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        filledButtonTheme: const FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.lightBlueAccent),
            foregroundColor: MaterialStatePropertyAll(Colors.white70),
          ),
        ),
      ),
      home: const LoadingScreen(),
    );
  }
}

class AppConfig {
  static late String apiKey;

  static void initialize(String key) {
    apiKey = key;
  }
}
