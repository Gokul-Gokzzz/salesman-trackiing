import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/reward_history_mode.dart';

class RewardHistoryService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/rewards/history/";

  Future<RewardHistoryModel?> fetchRewardHistory(String userId) async {
    try {
      final response = await _dio.get("$baseUrl$userId");

      if (response.statusCode == 200) {
        return RewardHistoryModel.fromJson(response.data);
      } else {
        log("Failed to fetch reward history: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error fetching reward history: $e");
      return null;
    }
  }
}
