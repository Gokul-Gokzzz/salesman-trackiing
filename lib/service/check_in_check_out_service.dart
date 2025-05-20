import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:salesman/model/attandence/check_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mime/mime.dart'; // Import the mime package
import 'package:http_parser/http_parser.dart'; // Import for MediaType

class CheckInCheckOutService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/attendance";

  Future<Attendance?> checkIn(
      String salesmanId, String location, File imageFile) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception("No authentication token found.");
      }

      // Determine the MIME type of the image
      final mimeType = lookupMimeType(imageFile.path);
      log("Detected MIME type: $mimeType"); // Log the detected MIME type

      // Ensure a MIME type was found and it's an image
      if (mimeType == null || !mimeType.startsWith('image/')) {
        throw Exception(
            "Could not determine image MIME type or it's not an image.");
      }

      // Split the MIME type into type and subtype for MediaType
      final mediaTypeParts = mimeType.split('/');
      if (mediaTypeParts.length != 2) {
        throw Exception("Invalid MIME type format: $mimeType");
      }
      final mediaType = MediaType(mediaTypeParts[0], mediaTypeParts[1]);

      // Prepare multipart request with image, specifying the contentType
      FormData formData = FormData.fromMap({
        "salesman": salesmanId,
        "location": location,
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: mediaType, // Pass the detected MediaType here
        ),
      });

      Response response = await _dio.post(
        '$baseUrl/check-in',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type':
              'multipart/form-data', // This header is set by Dio when using FormData
        }),
        data: formData,
      );

      if (response.statusCode == 201) {
        final data = response.data['attendance'];
        if (data == null) {
          throw Exception("Error: 'attendance' field is missing in response");
        }
        return Attendance.fromJson(data);
      } else {
        throw Exception("Failed to check-in: ${response.statusMessage}");
      }
    } catch (e) {
      log("Error during check-in: $e"); // Use log for general errors, log for detailed
      throw Exception("Error during check-in: $e");
    }
  }

  Future<bool> checkOut(String attendanceId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("No authentication token found.");
      }

      Response response = await _dio.put(
        '$baseUrl/check-out/$attendanceId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
        data: {
          "timestamp": DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to check-out: ${response.statusMessage}");
      }
    } catch (e) {
      throw Exception("Error during check-out: $e");
    }
  }
}
