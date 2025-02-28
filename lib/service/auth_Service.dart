import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/login_model.dart';
import 'package:salesman/model/registration_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://salesman-tracking-app.onrender.com/auth/user',
      headers: {"Content-Type": "application/json"},
    ),
  );

  AuthService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('➡️ [LOGIN REQUEST] ${options.method} ${options.path}');
          log('Headers: ${options.headers}');
          log('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ [LOGIN RESPONSE] ${response.statusCode} ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          log('❌ [LOGIN ERROR] ${e.response?.statusCode} ${e.response?.data}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<LoginModel?> login(String name, String password) async {
    log('Attempting login with Email: $name, Password: ${password.trim()}'); // Debug log (Remove in production)

    try {
      final response = await _dio.post(
        '/login',
        data: {
          "name": name,
          "password": password.trim(), // Ensure no extra spaces
        },
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        final token = response.data['token'];
        await _saveUserData(response.data);
        log('🔑 Token saved: $token');
        return LoginModel.fromJson(response.data);
      } else {
        log('⚠️ Login failed: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        log('❌ Invalid credentials: ${e.response?.data}');
      } else {
        log('❌ Unexpected Error: ${e.message}');
      }
      return null;
    }
  }

  Future<void> _saveUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', data['token']);
    await prefs.setString('password', data['user']['password'] ?? '');
    await prefs.setString('user_name', data['user']['name'] ?? '');
    log('✅ User Data Saved: ${data['user']}');
  }

  ///registration

  Future<Map<String, dynamic>> registerUser(UserRegistrationModel user) async {
    try {
      Response response = await _dio.post(
        "/register",
        data: user.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"success": true, "message": "Registration successful"};
      } else {
        return {
          "success": false,
          "message": response.data["message"] ?? "Registration failed"
        };
      }
    } catch (e) {
      return {"success": false, "message": "Error: ${e.toString()}"};
    }
  }
}
