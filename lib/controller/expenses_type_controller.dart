import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:salesman/model/order/expenses_type_model.dart';
import 'package:salesman/service/expenses_type_service.dart';

class ExpenseTypeController extends ChangeNotifier {
  final ExpenseTypeService _service = ExpenseTypeService();
  ExpenseTypeModel? expenseTypeModel;
  bool _isLoading = false;

  List<ExpenseType> get expenseTypes => expenseTypeModel?.expenseTypes ?? [];
  bool get isLoading => _isLoading;

  Future<void> loadExpenseTypes() async {
    _isLoading = true;
    notifyListeners();

    try {
      expenseTypeModel = await _service.fetchExpenses();
      if (expenseTypeModel == null) {
        log("Failed to load expenses: Null response");
      }
    } catch (e) {
      log("Error fetching expenses: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
