import 'package:flutter/material.dart';
import 'package:salesman/model/leader_board_model.dart';
import 'package:salesman/service/leader_board_service.dart';

class LeaderboardController with ChangeNotifier {
  final LeaderboardService _service = LeaderboardService();
  LeaderBoardModel? leaderboard;
  bool isLoading = false;

  Future<void> fetchLeaderboardData() async {
    isLoading = true;
    notifyListeners();

    leaderboard = await _service.fetchLeaderboard();

    isLoading = false;
    notifyListeners();
  }
}
