class Validators {
  static String? requiredField(String? v, {String field = 'This field'}) {
    if (v == null || v.trim().isEmpty) return '$field is required';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(v.trim())) return 'Enter a valid email';
    return null;
  }

  static String? password(String? v, {int min = 6}) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < min) return 'Must be at least $min characters';
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Please confirm password';
    if (v != original) return 'Passwords do not match';
    return null;
  }
}