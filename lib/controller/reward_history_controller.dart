import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:salesman/model/reward_history_mode.dart';
import 'package:salesman/service/reward_history_service.dart';

class RewardHistoryProvider extends ChangeNotifier {
  final RewardHistoryService _rewardHistoryService = RewardHistoryService();
  List<RewardHistory> rewardHistory = [];
  bool isLoading = false;

  // RewardHistoryProvider(String userId) {
  //   fetchRewardHistory(userId);
  // }

  Future<void> fetchRewardHistory(String userId) async {
    try {
      isLoading = true;
      notifyListeners();

      RewardHistoryModel? result =
          await _rewardHistoryService.fetchRewardHistory(userId);
      if (result != null) {
        rewardHistory = result.rewardHistory;
      }
    } catch (e) {
      log("Error in RewardHistoryProvider: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
