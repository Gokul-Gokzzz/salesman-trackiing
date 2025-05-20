import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/add_client_form_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClientService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/client/";

  // In ClientService
  Future<AddClient> addClient(AddClient client) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      if (token == null || token.isEmpty) {
        throw Exception("No authentication token found.");
      }

      final response = await _dio.post(
        baseUrl,
        data: client.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        return AddClient.fromJson(response.data['client']);
      } else {
        throw Exception(
            "Failed to add client: ${response.statusCode} - ${response.data}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Error adding client: $e");
    }
  }
}
