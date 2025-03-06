class FieldStaff {
  final String id;
  final String name;
  final String location;
  final String email;
  final String contact;

  FieldStaff({
    required this.id,
    required this.name,
    required this.location,
    required this.email,
    required this.contact,
  });

  factory FieldStaff.fromJson(Map<String, dynamic> json) {
    return FieldStaff(
      id: json["_id"],
      name: json["name"],
      location: json["location"],
      email: json["email"],
      contact: json["contact"],
    );
  }
}
