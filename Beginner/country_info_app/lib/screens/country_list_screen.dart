import 'package:flutter/material.dart';
import '../models/country.dart';
import '../services/api_service.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries = ApiService.fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Countries")),
      body: FutureBuilder<List<Country>>(
        future: futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No countries found"));
          }

          final countries = snapshot.data!;
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {
                futureCountries = ApiService.fetchCountries();
              });
            },
            child: ListView.builder(
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      country.flagUrl,
                      width: 50,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    title: Text(country.name),
                    subtitle: Text("Capital: ${country.capital}\nPopulation: ${country.population}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CountryDetailScreen(country: country),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(country.flagUrl, width: 150)),
            const SizedBox(height: 20),
            Text("Capital: ${country.capital}", style: const TextStyle(fontSize: 18)),
            Text("Population: ${country.population}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}