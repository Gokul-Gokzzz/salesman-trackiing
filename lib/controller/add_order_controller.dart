import 'package:flutter/material.dart';
import 'package:salesman/model/add_order_model.dart';
import 'package:salesman/service/add_order_service.dart';

class OrderController extends ChangeNotifier {
  final OrderService _orderService = OrderService();
  bool isLoading = false;
  String message = "";

  Future<void> createOrder(Order order) async {
    isLoading = true;
    notifyListeners();

    message = await _orderService.createOrder(order);

    isLoading = false;
    notifyListeners();
  }
}
