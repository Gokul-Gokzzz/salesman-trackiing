import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/collection_details_model.dart';

class CollectionDetailsService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/collections/collection";

  Future<Collection?> fetchCollectionDetails(String collectionId) async {
    try {
      final response = await _dio.get("$baseUrl/$collectionId");
      if (response.statusCode == 200) {
        return Collection.fromJson(response.data['collections']);
      } else {
        log("❌ Failed to load collection details");
        return null;
      }
    } catch (e) {
      log("❌ Error fetching collection details: $e");
      return null;
    }
  }

  Future<bool> editCollection(String id, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(
          'https://salesman-tracking-app.onrender.com/api/collections/$id',
          data: data);
      return response.statusCode == 200;
    } catch (e) {
      log("Error updating collection: $e");
      return false;
    }
  }

  Future<bool> deleteCollection(String collectionId) async {
    try {
      final response = await _dio.delete(
        "https://salesman-tracking-app.onrender.com/api/collections/$collectionId",
      );

      if (response.statusCode == 200) {
        log("✅ Collection deleted successfully: $collectionId");
        return true;
      } else {
        log("❌ Failed to delete collection: ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      log("❌ Error deleting collection: $e");
      return false;
    }
  }
}
