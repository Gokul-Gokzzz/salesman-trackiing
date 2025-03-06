import 'package:flutter/material.dart';
import 'package:salesman/model/meeting_model.dart';
import 'package:salesman/service/fetch_meeting_service.dart';

class GetMeetingController extends ChangeNotifier {
  final GetMeetingService _meetingService = GetMeetingService();
  List<GetMeeting>? meetings;
  bool isLoading = false;

  Future<void> getMeetings(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    meetings = await _meetingService.fetchMeetings(salesmanId);

    isLoading = false;
    notifyListeners();
  }
}
