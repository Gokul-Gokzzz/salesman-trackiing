import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:salesman/model/note_detail_model.dart';
import 'package:salesman/model/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salesman/service/note_service.dart';

class NoteController extends ChangeNotifier {
  final NoteService _noteService = NoteService();
  SingleNoteModel? singleNote;
  List<GetNoteModel> notes = [];
  bool isLoading = false;

  Future<void> fetchNotesForSalesman() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String? salesmanId = prefs.getString('id');

      if (salesmanId == null || salesmanId.isEmpty) {
        log("❌ Salesman ID is null or empty!");
        return;
      }

      log("✅ Fetching notes for Salesman ID: $salesmanId");
      notes = await _noteService.fetchNotes(salesmanId);
    } catch (e) {
      log("Error fetching notes: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSingleNote(String noteId) async {
    isLoading = true;
    notifyListeners();

    try {
      singleNote = await _noteService.fetchSingleNote(noteId);
    } catch (e) {
      log('Error fetching single note in controller: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateNote(String noteId, String title, String note) async {
    isLoading = true;
    notifyListeners();
    bool success = await _noteService.updateNote(noteId, title, note);
    isLoading = false;
    notifyListeners();
    return success;
  }

  Future<bool> deleteNote(String noteId) async {
    isLoading = true;
    notifyListeners();
    bool success = await _noteService.deleteNote(noteId);
    isLoading = false;
    notifyListeners();
    return success;
  }
}
