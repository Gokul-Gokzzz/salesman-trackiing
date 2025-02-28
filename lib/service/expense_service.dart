import 'dart:developer';

import 'package:dio/dio.dart';
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
}
