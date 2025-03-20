import 'dart:io';

import 'package:salesman/model/attandence/check_in_model.dart';
import 'package:salesman/service/check_in_check_out_service.dart';

class CheckInCheckOutController {
  final CheckInCheckOutService _attendanceService = CheckInCheckOutService();

  Future<Attendance?> checkIn(
      String salesmanId, String location, File imageFile) async {
    return await _attendanceService.checkIn(salesmanId, location, imageFile);
  }

  Future<bool> checkOut(String attendanceId) async {
    return await _attendanceService.checkOut(attendanceId);
  }
}
