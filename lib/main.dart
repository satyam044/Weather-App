import 'package:flutter/material.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/pages/weather_splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: WeatherSplashPage(),
    );
  }
}
