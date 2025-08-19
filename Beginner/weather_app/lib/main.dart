import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final String apiKey = "0fd178f281850602d15f38f55eacbc96";
  String selectedCity = "Islamabad";

  double? temperature;
  String? description;

  @override
  void initState() {
    super.initState();
    fetchWeather(selectedCity);
  }

  Future<void> fetchWeather(String city) async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          temperature = data["main"]["temp"];
          description = data["weather"][0]["description"];
        });
      } else {
        throw Exception("Failed to load weather");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Map<String, dynamic> getWeatherIconData(String? desc) {
    if (desc == null) return {"icon": Icons.wb_sunny, "color": Colors.grey};

    desc = desc.toLowerCase();

    if (desc.contains("clear")) {
      return {"icon": Icons.wb_sunny, "color": Colors.yellow};
    }
    if (desc.contains("cloud")) {
      return {"icon": Icons.cloud, "color": Colors.grey};
    }
    if (desc.contains("rain") || desc.contains("drizzle")) {
      return {"icon": Icons.water_drop, "color": Colors.blue};
    }
    if (desc.contains("snow")) {
      return {"icon": Icons.ac_unit, "color": Colors.lightBlueAccent};
    }
    if (desc.contains("storm") || desc.contains("thunder")) {
      return {"icon": Icons.flash_on, "color": Colors.deepPurple};
    }
    if (desc.contains("mist") || desc.contains("fog") || desc.contains("haze")) {
      return {"icon": Icons.blur_on, "color": Colors.blueGrey};
    }

    return {"icon": Icons.wb_sunny, "color": Colors.orange};
  }

  List<Color> getBackgroundColors(String? desc) {
    if (desc == null) return [Colors.grey.shade300, Colors.grey.shade600];

    desc = desc.toLowerCase();

    if (desc.contains("clear")) {
      return [Colors.lightBlue.shade200, Colors.blue.shade800];
    }
    if (desc.contains("cloud")) {
      return [Colors.grey.shade400, Colors.grey.shade800];
    }
    if (desc.contains("rain") || desc.contains("drizzle")) {
      return [Colors.blueGrey.shade400, Colors.blue.shade900];
    }
    if (desc.contains("snow")) {
      return [Colors.white, Colors.blueGrey.shade300];
    }
    if (desc.contains("storm") || desc.contains("thunder")) {
      return [Colors.deepPurple.shade400, Colors.black87];
    }
    if (desc.contains("mist") || desc.contains("fog") || desc.contains("haze")) {
      return [Colors.grey.shade300, Colors.blueGrey.shade700];
    }

    return [Colors.orange.shade300, Colors.deepOrange.shade700];
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
    DateFormat('EEEE, MMM d • HH:mm').format(DateTime.now());

    Map<String, dynamic> getWeatherIconData(String? desc) {
      if (desc == null) return {"icon": Icons.wb_sunny, "color": Colors.grey};
      desc = desc.toLowerCase();
      if (desc.contains("clear")) return {"icon": Icons.wb_sunny, "color": Colors.yellow};
      if (desc.contains("cloud")) return {"icon": Icons.cloud, "color": Colors.grey};
      if (desc.contains("rain") || desc.contains("drizzle")) return {"icon": Icons.water_drop, "color": Colors.blue};
      if (desc.contains("snow")) return {"icon": Icons.ac_unit, "color": Colors.lightBlueAccent};
      if (desc.contains("storm") || desc.contains("thunder")) return {"icon": Icons.flash_on, "color": Colors.deepPurple};
      if (desc.contains("mist") || desc.contains("fog") || desc.contains("haze")) return {"icon": Icons.blur_on, "color": Colors.blueGrey};
      return {"icon": Icons.wb_sunny, "color": Colors.orange};
    }

    List<Color> getBackgroundColors(String? desc) {
      if (desc == null) return [Colors.grey.shade300, Colors.grey.shade600];
      desc = desc.toLowerCase();
      if (desc.contains("clear")) return [Colors.lightBlue.shade200, Colors.blue.shade800];
      if (desc.contains("cloud")) return [Colors.grey.shade400, Colors.grey.shade800];
      if (desc.contains("rain") || desc.contains("drizzle")) return [Colors.blueGrey.shade400, Colors.blue.shade900];
      if (desc.contains("snow")) return [Colors.white, Colors.blueGrey.shade300];
      if (desc.contains("storm") || desc.contains("thunder")) return [Colors.deepPurple.shade400, Colors.black87];
      if (desc.contains("mist") || desc.contains("fog") || desc.contains("haze")) return [Colors.grey.shade300, Colors.blueGrey.shade700];
      return [Colors.orange.shade300, Colors.deepOrange.shade700];
    }

    final iconData = getWeatherIconData(description);
    final bgColors = getBackgroundColors(description);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Full-screen animated gradient
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(seconds: 2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: bgColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Content below status/app bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // City selector
                  DropdownButton<String>(
                    value: selectedCity,
                    items: ["Islamabad", "Lahore", "Rawalpindi", "Karachi"]
                        .map((city) => DropdownMenuItem(value: city, child: Text(city)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                        fetchWeather(selectedCity);
                      });
                    },
                  ),

                  const SizedBox(height: 16),

                  // Center the card nicely
                  Expanded(
                    child: Center(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                selectedCity,
                                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(formattedDate, style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 20),

                              Icon(iconData["icon"], size: 60, color: iconData["color"]),
                              const SizedBox(height: 15),

                              Text(
                                temperature != null ? "${temperature!.toStringAsFixed(1)}°C" : "--°C",
                                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                (description ?? "Loading...").toUpperCase(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}