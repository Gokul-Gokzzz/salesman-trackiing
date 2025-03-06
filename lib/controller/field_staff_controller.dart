import 'package:flutter/material.dart';
import 'package:salesman/model/field_staff_model.dart';
import 'package:salesman/service/field_staff_service.dart';

class FieldStaffController extends ChangeNotifier {
  final FieldStaffService _service = FieldStaffService();
  List<FieldStaff> _staffList = [];
  bool _isLoading = false;

  List<FieldStaff> get staffList => _staffList;
  bool get isLoading => _isLoading;

  Future<void> getFieldStaff() async {
    _isLoading = true;
    notifyListeners();

    _staffList = await _service.fetchFieldStaff();

    _isLoading = false;
    notifyListeners();
  }
}
