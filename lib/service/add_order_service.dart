import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:salesman/model/add_order_model.dart';

class OrderService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-backend.onrender.com/api/order";
  final Logger _logger = Logger();

  Future<String> createOrder(Order order) async {
    try {
      Response response = await _dio.post(
        _baseUrl,
        data: order.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "Order created successfully";
      } else {
        _logger
            .e("Failed to create order, Status Code: ${response.statusCode}");
        return "Failed to create order";
      }
    } catch (e, stacktrace) {
      _logger.e("Error creating order", error: e, stackTrace: stacktrace);
      return "Error: ${e.toString()}";
    }
  }
}
