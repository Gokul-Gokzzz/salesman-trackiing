import 'package:flutter/material.dart';
import 'package:salesman/model/dashboard_model.dart';
import 'package:salesman/service/dashboard_service.dart';

class DashboardController extends ChangeNotifier {
  final DashboardService _service = DashboardService();
  DashoardModel? dashboardData;
  bool isLoading = true;

  Future<void> loadDashboardMetrics(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    dashboardData = await _service.fetchDashboardMetrics(salesmanId);

    isLoading = false;
    notifyListeners();
  }
}
