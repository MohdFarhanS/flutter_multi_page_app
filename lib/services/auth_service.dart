// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _loggedInKey = 'isLoggedIn';
  static const String _registeredUsersKey = 'registeredUsers';
  static const String _currentUsernameKey = 'currentUsername'; // Kunci baru untuk username yang sedang login

  // --- Metode Login ---
  Future<bool> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsersJson = prefs.getString(_registeredUsersKey);
    Map<String, dynamic> registeredUsers = registeredUsersJson != null
        ? json.decode(registeredUsersJson)
        : {};

    if (registeredUsers.containsKey(username) &&
        registeredUsers[username]['password'] == password) {
      await prefs.setBool(_loggedInKey, true);
      await prefs.setString(_currentUsernameKey, username); // Simpan username yang login
      return true;
    }
    return false;
  }

  // --- Metode Registrasi ---
  Future<bool> register(String username, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsersJson = prefs.getString(_registeredUsersKey);
    Map<String, dynamic> registeredUsers = registeredUsersJson != null
        ? json.decode(registeredUsersJson)
        : {};

    // Cek apakah username atau email sudah terdaftar (simulasi)
    if (registeredUsers.containsKey(username) ||
        registeredUsers.values.any((user) => user['email'] == email)) {
      return false; // Username atau email sudah terdaftar
    }

    if (!email.contains('@') || password.length < 6) {
      return false; // Validasi dasar gagal
    }

    // Simpan akun baru
    registeredUsers[username] = {
      'email': email,
      'password': password,
    };

    await prefs.setString(_registeredUsersKey, json.encode(registeredUsers));
    await prefs.setBool(_loggedInKey, true); // Langsung login setelah registrasi
    await prefs.setString(_currentUsernameKey, username); // Simpan username yang baru daftar
    return true;
  }

  // --- Metode Logout ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    await prefs.remove(_currentUsernameKey); // Hapus username saat logout
  }

  // --- Metode IsLoggedIn ---
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  // Metode baru untuk mendapatkan informasi pengguna yang sedang login
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(_currentUsernameKey);
    if (username != null) {
      String? registeredUsersJson = prefs.getString(_registeredUsersKey);
      if (registeredUsersJson != null) {
        Map<String, dynamic> registeredUsers = json.decode(registeredUsersJson);
        return registeredUsers[username]; // Mengembalikan Map data user (email, password)
      }
    }
    return null; // Tidak ada user yang login atau data tidak ditemukan
  }

  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUsernameKey);
  }
}