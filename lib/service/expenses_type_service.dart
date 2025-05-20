import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/order/expenses_type_model.dart';

class ExpenseTypeService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/expenseType/";

  Future<ExpenseTypeModel?> fetchExpenses() async {
    try {
      Response response = await _dio.get(_baseUrl);
      if (response.statusCode == 200) {
        return ExpenseTypeModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load expense types");
      }
    } catch (e) {
      log("Error fetching expense types: $e");
      return null; // Return null in case of error
    }
  }
}
