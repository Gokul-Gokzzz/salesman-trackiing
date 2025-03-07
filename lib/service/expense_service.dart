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
        return GetExpenseModel.fromJson(response.data);
      }
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
      String? token = prefs.getString('auth_token'); // Retrieve saved token

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
            "Authorization": "Bearer $token", // Use dynamic token
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddExpenseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      log("Error adding expense: ${e.message}");
      log("Error adding expense: ${e.response}");
    } catch (e) {
      log("Error adding expense: $e");
    }
    return null;
  }

//  Future<void> _saveUserData(Map<String, dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('auth_token', data['token']);
//     await prefs.setString('user_name', data['user']['name'] ?? '');

//     // Verify if data is saved properly
//     log('✅ Saving Token: ${data['token']}');
//     log('✅ Saving User Name: ${data['user']['name']}');

//     // Retrieve immediately to check
//     String? savedToken = prefs.getString('auth_token');
//     log('🔎 Retrieved Token: $savedToken');
//   }
}
