import 'package:flutter/material.dart';
import 'package:salesman/model/expense_model.dart';
import 'package:salesman/service/expense_service.dart';

class ExpenseController extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();
  List<Expense> _expenses = [];
  bool _isLoading = false;

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;

  Future<void> loadExpenses() async {
    _isLoading = true;
    notifyListeners();

    final expenseModel = await _expenseService.fetchExpenses();
    if (expenseModel != null) {
      _expenses = expenseModel.expenses ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
