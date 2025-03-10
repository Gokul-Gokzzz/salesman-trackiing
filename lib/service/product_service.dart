import 'dart:developer';

import 'package:dio/dio.dart';
import '../model/product_model.dart';

class ProductService {
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/products";
  final Dio _dio = Dio();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get(baseUrl);
      if (response.statusCode == 200) {
        final List<dynamic> productsJson = response.data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        log('Failed to load products: ${response.statusCode}');
        return [];
      }
    } on DioException catch (e) {
      log('Dio error fetching products: ${e.message}');
      log('Dio error fetching products: ${e.response}');
      return [];
    } catch (e) {
      log('Error fetching products: $e');
      return [];
    }
  }

  Future<Product?> fetchProductById(String productId) async {
    try {
      final response = await _dio.get('$baseUrl/$productId');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        log('Failed to load product: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      log('Dio error fetching product by id: ${e.message}');
      log('Dio error fetching product by id: ${e.response}');
      return null;
    } catch (e) {
      log('Error fetching product by id: $e');
      return null;
    }
  }

  Future<bool> updateProduct(
      String productId, Map<String, dynamic> productData) async {
    try {
      final response = await _dio.put('$baseUrl/$productId', data: productData);
      return response.statusCode == 200;
    } on DioException catch (e) {
      log('Dio error updating product: ${e.message}');
      log('Dio error updating product: ${e.response}');
      return false;
    } catch (e) {
      log('Error updating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      final response = await _dio.delete('$baseUrl/$productId');
      return response.statusCode == 200;
    } on DioException catch (e) {
      log('Dio error deleting product: ${e.message}');
      log('Dio error deleting product: ${e.response}');
      return false;
    } catch (e) {
      log('Error deleting product: $e');
      return false;
    }
  }
}
