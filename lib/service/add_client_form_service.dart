import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/add_client_form_model.dart';

class AddClientService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/client/";

  // In ClientService
  Future<AddClintModel?> addClient(Map<String, dynamic> clientData) async {
    try {
      Response response = await _dio.post(baseUrl, data: clientData);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return AddClintModel.fromJson(response.data);
      }
      return null;
    } on DioException catch (e) {
      log("Dio Error adding client: ${e.message}");
      log("Dio Error Response add client form: ${e.response}"); // Log the response for more details
      return null;
    } catch (e) {
      log("General Error adding client: $e");
      return null;
    }
  }
}
