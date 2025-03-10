import 'dart:developer';

import 'package:salesman/model/client/get_client_model.dart'; // ✅ Use the correct Client model
import 'package:salesman/service/client/get_client_service.dart';
import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier {
  List<ClientModel> clients = []; // ✅ Now refers to the correct Client model
  bool isLoading = false;
  ClientModel? selectedClient;

  final ClientService _clientService = ClientService();

  Future<void> getClients(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    clients = await _clientService.fetchClients(salesmanId);

    isLoading = false;
    notifyListeners();
  }

  fetchClientDetails(String clientId) async {
    isLoading = true;
    notifyListeners();
    selectedClient = await _clientService.fetchClientById(clientId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateClient(String clientId, Map<String, dynamic> data) async {
    bool success = await _clientService.updateClient(clientId, data);
    if (success) {
      await fetchClientDetails(clientId); // Refresh data after update
    }
    return success;
  }

  Future<bool> deleteClient(String clientId) async {
    bool success = await _clientService.deleteClient(clientId);
    if (success) {
      selectedClient = null; // Clear client data after deletion
      notifyListeners();
    }
    return success;
  }
}
