import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/field_staff_model.dart';

class FieldStaffService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/field-staff";

  Future<List<FieldStaff>> fetchFieldStaff() async {
    try {
      Response response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data["staff"];
        return data.map((staff) => FieldStaff.fromJson(staff)).toList();
      } else {
        throw Exception("Failed to load field staff");
      }
    } catch (e) {
      log("Error fetching field staff: $e");
      return [];
    }
  }
}
