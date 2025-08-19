import 'package:flutter/material.dart';

class Forecast {
  final String day;
  final IconData icon;
  final int high;
  final int low;

  Forecast({
    required this.day,
    required this.icon,
    required this.high,
    required this.low,
  });
}