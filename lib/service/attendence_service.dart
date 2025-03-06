import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/attendence_model.dart';

class AttendanceService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/attendance";

  Future<AttendenceModel?> fetchAttendance(String salesmanId) async {
    try {
      final response = await _dio.get('$baseUrl/$salesmanId');

      if (response.statusCode == 200) {
        return AttendenceModel.fromJson(response.data);
      } else {
        log("API returned status code: ${response.statusCode}");
        log("Response data: ${response.data}"); // Log the response data
        return null;
      }
    } on DioException catch (e) {
      log("DioException fetching attendance: ${e.message}");
      log("DioException response: ${e.response?.data}"); // Log the response data
      log("DioException status code: ${e.response?.statusCode}"); // Log status code
      return null;
    } catch (e) {
      log("Error fetching attendance: $e");
      return null;
    }
  }
}
