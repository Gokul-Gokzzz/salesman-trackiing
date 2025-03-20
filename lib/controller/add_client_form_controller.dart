import 'package:flutter/material.dart';
import 'package:salesman/model/add_client_form_model.dart';
import 'package:salesman/service/add_client_form_service.dart';

class AddClientProvider extends ChangeNotifier {
  final AddClientService _clientService = AddClientService();
  bool isLoading = false;

  Future<AddClient> addClient(AddClient client) async {
    return await _clientService.addClient(client);
  }
}
