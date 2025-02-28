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

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    String fullName = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String mobileNumber = _mobileNumberController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (fullName.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
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
            Row(
              children: [
                const Text(
                  "Register",
                  style: TextStyle(
                    color: Color(0XFF094497),
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                const Spacer(),
                _buildSocialIcon("assets/images/flat-color-icons_google.svg"),
                const SizedBox(width: 16),
                _buildSocialIcon("assets/images/logos_facebook.svg"),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
                controller: _fullNameController, hintText: "Full Name"),
            const SizedBox(height: 20),
            _buildTextField(controller: _emailController, hintText: "Email"),
            const SizedBox(height: 20),
            _buildTextField(
                controller: _mobileNumberController, hintText: "Mobile Number"),
            const SizedBox(height: 20),
            _buildTextField(
                controller: _passwordController,
                hintText: "Password",
                obscureText: true),
            const SizedBox(height: 20),
            _buildTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0XFF094497),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.0),
                      child: Text(
                        "Sign-up",
                        style: TextStyle(
                          color: Color(0XFFF6F6F9),
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: widget.onLogin,
                  child: const SizedBox(
                    width: 130,
                    child: Text(
                      "Already a Member? Login",
                      style: TextStyle(
                        color: Color(0XFFB3B3B3),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper method to create a social icon button
  Widget _buildSocialIcon(String assetPath) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(assetPath),
      ),
    );
  }

  // Helper method to create a text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFA0A0A0),
          fontWeight: FontWeight.w400,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(),
    );
  }
}
