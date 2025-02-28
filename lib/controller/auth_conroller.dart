import 'package:flutter/material.dart';
import 'package:salesman/model/login_model.dart';
import 'package:salesman/model/registration_model.dart';
import 'package:salesman/service/auth_Service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  LoginModel? _loginModel;
  bool _isLoading = false;

  LoginModel? get loginModel => _loginModel;
  bool get isLoading => _isLoading;

  login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    _loginModel = await _authService.login(email, password);

    _isLoading = false;
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
