import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/get_client_model.dart';

class ClientService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/client";

  Future<GetClientModel?> fetchClients() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        return GetClientModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log("Error fetching clients: $e");
      return null;
    }
  }

  Future<Client?> fetchClientById(String clientId) async {
    try {
      Response response = await _dio.get("$baseUrl/$clientId");
      log("ClientService: Request URL: $baseUrl/$clientId");
      log("ClientService: Response status code: ${response.statusCode}");
      log("ClientService: Response data: ${response.data}");

      if (response.statusCode == 200) {
        try {
          // Extract the nested 'client' object
          Map<String, dynamic> clientData = response.data['client'];
          return Client.fromJson(
              clientData); // Pass the nested object to Client.fromJson
        } catch (e) {
          log("ClientService: Error parsing JSON: $e");
          return null;
        }
      } else {
        log("ClientService: API returned error status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("ClientService: Error fetching client details: $e");
      return null;
    }
  }
}
