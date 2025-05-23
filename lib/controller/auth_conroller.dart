import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:salesman/model/login_model.dart';
import 'package:salesman/model/registration_model.dart';
import 'package:salesman/service/auth_Service.dart';
import 'package:salesman/service/shared_preference.dart'; // Import the new storage class

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  LoginModel? _loginModel;
  bool _isLoading = false;

  LoginModel? get loginModel => _loginModel;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUserData(); // Load stored login data when provider initializes
  }

  /// Load user data from AuthStorage
  Future<void> _loadUserData() async {
    final authData = await AuthStorage.loadAuthData();
    final token = authData['token'];
    final name = authData['name'];
    final id = authData['id'];

    if (token != null && name != null && id != null) {
      _loginModel = LoginModel(
        token: token,
        user: User(name: name, id: id),
      );
      notifyListeners();
      log('✅ User Data Loaded Successfully');
    } else {
      log('⚠️ No User Data Found');
    }
  }

  /// Login and save token using AuthStorage
  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final loginData = await _authService.login(email, password);

    if (loginData != null) {
      _loginModel = loginData;
      await AuthStorage.saveAuthData(
        id: loginData.user?.id ?? '',
        token: loginData.token ?? '',
        name: loginData.user?.name ?? '',
      );
      log('✅ Login Successful: User ID = ${loginData.user?.id ?? 'Unknown'}');
      notifyListeners();
    } else {
      log('❌ Login Failed: No data returned');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Logout: Clears stored data
  Future<void> logout() async {
    await AuthStorage.clearAuthData();
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
      mobileNumber: int.parse(mobileNumber),
      password: password,
      accountProvider: accountProvider,
    );

    final response = await _authService.registerUser(user);

    if (response["success"] == true && response["data"] != null) {
      final data = response["data"];

      // Save the auth data
      await AuthStorage.saveAuthData(
        id: data["id"] ?? '',
        token: data["token"] ?? '',
        name: data["name"] ?? '',
      );

      // Update _loginModel
      _loginModel = LoginModel(
        token: data["token"] ?? '',
        user: User(
          id: data["id"] ?? '',
          name: data["name"] ?? '',
        ),
      );

      notifyListeners();
      log('✅ Registration Successful and Auth Data Saved');
    } else {
      log('❌ Registration Failed');
    }

    callback(response["success"], response["message"]);
  }
}
