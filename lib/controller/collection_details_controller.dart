import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/model/collection_details_model.dart';
import 'package:salesman/service/collection_details_service.dart';

class CollectionDetailsProvider extends ChangeNotifier {
  final CollectionDetailsService _collectionService =
      CollectionDetailsService();
  Collection? collection;
  bool isLoading = false;

  Future<void> getCollectionDetails(String collectionId) async {
    try {
      log("Fetching collection details for ID: $collectionId");
      isLoading = true;
      notifyListeners();

      collection =
          await _collectionService.fetchCollectionDetails(collectionId);
      log("Collection fetched: ${collection?.client.name}");
      isLoading = false;
      notifyListeners();
    } catch (e) {
      log("Error fetching collection details: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateCollection(String id, Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    bool success = await _collectionService.editCollection(id, data);

    if (success) {
      await getCollectionDetails(id); // Refresh data after updating
    }

    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<void> deleteCollection(
      String collectionId, BuildContext context) async {
    bool success = await _collectionService.deleteCollection(collectionId);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Collection deleted successfully")),
      );
      notifyListeners(); // Refresh UI after deletion
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete collection")),
      );
    }
  }
}
