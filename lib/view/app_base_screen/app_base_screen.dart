import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:salesman/controller/navigation_controller.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<NavigationController>(context);

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color(0XFFE7F1FF),
        height: 55,
        selectedIndex: controller.selectedIndex,
        onDestinationSelected: (value) => controller.updateIndex(value),
        backgroundColor: Colors.white,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/bottomnav_ic/mynaui_home.svg',
            ),
            label: "",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/bottomnav_ic/Star.svg',
            ),
            label: "",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/bottomnav_ic/Bag.svg',
            ),
            label: "",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/bottomnav_ic/bottom_person.svg',
            ),
            label: "",
          ),
        ],
      ),
      body: controller.screens[controller.selectedIndex],
    );
  }
}
