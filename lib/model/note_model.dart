class GetNoteModel {
  final String id;
  final Salesman salesman;
  final String title;
  final String note;

  GetNoteModel({
    required this.id,
    required this.salesman,
    required this.title,
    required this.note,
  });

  factory GetNoteModel.fromJson(Map<String, dynamic> json) {
    return GetNoteModel(
      id: json['_id'] ?? '',
      salesman: Salesman.fromJson(json['salesman']),
      title: json['title'] ?? '',
      note: json['note'] ?? '',
    );
  }
}

class Salesman {
  final String id;
  final String name;
  final String email;
  final int mobileNumber;

  Salesman({
    required this.id,
    required this.name,
    required this.email,
    required this.mobileNumber,
  });

  factory Salesman.fromJson(Map<String, dynamic> json) {
    return Salesman(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      mobileNumber: json['mobileNumber'] ?? 0,
    );
  }
}
