import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController InputController = TextEditingController();
  final _weatherService = WeatherServices('ApiKey');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/Weather-sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Weather-windy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Weather-rainy.json';
      case 'thunderstorm':
        return 'assets/Weather-thunder.json';
      case 'clear':
        return 'assets/Weather-sunny.json';
      default:
        return 'assets/Weather-sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: InputController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search City",
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () async {
                          String cityName = InputController.text.trim();
                          if (cityName.isEmpty) return;
                          try {
                            final weather = await _weatherService.getWeather(
                              cityName,
                            );
                            setState(() {
                              _weather = weather;
                            });
                          } catch (e) {
                            print("Error: $e");
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Lottie.asset(
                    getWeatherAnimation(_weather?.mainCondition),
                    height: 200,
                  ),
                  Text(
                    "${_weather?.temperature.round()}°C",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _weather?.mainCondition ?? "",
                    style: TextStyle(fontSize: 40),
                  ),
                  Text(
                    _weather?.cityName ?? "loading city...",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 60),
                  Lottie.asset("assets/Home.json"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
