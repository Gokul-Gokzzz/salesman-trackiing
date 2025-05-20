import 'package:dio/dio.dart';
import 'package:salesman/model/leader_board_model.dart';

class LeaderboardService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/leaderboard/";

  Future<LeaderBoardModel?> fetchLeaderboard() async {
    try {
      Response response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        return LeaderBoardModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error fetching leaderboard: $e");
    }
    return null;
  }
}
