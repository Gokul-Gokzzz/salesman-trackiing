import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/client_meeting_model.dart';
import 'package:salesman/model/detail_metting_model.dart';
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

  // fetchMeetingDetails(String meetingId) async {
  //   try {
  //     final response = await _dio.get(
  //       'https://salesman-tracking-app.onrender.com/api/meeting/getMeeting/$meetingId',
  //     );

  //     log("📩 API Response meeting detail: ${response.data}"); // Log the API response

  //     if (response.statusCode == 200) {
  //       return DetailedMeetingModel.fromJson(response.data);
  //     } else {
  //       log("⚠️ Unexpected status code: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     log("❌ Error fetching meeting details: $e");
  //     return null;
  //   }
  // }
  Future<DetailedMeetingModel?> fetchMeetingDetails(String meetingId) async {
    try {
      final response = await _dio.get(
        'https://salesman-tracking-app.onrender.com/api/meeting/getMeeting/$meetingId',
      );

      log("📩 API Response meeting detail: ${response.data['meeting']}");

      if (response.statusCode == 200) {
        return DetailedMeetingModel.fromJson(response.data['meeting']);
      } else {
        log("⚠️ Unexpected status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("❌ Error fetching meeting details: $e");
      return null;
    }
  }
}
