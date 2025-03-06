import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/add_note_model.dart';

class AddNoteService {
  final Dio _dio = Dio();
  final String _baseUrl =
      "https://salesman-tracking-app.onrender.com/api/notes";

  Future<bool> addNote(AddNoteModel noteModel) async {
    try {
      Response response = await _dio.post(
        _baseUrl,
        data: noteModel.toJson(),
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log("Error adding note: $e");
      return false;
    }
  }
}
