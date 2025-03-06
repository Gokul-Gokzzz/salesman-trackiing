// import 'package:flutter/material.dart';
// import 'package:salesman/view/app_base_screen/view/tabview.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Navigate to the next screen after 5 seconds
//     Future.delayed(const Duration(seconds: 5), () async {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const MyTabViewInBody()),
//       );
//     });

//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               width: double.maxFinite,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/splashscreen_bg.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: const Center(
//                 // Center the CircleAvatar for better alignment
//                 child: CircleAvatar(
//                   radius: 100, // Increased the radius
//                   backgroundColor:
//                       Colors.white, // Optional: Add color for better visibility
//                   child: Image(
//                     image: AssetImage("assets/images/tracking_plane.png"),
//                     height: 140,
//                   ), // Optional: Add content inside
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/view/app_base_screen/app_base_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesman/view/app_base_screen/view/tabview.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    log('🔍 Checking Token in SplashScreen: $token');

    // Delay for splash screen effect
    await Future.delayed(const Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      log('✅ Valid Token Found, Navigating to DashBoardScreen');
      // If token exists, go to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BaseScreen()),
      );
    } else {
      log('⚠️ No Valid Token Found, Navigating to MyTabViewInBoady');
      // No token found, navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyTabViewInBody()),
      );
    }
  }
  // Future<void> _checkLoginStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.reload(); // Ensure the latest data is loaded
  //   final token = prefs.getString('auth_token')?.trim();

  //   log('🔍 Checking Token in SplashScreen: $token');

  //   await Future.delayed(const Duration(seconds: 3)); // Keep splash delay

  //   if (!mounted)
  //     return; // Ensure the widget is still mounted before navigation

  //   if (token != null && token.isNotEmpty) {
  //     log('✅ Valid Token Found, Navigating to MyTabViewInBody');
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const DashBoardScreen()),
  //     );
  //   } else {
  //     log('⚠️ No Valid Token Found, Navigating to DashBoardScreen');
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const MyTabViewInBody()),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splashscreen_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  child: Image(
                    image: AssetImage("assets/images/tracking_plane.png"),
                    height: 140,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
