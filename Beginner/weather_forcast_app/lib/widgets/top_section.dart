import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopSection extends StatelessWidget {
  final String location;
  final String date;
  final IconData icon;
  final String temperature;
  final String description;

  const TopSection({
    super.key,
    required this.location,
    required this.date,
    required this.icon,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            location,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          Icon(icon, size: 100, color: Colors.yellow),
          const SizedBox(height: 8),
          Text(
            temperature,
            style: GoogleFonts.poppins(
              fontSize: 48,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}