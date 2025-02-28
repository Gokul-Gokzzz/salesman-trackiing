import 'package:flutter/material.dart';
import '../model/collection_model.dart';
import '../service/collection_service.dart';

class CollectionProvider extends ChangeNotifier {
  final CollectionService _collectionService = CollectionService();
  GetCollectionModel? _collectionModel;
  bool _isLoading = false;

  GetCollectionModel? get collectionModel => _collectionModel;
  bool get isLoading => _isLoading;

  Future<void> loadCollections() async {
    _isLoading = true;
    notifyListeners();

    _collectionModel = await _collectionService.fetchCollections();

    _isLoading = false;
    notifyListeners();
  }
}
