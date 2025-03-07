import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:salesman/model/collection_model.dart';

class CollectionService {
  final Dio _dio = Dio();
  final String baseUrl = "https://salesman-tracking-app.onrender.com/api";

  Future<List<GetCollection>> fetchCollections(String salesmanId) async {
    try {
      final response =
          await _dio.get('$baseUrl/collections/salesman/$salesmanId');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['collections'];
        return data.map((json) => GetCollection.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch collections");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  Future<bool> addCollection(Map<String, dynamic> collectionData) async {
    try {
      Response response = await _dio.post(
        'https://salesman-tracking-app.onrender.com/api/collections',
        data: collectionData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to add collection");
      }
    } catch (e) {
      debugPrint("❌ Error adding collection: $e");
      return false;
    }
  }
}
