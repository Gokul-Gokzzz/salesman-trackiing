import 'dart:developer';

import 'package:dio/dio.dart';
import '../model/collection_model.dart';

class CollectionService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://salesman-tracking-app.onrender.com/api/collections';

  Future<GetCollectionModel?> fetchCollections() async {
    try {
      Response response = await _dio.get(_baseUrl);

      if (response.statusCode == 200) {
        return GetCollectionModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      log("Error fetching collections: $e");
      return null;
    }
  }
}
