// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:salesman/model/add_note_model.dart';
// import 'package:salesman/model/note_model.dart';

// class NoteService {
//   final Dio _dio = Dio();
//   final String apiUrl =
//       "https://salesman-tracking-app.onrender.com/api/notes"; // Replace with your actual API URL

//   Future<List<GetNoteModel>> fetchNotes(String salesmanId) async {
//     try {
//       final response = await _dio.get(
//           "https://salesman-tracking-app.onrender.com/api/notes/salesman/$salesmanId");

//       if (response.statusCode == 200) {
//         final data = response.data;

//         // Ensure the response contains a list
//         if (data is Map<String, dynamic> && data.containsKey('data')) {
//           List<dynamic> jsonData = data['data']; // Extract the list
//           return jsonData.map((item) => GetNoteModel.fromJson(item)).toList();
//         } else {
//           log("Unexpected API response format: $data");
//           return [];
//         }
//       } else {
//         log("API Error: ${response.statusCode}");
//         return [];
//       }
//     } catch (e) {
//       log("Error fetching notes: $e");
//       return [];
//     }
//   }

//   Future<bool> deleteNote(String noteId) async {
//     try {
//       Response response = await _dio.delete(
//         "$apiUrl/$noteId",
//         options: Options(headers: {
//           "Content-Type": "application/json",
//         }),
//       );

//       if (response.statusCode == 200 || response.statusCode == 204) {
//         log("Note deleted successfully");
//         return true;
//       } else {
//         log("Failed to delete note: ${response.statusMessage}");
//         return false;
//       }
//     } catch (e) {
//       log("Error deleting note: $e");
//       return false;
//     }
//   }
// }
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:salesman/model/note_detail_model.dart';
import 'package:salesman/model/note_model.dart';

class NoteService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/notes/salesman/all";

  Future<List<GetNoteModel>> fetchNotes(String salesmanId) async {
    try {
      final response = await _dio.get("$baseUrl/$salesmanId");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is List) {
          return data.map((item) => GetNoteModel.fromJson(item)).toList();
        } else if (data is Map<String, dynamic>) {
          // Handle case where a single note is returned
          return [GetNoteModel.fromJson(data)];
        } else {
          log("Unexpected response format: $data");
          return [];
        }
      } else {
        log("API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      log("Error fetching notes: $e");
      return [];
    }
  }

  Future<SingleNoteModel?> fetchSingleNote(String noteId) async {
    try {
      final response = await _dio.get(
          'https://salesman-tracking-app.onrender.com/api/notes/getNote/$noteId');

      if (response.statusCode == 200) {
        return SingleNoteModel.fromJson(response.data);
      } else {
        log('Failed to load note: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      log('Dio error fetching single note: ${e.message}');
      log('Dio error fetching single note: ${e.response}');
      return null;
    } catch (e) {
      log('Error fetching single note: $e');
      return null;
    }
  }

  Future<bool> updateNote(String noteId, String title, String note) async {
    try {
      final response = await _dio.put(
        'https://salesman-tracking-app.onrender.com/api/notes/$noteId',
        data: {'title': title, 'note': note},
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      log('Dio error updating note: ${e.message}');
      log('Dio error updating note: ${e.response}');
      return false;
    } catch (e) {
      log('Error updating note: $e');
      return false;
    }
  }

  Future<bool> deleteNote(String noteId) async {
    try {
      final response = await _dio.delete(
          'https://salesman-tracking-app.onrender.com/api/notes/$noteId');
      return response.statusCode == 200;
    } on DioException catch (e) {
      log('Dio error deleting note: ${e.message}');
      log('Dio error deleting note: ${e.response}');
      return false;
    } catch (e) {
      log('Error deleting note: $e');
      return false;
    }
  }
}
