import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class ExtraInfoRow extends StatelessWidget {
  const ExtraInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          ExtraInfo(icon: WeatherIcons.strong_wind, label: "Wind", value: "10 km/h"),
          ExtraInfo(icon: WeatherIcons.humidity, label: "Humidity", value: "65%"),
          ExtraInfo(icon: WeatherIcons.sunrise, label: "Sunrise", value: "6:10 AM"),
          ExtraInfo(icon: WeatherIcons.sunset, label: "Sunset", value: "7:45 PM"),
        ],
      ),
    );
  }
}

class ExtraInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ExtraInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 14)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}