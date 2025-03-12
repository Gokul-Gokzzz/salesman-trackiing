import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:salesman/model/add_expence_model.dart' show AddExpenseModel;
import 'package:salesman/model/expense_model.dart';
import 'package:salesman/service/expense_service.dart';

class ExpenseController extends ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();
  List<Expense> _expenses = [];
  List<Expense> _filteredExpenses = [];
  bool _isLoading = false;
  String? errorMessage;
  AddExpenseModel? addExpenseResponse;
  String _searchQuery = '';

  List<Expense> get expenses => _filteredExpenses;
  bool get isLoading => _isLoading;

  Future<void> loadExpenses(String salesmanId) async {
    _isLoading = true;
    notifyListeners();

    final expenseModel = await _expenseService.fetchExpenses(salesmanId);
    if (expenseModel != null) {
      _expenses = expenseModel.expenses ?? [];
    }
    applyFilter();
    _isLoading = false;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    applyFilter();
  }

  void applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredExpenses = _expenses;
    } else {
      _filteredExpenses = _expenses.where((expense) {
        return expense.notes!.toLowerCase().contains(_searchQuery) ||
            expense.expenseType!.toLowerCase().contains(_searchQuery) ||
            expense.amount.toString().contains(_searchQuery);
      }).toList();
    }
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

  Future<void> fetchExpense(String expenseId) async {
    _isLoading = true;
    notifyListeners();

    final expenseModel = await _expenseService.getExpenseById(expenseId);
    if (expenseModel != null) {
      _expenses = expenseModel.expenses ?? [];
    }
    applyFilter();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateExpense(
      BuildContext context, String expenseId, Map<String, dynamic> data) async {
    try {
      bool success = await _expenseService.updateExpense(expenseId, data);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Expense updated successfully")),
        );
        notifyListeners();
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to update expense")),
        );
        return false;
      }
    } catch (e) {
      log('Error in updateExpense controller: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to update expense")),
      );
      return false;
    }
  }

  Future<void> deleteExpense(BuildContext context, String expenseId) async {
    bool success = await _expenseService.deleteExpense(expenseId);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Expense deleted successfully")),
      );
      Navigator.pop(context);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete expense")),
      );
    }
  }
}
