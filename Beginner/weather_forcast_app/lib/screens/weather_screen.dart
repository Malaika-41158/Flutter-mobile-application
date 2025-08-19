import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import '../models/forecast_model.dart';
import '../widgets/top_section.dart';
import '../widgets/forecast_list.dart';
import '../widgets/extra_info.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Forecast> dummyForecast = [
      Forecast(day: "Mon", icon: WeatherIcons.day_sunny, high: 32, low: 24),
      Forecast(day: "Tue", icon: WeatherIcons.cloudy, high: 30, low: 22),
      Forecast(day: "Wed", icon: WeatherIcons.rain, high: 27, low: 20),
      Forecast(day: "Thu", icon: WeatherIcons.day_cloudy, high: 29, low: 21),
      Forecast(day: "Fri", icon: WeatherIcons.storm_showers, high: 25, low: 19),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const TopSection(
                location: "Islamabad",
                date: "Tue, Aug 20",
                icon: WeatherIcons.day_sunny,
                temperature: "30°C",
                description: "Sunny",
              ),
              ForecastList(forecast: dummyForecast),
              const Spacer(),
              const ExtraInfoRow(),
            ],
          ),
        ),
      ),
    );
  }
}