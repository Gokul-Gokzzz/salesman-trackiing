import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/note_model.dart';

class NoteService {
  final Dio _dio = Dio();
  final String apiUrl =
      "https://salesman-tracking-app.onrender.com/api/notes"; // Replace with your actual API URL

  Future<List<GetNoteModel>> fetchNotes() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data; // Ensure it's a List
        return jsonData.map((item) => GetNoteModel.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log("Error fetching notes: $e");
      return [];
    }
  }
}
