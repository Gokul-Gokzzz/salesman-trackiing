import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesman/model/redem_request_model.dart';
import 'package:salesman/service/redeme_request_service.dart';

class RedemptionProvider extends ChangeNotifier {
  final RedemptionService _service = RedemptionService();
  RedemptionRequestModel? redemptionRequest;
  bool isLoading = false;

  Future<bool> redeemReward(String userId, String rewardId) async {
    isLoading = true;
    notifyListeners();

    try {
      redemptionRequest = await _service.redeemReward(userId, rewardId);

      isLoading = false;
      notifyListeners();
      return true; // Return true on success
    } on DioException catch (e) {
      log('Error redeeming reward: $e');
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      log('Unexpected error redeeming reward: $e');
      isLoading = false;
      notifyListeners();
      return false; // Return false on failure
    }
  }
}
