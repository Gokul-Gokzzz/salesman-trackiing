import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:salesman/model/reward_model.dart';
import 'package:salesman/service/reward_service.dart';

class RewardProvider extends ChangeNotifier {
  final RewardService _rewardService = RewardService();
  List<Reward> rewards = [];
  bool isLoading = false;

  RewardProvider() {
    fetchRewards();
  }

  Future<void> fetchRewards() async {
    try {
      isLoading = true;
      notifyListeners();

      GetRewardModel? result = await _rewardService.fetchRewards();
      if (result != null) {
        rewards = result.rewards ?? [];
      }
    } catch (e) {
      log("Error in RewardProvider: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
