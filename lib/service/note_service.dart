import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/add_note_model.dart';
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

  Future<bool> deleteNote(String noteId) async {
    try {
      Response response = await _dio.delete(
        "$apiUrl/$noteId",
        options: Options(headers: {
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log("Note deleted successfully");
        return true;
      } else {
        log("Failed to delete note: ${response.statusMessage}");
        return false;
      }
    } catch (e) {
      log("Error deleting note: $e");
      return false;
    }
  }
}
