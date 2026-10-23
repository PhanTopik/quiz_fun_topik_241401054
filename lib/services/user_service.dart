import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static const String _keyName = 'registered_name';
  static const String _keyEmail = 'registered_email';
  static const String _keyPassword = 'registered_password';

  // Simpan data saat Sign Up
  static Future<void> saveUserData({
    required String name,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    await prefs.setString(_keyEmail, email);
    await prefs.setString(_keyPassword, password);
  }

  // Ambil Nama
  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName) ?? 'AnimeVerse';
  }

  // Ambil Email
  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail) ?? 'animeverse@gmail.com';
  }

  // Ambil Email terdaftar untuk validasi Login / Forgot Password
  static Future<String?> getSavedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyEmail)?.trim();
  }

  // Ambil Password terdaftar untuk validasi Login
  static Future<String?> getSavedPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPassword)?.trim();
  }

  // Update Nama
  static Future<void> updateName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, newName);
  }

  // Update Password
  static Future<void> updatePassword(String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPassword, newPassword);
  }
}