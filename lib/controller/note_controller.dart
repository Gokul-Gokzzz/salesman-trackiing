import 'package:flutter/material.dart';
import 'package:salesman/model/note_model.dart';
import 'package:salesman/service/note_service.dart';

class NoteController extends ChangeNotifier {
  final NoteService _noteService = NoteService();
  List<GetNoteModel> _notes = [];
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
}
