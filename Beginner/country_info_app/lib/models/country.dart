class Country {
  final String name;
  final String capital;
  final String flagUrl;
  final String region;
  final int population;

  Country({
    required this.name,
    required this.capital,
    required this.flagUrl,
    required this.region,
    required this.population,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown',
      capital: (json['capital'] != null && (json['capital'] as List).isNotEmpty)
          ? json['capital'][0]
          : 'N/A',
      flagUrl: json['flags']?['png'] ?? '',
      region: json['region'] ?? 'Unknown',
      population: json['population'] ?? 0,
    );
  }
}