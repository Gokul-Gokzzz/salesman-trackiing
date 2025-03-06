import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/reward_model.dart';

class RewardService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/rewards";

  Future<GetRewardModel?> fetchRewards() async {
    try {
      Response response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        return GetRewardModel.fromJson(response.data); // FIXED: Pass as a Map
      }
    } catch (e) {
      log("Error fetching rewards: $e");
    }
    return null;
  }
}
