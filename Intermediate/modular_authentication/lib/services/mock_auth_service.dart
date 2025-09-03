class MockAuthService {
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 900));
    return password.length >= 6;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 900));
    return name.trim().isNotEmpty && password.length >= 6;
  }
}