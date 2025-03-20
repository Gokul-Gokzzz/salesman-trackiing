class Attendance {
  final String? id;
  final String? salesmanId;
  final String? checkInTime;
  final String? checkOutTime;
  final String location;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  Attendance({
    required this.image,
    this.id,
    this.salesmanId,
    this.checkOutTime,
    this.checkInTime,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      image: json['image'],
      id: json['_id'] ?? '',
      checkOutTime: json['checkOutTime'] ?? '',
      salesmanId: json['salesman'] ?? '',
      checkInTime: json['checkInTime'] ?? "",
      location: json['location'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
