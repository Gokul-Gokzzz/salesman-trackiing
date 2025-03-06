import 'package:salesman/model/get_client_model.dart'; // ✅ Use the correct Client model
import 'package:salesman/service/get_client_service.dart';
import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier {
  List<Client> clients = []; // ✅ Now refers to the correct Client model
  bool isLoading = false;
  Client? selectedClient;

  final ClientService _clientService = ClientService();

  Future<void> fetchClients() async {
    isLoading = true;
    notifyListeners();

    final result = await _clientService.fetchClients();
    if (result != null && result.clients != null) {
      clients = result.clients!; // ✅ No type mismatch
    }

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
}
