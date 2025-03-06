import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:salesman/model/check_in_model.dart';
import 'package:salesman/service/shared_preference.dart';

class CheckInController {
  final Dio _dio = Dio();
  CheckInRequestModel? lastCheckInData; // Store check-in data
  String? lastAttendanceId; // Store the last check-in ID
  final Logger _logger = Logger(); // Logger instance for debugging

  String baseUrl = "https://salesman-tracking-app.onrender.com/api/attendance";

  Future<void> handleCheckIn(
      BuildContext context, String salesmanId, String location) async {
    try {
      // Retrieve token from AuthStorage
      final authData = await AuthStorage.loadAuthData();
      final token = authData['token'];

      if (token == null) {
        _logger.e("❌ No token found, user not authenticated.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Authentication failed. Please log in again.")),
        );
        return;
      }

      Response response = await _dio.post(
        "$baseUrl/check-in",
        data: {
          "salesman": salesmanId,
          "location": location,
          "timestamp": DateTime.now().toIso8601String(),
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        final responseData = response.data;
        if (responseData['message'] == "Checked in successfully") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Checked in successfully!")),
          );
          _logger.i("✅ Check-in successful: ${responseData['attendance']}");

          // Store the check-in response to use for check-out
          lastCheckInData = CheckInRequestModel.fromJson(responseData);
          lastAttendanceId = lastCheckInData?.attendance?.id; // Store _id

          _logger.i("✅ Stored Attendance ID: $lastAttendanceId");
        } else {
          _logger
              .e("⚠️ Unexpected response message: ${responseData['message']}");
        }
      } else {
        _logger.e(
            "❌ Failed to check-in. Status: ${response.statusCode}, Response: ${response.data}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Check-in failed. Please try again.")),
        );
      }
    } catch (e, stackTrace) {
      _logger.e("❌ Error during check-in", error: e, stackTrace: stackTrace);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred while checking in.")),
      );
    }
  }

  Future<void> handleCheckOut(BuildContext context) async {
    try {
      // Ensure we have a stored attendance ID
      if (lastAttendanceId == null) {
        _logger.e("❌ No attendance record found for checkout.");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No valid check-in record found!")),
        );
        return;
      }

      // Retrieve token from AuthStorage
      final authData = await AuthStorage.loadAuthData();
      final token = authData['token'];

      if (token == null) {
        _logger.e("❌ No token found, user not authenticated.");
        return;
      }

      Response response = await _dio.put(
        "$baseUrl/check-out/$lastAttendanceId", // Use stored ID
        data: {
          "timestamp": DateTime.now().toIso8601String(),
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Checked out successfully!")),
        );
        _logger.i("✅ Check-out successful for ID: $lastAttendanceId");

        // Clear stored attendance ID after successful check-out
        lastAttendanceId = null;
      } else {
        _logger.e(
            "❌ Failed to check-out: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      _logger.e(
          "🚨 DioException: ${e.response?.statusCode} - ${e.response?.data}");
    } catch (e, stackTrace) {
      _logger.e("❌ Error during check-out", error: e, stackTrace: stackTrace);
    }
  }
}
