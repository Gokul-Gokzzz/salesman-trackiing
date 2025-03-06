import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/client_meeting_model.dart';
import 'package:salesman/model/meeting_model.dart';

class GetMeetingService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/meeting/salesman";

  Future<List<GetMeeting>?> fetchMeetings(String salesmanId) async {
    try {
      final response = await _dio.get("$_baseUrl/$salesmanId");

      if (response.statusCode == 200) {
        return MeetingModel.fromJson(response.data).meetings;
      } else {
        return null;
      }
    } catch (e) {
      log("Error fetching meetings: $e");
      return null;
    }
  }
}
