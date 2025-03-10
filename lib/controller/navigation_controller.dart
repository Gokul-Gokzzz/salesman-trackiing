import 'package:flutter/material.dart';
import 'package:salesman/view/app_base_screen/view/meetings/add_client_screen.dart';
import 'package:salesman/view/app_base_screen/view/attandence/attandence_tracking.dart';
import 'package:salesman/view/app_base_screen/view/clients/client_list_screen.dart';
import 'package:salesman/view/app_base_screen/view/dashboard/dashboard_screen.dart';
import 'package:salesman/view/app_base_screen/view/leaderboard/leaderboard_screen.dart';

class NavigationController extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void updateIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> get screens => [
        const DashBoardScreen(),
        const LeaderBoard(),
        const ClientListScreen(),
        const AttendanceTracking(),
      ];
}
