import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/dashboard_model.dart';

class DashboardService {
  final Dio _dio = Dio();

  Future<DashoardModel?> fetchDashboardMetrics(String salesmanId) async {
    try {
      final response = await _dio.get(
        'https://salesman-tracking-app.onrender.com/api/user/metrics/$salesmanId',
      );

      if (response.statusCode == 200 && response.data != null) {
        return DashoardModel.fromJson(response.data);
      }
    } catch (e) {
      log("❌ Error fetching dashboard metrics: $e");
    }
    return null;
  }
}
