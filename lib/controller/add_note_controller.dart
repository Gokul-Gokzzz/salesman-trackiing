import 'package:flutter/material.dart';
import 'package:salesman/model/add_note_model.dart';
import 'package:salesman/service/add_note_service.dart';

class AddNoteController with ChangeNotifier {
  final AddNoteService _addNoteService = AddNoteService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> addNote(String salesman, String title, String note) async {
    _isLoading = true;
    notifyListeners();

    AddNoteModel noteModel = AddNoteModel(
      salesman: salesman,
      title: title,
      note: note,
    );

    bool success = await _addNoteService.addNote(noteModel);

    _isLoading = false;
    notifyListeners();

    return success;
  }
}
