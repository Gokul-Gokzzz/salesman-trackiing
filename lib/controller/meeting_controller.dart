import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:salesman/model/client_meeting_model.dart';
import 'package:salesman/model/meeting_model.dart';
import 'package:salesman/service/meeting_service.dart';

class MeetingController extends ChangeNotifier {
  final MeetingService _meetingService = MeetingService();
  MeetingModel? _meetingModel;
  ClintMeetingModel? _clientMeeting;
  bool _isLoading = false;
  String? _errorMessage;

  MeetingModel? get meetingModel => _meetingModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMeetings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _meetingModel = await _meetingService.getMeetings();
      log('MeetingModel in Controller: $_meetingModel'); // Add this line
      if (_meetingModel == null) {
        _errorMessage = 'Failed to load meetings.';
      }
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ClintMeetingModel? get clientMeeting => _clientMeeting;

  Future<void> fetchClientMeeting() async {
    _isLoading = true;
    notifyListeners();

    _clientMeeting = await _meetingService.getClientMeeting();

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> createMeeting({
    required String salesman,
    required String client,
    required DateTime date,
    required String location,
    required String agenda,
  }) async {
    bool success = await _meetingService.createClientMeeting(
      salesman: salesman,
      client: client,
      date: date,
      location: location,
      agenda: agenda,
    );

    if (success) {
      await fetchClientMeeting(); // Refresh meeting list
    }

    return success;
  }
}
