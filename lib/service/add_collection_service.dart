import 'package:dio/dio.dart';
import 'package:salesman/model/add_collection_model.dart';

class AddCollectionService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/collections";

  Future<AddCollectionModel?> addCollection({
    required String client,
    required String salesman,
    required int amount,
    required DateTime date,
  }) async {
    try {
      Response response = await _dio.post(
        _baseUrl,
        data: {
          "client": client,
          "salesman": salesman,
          "amount": amount,
          "date": date.toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AddCollectionModel.fromJson(response.data);
      }
    } catch (e) {
      print("Error adding collection: $e");
    }
    return null;
  }
}
