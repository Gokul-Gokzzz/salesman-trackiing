import 'package:flutter/material.dart';
import 'package:salesman/model/add_client_meeting_details_model.dart';
import 'package:salesman/model/client_meeting_model.dart';
import 'package:salesman/service/add_client_meeting_details_service.dart';

class AddClientMeetingDetailsController extends ChangeNotifier {
  final AddClientMeetingDetailsService _meetingService =
      AddClientMeetingDetailsService();
  List<AddMeeting> meetings = [];
  bool isLoading = false;

  Future<void> fetchMeetings() async {
    isLoading = true;
    notifyListeners();

    meetings = await _meetingService.getMeetings();

    isLoading = false;
    notifyListeners();
  }

  Future<void> createMeeting(AddMeeting meeting, BuildContext context) async {
    AddClientMeetingDetailsModel? newMeeting =
        await _meetingService.createMeeting(meeting);
    if (newMeeting != null && newMeeting.meeting != null) {
      meetings.add(newMeeting.meeting!);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Meeting created successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create meeting")),
      );
    }
  }
}
