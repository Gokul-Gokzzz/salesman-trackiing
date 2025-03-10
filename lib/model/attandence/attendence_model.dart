import 'dart:convert';

AttendenceModel attendenceModelFromJson(String str) =>
    AttendenceModel.fromJson(json.decode(str));

String attendenceModelToJson(AttendenceModel data) =>
    json.encode(data.toJson());

class AttendenceModel {
  List<Record>? records;

  AttendenceModel({this.records});

  factory AttendenceModel.fromJson(Map<String, dynamic> json) =>
      AttendenceModel(
        records: json["records"] == null
            ? []
            : List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "records": records == null
            ? []
            : List<dynamic>.from(records!.map((x) => x.toJson())),
      };
}

class Record {
  String? id;
  String? salesmanId;
  String? salesmanName;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;

  Record({
    this.id,
    this.salesmanId,
    this.salesmanName,
    this.checkInTime,
    this.checkOutTime,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["_id"],
        salesmanId: json["salesman"]?["_id"],
        salesmanName: json["salesman"]?["name"],
        checkInTime: json["checkInTime"] == null
            ? null
            : DateTime.parse(json["checkInTime"]),
        checkOutTime: json["checkOutTime"] == null
            ? null
            : DateTime.parse(json["checkOutTime"]),
        location: json["location"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "salesman": {
          "_id": salesmanId,
          "name": salesmanName,
        },
        "checkInTime": checkInTime?.toIso8601String(),
        "checkOutTime": checkOutTime?.toIso8601String(),
        "location": location,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
