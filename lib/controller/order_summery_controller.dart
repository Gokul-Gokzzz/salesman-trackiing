import 'package:flutter/material.dart';
import 'package:salesman/model/order/order_sumery_model.dart';
import 'package:salesman/service/order_summery_service.dart';

class OrderSummaryController extends ChangeNotifier {
  final OrderSummaryService _orderService = OrderSummaryService();
  List<OrderSummary> orders = [];
  bool isLoading = false;

  Future<void> loadOrders(String salesmanId) async {
    isLoading = true;
    notifyListeners();

    orders = await _orderService.fetchOrders(salesmanId);

    isLoading = false;
    notifyListeners();
  }
}
