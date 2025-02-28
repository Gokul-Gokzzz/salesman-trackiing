import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/view/login/login_form.dart';
import 'package:salesman/view/register/registration_form.dart';

class MyTabViewInBody extends StatelessWidget {
  const MyTabViewInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color(0XFFE3E3E3),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 290,
                  decoration: const BoxDecoration(
                    color: Color(0XFFFFFFFF),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: const Center(
                    child: Image(
                      image: AssetImage("assets/images/tracking_plane.png"),
                      height: 130,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Color(0XFF094497),
                    dividerHeight: 0,
                    labelStyle: TextStyle(
                      fontSize: 18, // Adjust the font size
                      fontWeight: FontWeight.w600, // Adjust the font weight
                    ),
                    tabs: [
                      Tab(
                        text: "Login",
                      ),
                      Tab(text: "Sign-up"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // TabBarView displays the content for each tab
            Expanded(
              child: TabBarView(
                children: [
                  const LoginFormWidget(),
                  RegisterForm(
                    onSignUp: () {
                      log("Sign-up button pressed");
                    },
                    onLogin: () {
                      log("Login link clicked");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
