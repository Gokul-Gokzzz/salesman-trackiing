import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/forgot_password_provider.dart';
import 'package:salesman/controller/auth_conroller.dart';
import 'package:salesman/view/app_base_screen/app_base_screen.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    final isForgotPasswordSelected =
        context.watch<LoginScreenProvider>().isForgotPasswordSelected;
    return Column(
      children: [
        Visibility(
          visible: !isForgotPasswordSelected,
          child: Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    _buildTextField("Username, Mobile Number",
                        controller: _nameController),
                    const SizedBox(
                      height: 18,
                    ),
                    _buildTextField("Password",
                        // isPassword: true,
                        controller: _passwordController),
                    const SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<LoginScreenProvider>()
                            .showForgotPassword();
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0XFFFA4A0C),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildLoginButton(context, loginProvider),
                    const SizedBox(
                      height: 15,
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Or",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildFacebookButton(),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildGoogleButton(),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isForgotPasswordSelected,
          child: Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          context.read<LoginScreenProvider>().showLoginForm();
                        },
                        child: SizedBox(
                            height: 22,
                            width: 22,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: SvgPicture.asset(
                                  "assets/images/backbutton.svg"),
                            ))),
                    const SizedBox(
                      height: 36,
                    ),
                    const Text(
                      "Forgot\npassword?",
                      style: TextStyle(
                          color: Color(0XFF094497),
                          fontWeight: FontWeight.w700,
                          fontSize: 36),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            "assets/images/Mail.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFFFFF),
                        hintText: "Enter your email address",
                        hintStyle: const TextStyle(
                          color: Color(0xFF676767),
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
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
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: '* ',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text:
                                'We will send you a message to set or reset your new password',
                            style: TextStyle(
                              color: Color(0xFF676767),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    const Text(
                      "Send code",
                      style: TextStyle(
                          color: Color(0XFFB2B2B2),
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 33,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 51,
                          height: 51,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0XFF094497),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0XFF094497).withOpacity(0.5),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white, // Icon color
                            size: 25, // Icon size
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField(String hintText,
      {bool isPassword = false, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFFFFFFF),
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xFFA0A0A0), fontWeight: FontWeight.w400),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
      ),
    );
  }

  // Login Button Widget
  Widget _buildLoginButton(BuildContext context, AuthProvider loginProvider) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () async {
          String name = _nameController.text.trim();
          String password = _passwordController.text.trim();

          if (name.isNotEmpty && password.isNotEmpty) {
            await loginProvider.login(
              name,
              password,
            );
            if (loginProvider.loginModel != null) {
              // Navigate to the next screen on successful login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const BaseScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Login failed. Please try again.")),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please enter email and password.")),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0XFF094497),
        ),
        child: loginProvider.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 13.0),
                child: Text(
                  "Login",
                  style: TextStyle(
                      color: Color(0XFFF6F6F9),
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
      ),
    );
  }
}

// Facebook Button Widget
Widget _buildFacebookButton() {
  return SizedBox(
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0XFF1877F2),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/Facebook Logo.png'),
              height: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "Log In with Facebook",
              style: TextStyle(
                  color: Color(0XFFFFFFFF),
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    ),
  );
}

// Google Button Widget
Widget _buildGoogleButton() {
  return SizedBox(
    width: double.maxFinite,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0XFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/images/Google Logo.png'),
              height: 20,
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              "Log In with Google",
              style: TextStyle(
                  color: const Color(0XFF000000).withOpacity(0.54),
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    ),
  );
}
