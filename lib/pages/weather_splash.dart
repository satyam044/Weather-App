import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/pages/weather_page.dart';

class WeatherSplashPage extends StatelessWidget {
  const WeatherSplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Weather-rainy.json'),
            SizedBox(height: 30),
            Text(
              'Weather',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Text(
              'ForeCasts',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 80),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => WeatherPage()),
                );
              },
              child: Text('Get Started', style: TextStyle(fontSize: 40)),
            ),
          ],
        ),
      ),
    );
  }
}
