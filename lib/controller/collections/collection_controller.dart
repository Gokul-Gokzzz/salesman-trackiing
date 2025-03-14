import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/model/collection_model.dart';
import 'package:salesman/service/collections/collection_service.dart';

class CollectionProvider with ChangeNotifier {
  final CollectionService _service = CollectionService();
  List<GetCollection> collections = [];

  bool isLoading = false;

  Future<void> getCollections(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    try {
      collections = await _service.fetchCollections(salesmanId);
    } catch (e) {
      log("Error fetching collections: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  addCollection(Map<String, dynamic> collectionData) async {
    bool success = await _service.addCollection(collectionData);
    if (success) {
      getCollections(collectionData['salesman']); // Refresh list
    }
  }
}
