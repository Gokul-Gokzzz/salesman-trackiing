import 'package:dio/dio.dart';
import 'package:salesman/model/redem_request_model.dart';

class RedemptionService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/redeem";

  Future<RedemptionRequestModel?> redeemReward(
      String userId, String rewardId) async {
    try {
      final response = await _dio.post(_baseUrl, data: {
        "userId": userId,
        "rewardId": rewardId,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RedemptionRequestModel.fromJson(
            response.data["redemptionRequest"]);
      }
    } catch (e) {
      print("Error redeeming reward: $e");
    }
    return null;
  }
}
