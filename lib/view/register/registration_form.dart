import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/view/app_base_screen/app_base_screen.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onSignUp;
  final VoidCallback? onLogin;

  const RegisterForm({
    Key? key,
    required this.onSignUp,
    this.onLogin,
  }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    String fullName = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String mobileNumber = _mobileNumberController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (fullName.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog("All fields are required!");
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog("Passwords do not match!");
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    AuthProvider authController = AuthProvider();
    authController.registerUser(
      name: fullName,
      email: email,
      mobileNumber: mobileNumber,
      password: password,
      accountProvider: "local",
      callback: (success, message) {
        Navigator.pop(context); // Remove loading indicator

        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Registration successful!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BaseScreen()),
          );
        } else {
          _showErrorDialog(message);
        }
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Registration Failed",
              style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            _buildTextField(
                controller: _fullNameController, hintText: "User Name"),
            const SizedBox(height: 20),
            _buildTextField(controller: _emailController, hintText: "Email"),
            const SizedBox(height: 20),
            _buildTextField(
                controller: _mobileNumberController, hintText: "Mobile Number"),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _passwordController,
              hintText: "Password",
              obscureText: _obscurePassword,
              toggleVisibility: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: _obscureConfirmPassword,
              toggleVisibility: () {
                setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword);
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _handleSignUp,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF094497)),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 13.0),
                child: Text(
                  "Sign-up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    VoidCallback? toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFFA0A0A0), fontWeight: FontWeight.w400),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        suffixIcon: toggleVisibility != null
            ? IconButton(
                icon:
                    Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: toggleVisibility,
              )
            : null,
      ),
    );
  }
}
