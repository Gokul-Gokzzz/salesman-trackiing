import 'package:flutter/material.dart';
import 'package:salesman/model/redem_request_model.dart';
import 'package:salesman/service/redeme_request_service.dart';

class RedemptionProvider extends ChangeNotifier {
  final RedemptionService _service = RedemptionService();
  RedemptionRequestModel? redemptionRequest;
  bool isLoading = false;

  Future<void> redeemReward(String userId, String rewardId) async {
    isLoading = true;
    notifyListeners();

    redemptionRequest = await _service.redeemReward(userId, rewardId);

    isLoading = false;
    notifyListeners();
  }
}
