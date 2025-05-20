import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/order/order_sumery_model.dart';

class OrderSummaryService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/order/salesman";

  Future<List<OrderSummary>> fetchOrders(String salesmanId) async {
    try {
      final response = await _dio.get("$_baseUrl/$salesmanId");

      if (response.statusCode == 200) {
        List ordersData = response.data['orders'];
        return ordersData.map((json) => OrderSummary.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load orders");
      }
    } catch (e) {
      log("Error fetching orders: $e");
      return [];
    }
  }
}
