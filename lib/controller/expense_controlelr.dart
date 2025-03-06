import 'package:flutter/material.dart';
import 'package:salesman/model/add_expence_model.dart' show AddExpenseModel;
import 'package:salesman/model/expense_model.dart';
import 'package:salesman/service/expense_service.dart';

class ExpenseController extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();
  List<Expense> _expenses = [];
  bool _isLoading = false;
  String? errorMessage;
  AddExpenseModel? addExpenseResponse;
  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;

  Future<void> loadExpenses(String salesmanId) async {
    _isLoading = true;
    notifyListeners();

    final expenseModel = await _expenseService.fetchExpenses(salesmanId);
    if (expenseModel != null) {
      _expenses = expenseModel.expenses ?? [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> submitExpense({
    String? expenseType,
    int? amount,
    String? notes,
    String? receiptUrl,
    String? status,
  }) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      addExpenseResponse = await _expenseService.addExpense(
        expenseType: expenseType ?? '',
        amount: amount ?? 0,
        notes: notes ?? '',
        receiptUrl: receiptUrl ?? '',
        status: status ?? '',
      );

      if (addExpenseResponse == null) {
        errorMessage = "Failed to add expense.";
      }
    } catch (e) {
      errorMessage = "An error occurred: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
