import 'package:flutter/material.dart';
import 'package:salesman/model/collection_model.dart';
import 'package:salesman/service/collection_service.dart';

class CollectionProvider extends ChangeNotifier {
  final CollectionService _service = CollectionService();
  CollectionModel? _collectionModel;
  bool _isLoading = false;

  CollectionModel? get collectionModel => _collectionModel;
  bool get isLoading => _isLoading;

  Future<void> fetchCollections() async {
    _isLoading = true;
    notifyListeners();

    _collectionModel = await _service.fetchCollections();

    _isLoading = false;
    notifyListeners();
  }
}
