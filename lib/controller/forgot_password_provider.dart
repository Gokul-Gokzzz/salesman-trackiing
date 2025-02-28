import 'package:flutter/material.dart';

class LoginScreenProvider with ChangeNotifier {
  bool _isForgotPasswordSelected = false;

  bool get isForgotPasswordSelected => _isForgotPasswordSelected;

  void toggleForgotPassword() {
    _isForgotPasswordSelected = !_isForgotPasswordSelected;
    notifyListeners();
  }

  void showForgotPassword() {
    _isForgotPasswordSelected = true;
    notifyListeners();
  }

  void showLoginForm() {
    _isForgotPasswordSelected = false;
    notifyListeners();
  }
}
