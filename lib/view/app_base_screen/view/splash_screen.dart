import 'package:flutter/material.dart';
import 'package:salesman/view/app_base_screen/view/tabview.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to the next screen after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyTabViewInBody()),
      );
    });

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
                // Center the CircleAvatar for better alignment
                child: CircleAvatar(
                  radius: 100, // Increased the radius
                  backgroundColor:
                      Colors.white, // Optional: Add color for better visibility
                  child: Image(
                    image: AssetImage("assets/images/tracking_plane.png"),
                    height: 140,
                  ), // Optional: Add content inside
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
