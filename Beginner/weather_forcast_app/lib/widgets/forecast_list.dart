import 'package:flutter/material.dart';
import '../models/forecast_model.dart';
import 'forecast_card.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: forecast.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ForecastCard(forecast: forecast[index]);
        },
      ),
    );
  }
}