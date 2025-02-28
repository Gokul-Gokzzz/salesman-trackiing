import 'package:dio/dio.dart';

class CheckInService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/attendance";

  Future<Map<String, dynamic>> checkIn(
      {required String salesmanId, required String location,String? authToken}) async {
    try {
      Response response = await _dio.post(
        "$_baseUrl/check-in",
        data: {
          "salesman": salesmanId,
          "location": location,
        },
          options: Options(
          headers: {
            if (authToken != null) 'Authorization': 'Bearer $authToken', // Pass the token in the header
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return {"success": true, "data": response.data};
      } else {
        return {"success": false, "message": "Check-in failed"};
      }
    } catch (e) {
      return {"success": false, "message": "An error occurred: $e"};
    }
  }
}
