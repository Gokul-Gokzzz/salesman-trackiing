import 'package:flutter/material.dart';
import 'package:salesman/model/dashboard_model.dart';
import 'package:salesman/service/dashboard_service.dart';

class UserMetricsController with ChangeNotifier {
  final UserMetricsService _service = UserMetricsService();
  UserMetricsModel? userMetrics;
  bool isLoading = false;

  Future<void> getUserMetrics(String userId) async {
    isLoading = true;
    notifyListeners();

    userMetrics = await _service.fetchUserMetrics(userId);

    isLoading = false;
    notifyListeners();
  }
}
