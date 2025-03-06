import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:salesman/model/add_note_model.dart';
import 'package:salesman/model/note_model.dart';
import 'package:salesman/service/note_service.dart';

class NoteController extends ChangeNotifier {
  final NoteService _noteService = NoteService();
  List<GetNoteModel> _notes = [];
  AddNoteModel addNoteModel = AddNoteModel();
  bool _isLoading = false;

  List<GetNoteModel> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> getNotes() async {
    _isLoading = true;
    notifyListeners();

    _notes = await _noteService.fetchNotes();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteNote(String noteId) async {
    _isLoading = true;
    notifyListeners();

    bool success = await _noteService.deleteNote(noteId);

    if (success) {
      debugPrint("Note deleted successfully");
      getNotes(); //refresh list
    } else {
      debugPrint("Failed to delete note");
    }

    _isLoading = false;
    notifyListeners();
  }
}
