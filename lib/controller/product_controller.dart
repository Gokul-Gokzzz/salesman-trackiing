import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> products = [];
  Product? singleProduct;
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();
    products = await _productService.fetchProducts();
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchProductById(String productId) async {
    isLoading = true;
    notifyListeners();
    singleProduct = await _productService.fetchProductById(productId);
    isLoading = false;
    notifyListeners();
  }
}
