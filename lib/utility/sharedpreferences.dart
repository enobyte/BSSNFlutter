import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencess {
  static final String userLogin = 'user_login';

  // Hapus Cache BaseOn Key
  static Future<bool> clearPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(key);
    return preferences.remove(key);
  }

  // Hapus Semua Cache
  static Future<bool> clearAllPreference() async {
    SharedPreferences preferencess = await SharedPreferences.getInstance();
    return preferencess.clear();
  }

  // Fungsi Simpan Cache
  static Future<bool> setPreferences(String value, String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  // Fungsi Ngambil Cache
  static Future<String> getPreferences(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  // Check Keberadaan Key
  static Future<bool> checkKey(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(key);
  }
}
