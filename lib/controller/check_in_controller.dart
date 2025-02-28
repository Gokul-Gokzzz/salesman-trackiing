import 'package:flutter/material.dart';
import 'package:salesman/model/check_in_model.dart';
import 'package:salesman/service/check_in_service.dart';
import 'package:salesman/service/shared_preference.dart';

class CheckInController {
  final CheckInService _checkInService = CheckInService();
  final CheckInRequestModel checkInRequestModel = CheckInRequestModel();

  Future<void> handleCheckIn(
      BuildContext context, String salesmanId, String location) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final response = await _checkInService.checkIn(
        salesmanId: salesmanId,
        location: location,
        authToken: await SharedPrefsHelper.getToken());

    Navigator.pop(context); // Remove loading indicator

    if (response["success"]) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check-in successful!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["message"])),
      );
    }
  }
}
