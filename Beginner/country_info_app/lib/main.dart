import 'package:flutter/material.dart';
import 'screens/country_list_screen.dart';

void main() {
  runApp(const CountryInfoApp());
}

class CountryInfoApp extends StatelessWidget {
  const CountryInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Country Explorer",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: const CountryListScreen(),
    );
  }
}