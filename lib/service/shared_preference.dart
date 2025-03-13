import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const String _authTokenKey = 'auth_token';
  static const String _userNameKey = 'user_name';
  static const String _authKey = 'id';

  /// Save token and user details
  static Future<void> saveAuthData({
    required String token,
    required String name,
    required String id,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
    await prefs.setString(_userNameKey, name);
    await prefs.setString(_authKey, id);
    log('✅ Token Stored Successfully');
  }

  /// Load stored token and user details
  static Future<Map<String, String?>> loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_authTokenKey);
    final name = prefs.getString(_userNameKey);
    final id = prefs.getString(_authKey);
    log('🔍 Loaded Token: $token');
    log('🔍 Loaded User Name: $name');
    log('🔍 Loaded User id: $id');
    return {
      'token': token,
      'name': name,
      'id': id,
    };
  }

  /// Clear stored authentication data (Logout)
  static Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userNameKey);
    log('🚪 User Logged Out - Token Cleared');
  }
}


late SharedPreferences prefs;

Future<void> initSharedPrefs() async {
  prefs = await SharedPreferences.getInstance();
}
