// lib/services/auth_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  static const String _loggedInKey = 'isLoggedIn';
  static const String _registeredUsersKey = 'registeredUsers';
  static const String _currentUsernameKey = 'currentUsername';

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
      await prefs.setString(_currentUsernameKey, username);
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
    await prefs.setBool(_loggedInKey, true);
    await prefs.setString(_currentUsernameKey, username);
    return true;
  }

  // --- Metode Logout ---
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
    await prefs.remove(_currentUsernameKey);
  }

  // --- Metode IsLoggedIn ---
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  // Metode untuk mendapatkan informasi pengguna yang sedang login
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(_currentUsernameKey);
    if (username != null) {
      String? registeredUsersJson = prefs.getString(_registeredUsersKey);
      if (registeredUsersJson != null) {
        Map<String, dynamic> registeredUsers = json.decode(registeredUsersJson);
        return registeredUsers[username];
      }
    }
    return null;
  }

  Future<String?> getCurrentUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUsernameKey);
  }

  // Metode untuk memperbarui profil pengguna (dari jawaban sebelumnya)
  Future<bool> updateUserProfile(String newUsername, String newEmail) async {
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsersJson = prefs.getString(_registeredUsersKey);
    Map<String, dynamic> registeredUsers = registeredUsersJson != null
        ? json.decode(registeredUsersJson)
        : {};

    String? oldUsername = prefs.getString(_currentUsernameKey);

    if (oldUsername == null) {
      return false; // Tidak ada user yang login
    }

    // Periksa apakah username baru sudah digunakan oleh user lain (selain diri sendiri)
    if (newUsername != oldUsername && registeredUsers.containsKey(newUsername)) {
      return false; // Username baru sudah terdaftar
    }

    // Perbarui data pengguna
    Map<String, dynamic>? userData = registeredUsers[oldUsername];
    if (userData == null) {
      return false; // Data user tidak ditemukan
    }

    // Hapus data user lama jika username berubah
    if (newUsername != oldUsername) {
      registeredUsers.remove(oldUsername);
    }

    // Simpan data dengan username baru (atau username yang sama jika tidak berubah)
    registeredUsers[newUsername] = {
      'email': newEmail,
      'password': userData['password'], // Pertahankan password lama
    };

    await prefs.setString(_registeredUsersKey, json.encode(registeredUsers));
    await prefs.setString(_currentUsernameKey, newUsername);

    return true;
  }

  // --- Metode Baru: changePassword ---
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsersJson = prefs.getString(_registeredUsersKey);
    Map<String, dynamic> registeredUsers = registeredUsersJson != null
        ? json.decode(registeredUsersJson)
        : {};

    String? currentUsername = prefs.getString(_currentUsernameKey);

    if (currentUsername == null) {
      return false; // Tidak ada user yang login
    }

    Map<String, dynamic>? userData = registeredUsers[currentUsername];
    if (userData == null || userData['password'] != oldPassword) {
      return false; // Password lama tidak sesuai atau user data tidak ditemukan
    }

    // Perbarui password
    userData['password'] = newPassword;
    registeredUsers[currentUsername] = userData; // Simpan kembali data yang sudah diperbarui

    await prefs.setString(_registeredUsersKey, json.encode(registeredUsers));
    return true;
  }

  Future<bool> resetPasswordWithDefault(String usernameToReset) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulasi delay

    final prefs = await SharedPreferences.getInstance();
    String? registeredUsersJson = prefs.getString(_registeredUsersKey);
    Map<String, dynamic> registeredUsers = registeredUsersJson != null
        ? json.decode(registeredUsersJson)
        : {};

    // Cek apakah username ditemukan
    if (registeredUsers.containsKey(usernameToReset)) {
      // Dapatkan data user
      Map<String, dynamic> userData = registeredUsers[usernameToReset];

      // Set password ke '123456'
      userData['password'] = '123456';

      // Simpan kembali data user yang sudah diperbarui
      registeredUsers[usernameToReset] = userData;
      await prefs.setString(_registeredUsersKey, json.encode(registeredUsers));

      return true; // Username ditemukan dan password berhasil direset
    }

    // Jika username tidak ditemukan
    return false;
  }
}