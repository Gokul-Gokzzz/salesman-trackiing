import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/client/get_client_model.dart';

class ClientService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/client";
  Future<List<ClientModel>> fetchClients(String salesmanId) async {
    try {
      final response = await _dio.get("$baseUrl/salesman/$salesmanId");
      log("🔹 API Response: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null && data is Map<String, dynamic>) {
          final clientsData = data['clients'];

          if (clientsData is List) {
            return clientsData
                .where((json) => json != null) // Ensure no null items
                .map((json) =>
                    ClientModel.fromJson(json as Map<String, dynamic>))
                .toList();
          } else {
            log("❌ Clients data is null or not a list.");
            return [];
          }
        } else {
          log("❌ Response data is null or not a valid JSON object.");
          return [];
        }
      } else {
        log("❌ Failed to fetch clients: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log("❌ Error fetching clients: $e");
      return [];
    }
  }

  Future<ClientModel?> fetchClientById(String clientId) async {
    try {
      Response response = await _dio.get("$baseUrl/$clientId");
      log("ClientService: Request URL: $baseUrl/$clientId");
      log("ClientService: Response status code: ${response.statusCode}");
      log("ClientService: Response data: ${response.data}");

      if (response.statusCode == 200) {
        try {
          // Extract the nested 'client' object
          Map<String, dynamic> clientData = response.data['client'];
          return ClientModel.fromJson(
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

  Future<bool> updateClient(String clientId, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('$baseUrl/$clientId', data: data);
      return response.statusCode == 200;
    } catch (e) {
      log("Error updating client: $e");
      return false;
    }
  }

  Future<bool> deleteClient(String clientId) async {
    try {
      final response = await _dio.delete('$baseUrl/$clientId');
      return response.statusCode == 200;
    } catch (e) {
      log("Error deleting client: $e");
      return false;
    }
  }
}
