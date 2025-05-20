import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/dashboard_model.dart';

class UserMetricsService {
  final Dio _dio = Dio();

  Future<UserMetricsModel?> fetchUserMetrics(String userId) async {
    try {
      String url =
          "https://salesman-tracking-backend.onrender.com/api/user/metrics/$userId";
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        return UserMetricsModel.fromJson(response.data);
      } else {
        log("❌ Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("❌ API Error: $e");
      return null;
    }
  }
}
