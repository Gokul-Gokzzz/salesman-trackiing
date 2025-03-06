import 'package:flutter/material.dart';
import 'package:salesman/model/attendence_model.dart';
import 'package:salesman/service/attendence_service.dart';

class AttendanceController with ChangeNotifier {
  final AttendanceService _service = AttendanceService();
  AttendenceModel? attendanceData;
  bool isLoading = false;

  Future<void> getAttendance(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    attendanceData = await _service.fetchAttendance(salesmanId);

    isLoading = false;
    notifyListeners();
  }
}
