import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/model/detail_metting_model.dart';
import 'package:salesman/model/meeting_model.dart';
import 'package:salesman/service/fetch_meeting_service.dart';

class GetMeetingController extends ChangeNotifier {
  final GetMeetingService _meetingService = GetMeetingService();
  List<GetMeeting>? meetings;
  DetailedMeetingModel? meetingDetails;
  bool isLoading = false;

  Future<void> getMeetings(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    meetings = await _meetingService.fetchMeetings(salesmanId);

    isLoading = false;
    notifyListeners();
  }

  Future<void> getMeetingDetails(String meetingId) async {
    isLoading = true;
    notifyListeners();

    try {
      meetingDetails = await _meetingService.fetchMeetingDetails(meetingId);
      log("✅ Meeting Details Response: ${meetingDetails?.id}");
    } catch (e) {
      log("❌ Error fetching meeting details: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateMeeting(
      String meetingId, Map<String, dynamic> updatedData) async {
    bool success = await _meetingService.editMeeting(meetingId, updatedData);
    if (success) {
      await getMeetingDetails(meetingId); // Refresh data
    }
    return success;
  }

  Future<bool> removeMeeting(String meetingId) async {
    bool success = await _meetingService.deleteMeeting(meetingId);
    if (success) {
      meetingDetails = null;
      notifyListeners();
    }
    return success;
  }
}
