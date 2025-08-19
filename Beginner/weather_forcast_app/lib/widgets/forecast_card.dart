import 'package:flutter/material.dart';
import '../models/forecast_model.dart';

class ForecastCard extends StatelessWidget {
  final Forecast forecast;

  const ForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(forecast.day,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Icon(forecast.icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text("${forecast.high}° / ${forecast.low}°",
              style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}