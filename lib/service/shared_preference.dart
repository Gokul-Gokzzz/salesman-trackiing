import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _tokenKey = "user_token";
  static const String _userDataKey = "user_data";

  static Future<void> saveLoginData(
      String token, Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_userDataKey, userData.toString());
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userDataKey);
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userDataKey);
  }
}
