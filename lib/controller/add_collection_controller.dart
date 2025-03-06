import 'package:flutter/material.dart';
import 'package:salesman/model/add_collection_model.dart';
import 'package:salesman/service/add_collection_service.dart';

class CollectionController with ChangeNotifier {
  final AddCollectionService _collectionService = AddCollectionService();
  bool isLoading = false;
  String? errorMessage;
  AddCollectionModel? collectionData;

  Future<void> submitCollection({
    required String client,
    required String salesman,
    required int amount,
    required DateTime date,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      collectionData = await _collectionService.addCollection(
        client: client,
        salesman: salesman,
        amount: amount,
        date: date,
      );

      if (collectionData == null) {
        errorMessage = "Failed to add collection.";
      }
    } catch (e) {
      errorMessage = "An error occurred.";
    }

    isLoading = false;
    notifyListeners();
  }
}
