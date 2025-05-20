import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/add_client_meeting_details_model.dart';

class AddClientMeetingDetailsService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/meeting";

  Future<AddClientMeetingDetailsModel?> createMeeting(
      AddMeeting meeting) async {
    try {
      final jsonData = meeting.toJson();
      log('Sending JSON: ${jsonEncode(jsonData)}');
      Response response = await _dio.post(
        baseUrl,
        data: meeting.toJson(),
      );

      if (response.statusCode == 201) {
        log('Response Data: ${response.data}');
        return AddClientMeetingDetailsModel.fromJson(response.data);
      }
    } catch (e) {
      log("Error creating meeting: $e");
    }

    return null;
  }

  Future<List<AddMeeting>> getMeetings() async {
    try {
      Response response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        return List<AddMeeting>.from(
            response.data.map((x) => AddMeeting.fromJson(x)));
      }
    } catch (e) {
      log("Error fetching meetings: $e");
    }
    return [];
  }
}
