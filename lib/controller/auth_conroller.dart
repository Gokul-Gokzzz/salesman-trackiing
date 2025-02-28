// import 'package:flutter/material.dart';
// import 'package:salesman/model/login_model.dart';
// import 'package:salesman/model/registration_model.dart';
// import 'package:salesman/service/auth_Service.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthService _authService = AuthService();
//   LoginModel? _loginModel;
//   bool _isLoading = false;

//   LoginModel? get loginModel => _loginModel;
//   bool get isLoading => _isLoading;

//   login(String email, String password) async {
//     _isLoading = true;
//     notifyListeners();

//     _loginModel = await _authService.login(email, password);

//     _isLoading = false;
//     notifyListeners();
//   }

//   Future<void> registerUser({
//     required String name,
//     required String email,
//     required String mobileNumber,
//     required String password,
//     required String accountProvider,
//     required Function(bool, String) callback,
//   }) async {
//     UserRegistrationModel user = UserRegistrationModel(
//       name: name,
//       email: email,
//       mobileNumber: mobileNumber,
//       password: password,
//       accountProvider: accountProvider,
//     );

//     final response = await _authService.registerUser(user);
//     callback(response["success"], response["message"]);
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesman/model/login_model.dart';
import 'package:salesman/model/registration_model.dart';
import 'package:salesman/service/auth_Service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  LoginModel? _loginModel;
  bool _isLoading = false;

  LoginModel? get loginModel => _loginModel;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUserData(); // Load stored login data when provider initializes
  }

  /// Load user data from SharedPreferences when the app starts
  // Future<void> _loadUserData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('auth_token');
  //   final name = prefs.getString('user_name');

  //   if (token != null && name != null) {
  //     _loginModel = LoginModel(
  //       token: token,
  //       user: User(name: name),
  //     );
  //     notifyListeners();
  //   }
  // }
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final name = prefs.getString('user_name');

    log('🔍 Checking Stored Token: $token');
    log('🔍 Checking Stored User Name: $name');

    if (token != null && name != null) {
      _loginModel = LoginModel(
        token: token,
        user: User(name: name),
      );
      notifyListeners();
      log('✅ User Data Loaded Successfully');
    } else {
      log('⚠️ No User Data Found');
    }
  }

  /// Login and save token
  // Future<void> login(String email, String password) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   final loginData = await _authService.login(email, password);

  //   if (loginData != null) {
  //     _loginModel = loginData;
  //     notifyListeners();
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final loginData = await _authService.login(email, password);

    if (loginData != null) {
      _loginModel = loginData;

      // Store login data immediately
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', loginData.token ?? '');
      await prefs.setString('user_name', loginData.user?.name ?? '');
      log('✅ Token Stored in Provider');

      notifyListeners();
    } else {
      log('❌ Login Failed: No data returned');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Logout: Clears stored data
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _loginModel = null;
    notifyListeners();
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String mobileNumber,
    required String password,
    required String accountProvider,
    required Function(bool, String) callback,
  }) async {
    UserRegistrationModel user = UserRegistrationModel(
      name: name,
      email: email,
      mobileNumber: mobileNumber,
      password: password,
      accountProvider: accountProvider,
    );

    final response = await _authService.registerUser(user);
    callback(response["success"], response["message"]);
  }
}
