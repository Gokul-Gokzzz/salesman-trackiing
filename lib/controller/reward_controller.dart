import 'package:flutter/material.dart';
import 'package:salesman/model/reward_model.dart';
import 'package:salesman/service/reward_service.dart';

class RewardProvider extends ChangeNotifier {
  final RewardService _rewardService = RewardService();
  List<Reward> _rewards = [];
  bool _isLoading = false;

  List<Reward> get rewards => _rewards;
  bool get isLoading => _isLoading;

  RewardProvider() {
    fetchRewards();
  }

  Future<void> fetchRewards() async {
    try {
      _isLoading = true;
      notifyListeners();

      GetRewardModel? result = await _rewardService.fetchRewards();
      if (result != null) {
        _rewards = result.rewards ?? [];
      }
    } catch (e) {
      print("Error in RewardProvider: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
