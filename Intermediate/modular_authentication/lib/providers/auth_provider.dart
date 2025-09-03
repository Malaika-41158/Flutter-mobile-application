import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  String? _email;
  String? _fullName;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get email => _email;
  String? get fullName => _fullName;

  // For using reqres api switch to true
  final bool useMockApi = false;

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void _setError(String? e) {
    _error = e;
    notifyListeners();
  }

  Future<void> _persistUser(String email, String fullName) async {
    _email = email;
    _fullName = fullName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('fullName', fullName);
  }

  Future<void> loadPersistedUser() async {
    final prefs = await SharedPreferences.getInstance();
    _email = prefs.getString('email');
    _fullName = prefs.getString('fullName');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    _email = null;
    notifyListeners();
  }


  Future<bool> login({required String email, required String password}) async {
    _setError(null);
    _setLoading(true);
    try {
      await Future.delayed(const Duration(milliseconds: 900));

      if (!useMockApi) {
        if (password.length >= 6) {
          final prefs = await SharedPreferences.getInstance();
          final savedName = prefs.getString('fullName') ?? "";
          await _persistUser(email, savedName);
          return true;
        } else {
          _setError('Invalid credentials');
          return false;
        }
      } else {
        final resp = await http.post(
          Uri.parse('https://reqres.in/api/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email, 'password': password}),
        );
        if (resp.statusCode == 200) {
          final prefs = await SharedPreferences.getInstance();
          final savedName = prefs.getString('fullName') ?? "";
          await _persistUser(email, savedName);
          return true;
        } else {
          _setError('Login failed (${resp.statusCode})');
          return false;
        }
      }
    } catch (e) {
      _setError('Something went wrong');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    _setError(null);
    _setLoading(true);
    try {
      await Future.delayed(const Duration(milliseconds: 900));
      if (!useMockApi) {
        if (fullName.trim().isNotEmpty && password.length >= 6) {
          await _persistUser(email, fullName);
          return true;
        } else {
          _setError('Registration failed. Check inputs.');
          return false;
        }
      } else {
        final resp = await http.post(
            Uri.parse('https://reqres.in/api/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
        );
        if (resp.statusCode == 200) {
          await _persistUser(email, fullName);
          return true;
        } else {
          _setError('Registration failed (${resp.statusCode})');
          return false;
        }
      }
    } catch (e) {
      _setError('Something went wrong');
      return false;
    } finally {
      _setLoading(false);
    }
  }
}