import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/model/attandence/attendence_model.dart';
import 'package:salesman/service/attandence/attendence_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceController with ChangeNotifier {
  final AttendanceService _service = AttendanceService();
  AttendenceModel? attendanceData;
  bool isLoading = false;
  String lastCheckOut = "Not Available";
  String lastCheckIn = "Not Available";

  Future<void> getAttendance() async {
    final prefs = await SharedPreferences.getInstance();
    String? salesmanId =
        prefs.getString('id'); // Retrieve ID from SharedPreferences
    isLoading = true;
    notifyListeners();

    attendanceData = await _service.fetchAttendance(salesmanId.toString());

    lastCheckOut = attendanceData!.records!.last.checkOutTime.toString();
    lastCheckIn = attendanceData!.records!.last.checkInTime.toString();

    log(attendanceData!.records!.last.checkOutTime.toString());
    isLoading = false;
    notifyListeners();
  }
}
