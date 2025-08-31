import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/country.dart';

class ApiService {
  static const String _baseUrl =
      "https://restcountries.com/v3.1/all?fields=name,capital,flags,region,population";

  static Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      List<Country> countries = data.map((json) => Country.fromJson(json)).toList();

      countries.sort((a, b) => a.name.compareTo(b.name));

      return countries;
    } else {
      throw Exception("Failed to load countries");
    }
  }
}