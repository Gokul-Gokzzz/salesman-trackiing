import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/add_expence_model.dart';
import 'package:salesman/model/expense_model.dart';

class ExpenseService {
  final Dio _dio = Dio();
  final String _baseUrl =
      'https://salesman-tracking-app.onrender.com/api/expense/salesman/67a9bcd879021f36d7fe0681';

  Future<GetExpenseModel?> fetchExpenses() async {
    try {
      final response = await _dio.get(_baseUrl);
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
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YmQ0YzQ3ODVlMjM3NmFjNzIwODU5NyIsIm5hbWUiOiJqa3oiLCJpYXQiOjE3NDA5OTE1OTksImV4cCI6MTc0MTAyMDM5OX0.ExK0QBCbo6vwqLEfoU9CIZR5pPW5DXzvLxmL8yP_Sok", // 🔹 Add a valid token
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
}
