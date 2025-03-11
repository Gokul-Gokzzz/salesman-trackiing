import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/add_expence_model.dart';
import 'package:salesman/model/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://salesman-tracking-app.onrender.com/api/expense/salesman';

  Future<GetExpenseModel?> fetchExpenses(String salesmanId) async {
    try {
      final response = await _dio.get("$_baseUrl/$salesmanId");
      if (response.statusCode == 200) {
        return GetExpenseModel.fromJson(response.data['expenses']);
      }
      log("response : $response");
    } catch (e) {
      log('Error fetching expenses: $e');
    }
    return null;
  }

  Future<AddExpenseModel?> addExpense({
    String? expenseType,
    int? amount,
    String? notes,
    String? receiptUrl,
    String? status,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      log("🔑 Retrieved Token (addExpense): $token"); // Log the token

      if (token == null) {
        log("⚠️ No auth token found. User might not be logged in.");
        return null;
      }

      Response response = await _dio.post(
        "https://salesman-tracking-app.onrender.com/api/expense",
        data: {
          "expenseType": expenseType ?? "",
          "amount": amount ?? 0,
          "notes": notes ?? "",
          "receiptURL": receiptUrl ?? "",
          "status": status ?? "",
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddExpenseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      log("❌ Error adding expense: ${e.message}");
      log("❌ Response: ${e.response}");
    } catch (e) {
      log("❌ Unexpected error adding expense: $e");
    }
    return null;
  }

  Future<GetExpenseModel?> getExpenseById(String expenseId) async {
    try {
      final response = await _dio.get(
          "https://salesman-tracking-app.onrender.com/api/expense/getExpense/$expenseId");

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      log("❌ Error fetching expense: $e");
    }
    return null;
  }

  Future<bool> updateExpense(
      String expenseId, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      log("🔑 Retrieved Token (updateExpense): $token"); // Log the token

      if (token == null || token.isEmpty) {
        log("❌ No authentication token found.");
        return false;
      }

      log("Sending updateExpense request with token: $token"); // Log before request

      Response response = await _dio.put(
        "https://salesman-tracking-app.onrender.com/api/expense/$expenseId",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        log("✅ Expense updated successfully");
        return true;
      } else {
        log("⚠️ Failed to update expense: ${response.data}");
        log("⚠️ Failed to update expense status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      log("❌ Error updating expense: $e");
      return false;
    }
  }

  Future<bool> deleteExpense(String expenseId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      log("🔑 Retrieved Token (deleteExpense): $token"); // Log the token

      if (token == null) {
        log("❌ No authentication token found.");
        return false;
      }

      Response response = await _dio.delete(
        "https://salesman-tracking-app.onrender.com/api/expense/$expenseId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );

      return response.statusCode == 200;
    } catch (e) {
      log("❌ Error deleting expense: $e");
      return false;
    }
  }
}
