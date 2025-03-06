import 'package:flutter/material.dart';
import 'package:salesman/model/add_client_form_model.dart';
import 'package:salesman/service/add_client_form_service.dart';

class AddClientProvider with ChangeNotifier {
  final AddClientService _clientService = AddClientService();
  bool _isLoading = false;
  String? _message;
  AddClintModel? _clientModel;

  bool get isLoading => _isLoading;
  String? get message => _message;
  AddClintModel? get clientModel => _clientModel;

  Future<void> addClient(Map<String, dynamic> clientData) async {
    _isLoading = true;
    _message = null;
    notifyListeners();

    AddClintModel? response = await _clientService.addClient(clientData);
    if (response != null) {
      _clientModel = response;
      _message = "Client added successfully";
    } else {
      _message = "Failed to add client";
    }

    _isLoading = false;
    notifyListeners();
  }
}
