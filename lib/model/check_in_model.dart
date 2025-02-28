// To parse this JSON data, do
//
//     final checkInRequestModel = checkInRequestModelFromJson(jsonString);

import 'dart:convert';

CheckInRequestModel checkInRequestModelFromJson(String str) =>
    CheckInRequestModel.fromJson(json.decode(str));

String checkInRequestModelToJson(CheckInRequestModel data) =>
    json.encode(data.toJson());

class CheckInRequestModel {
  String? message;
  Attendance? attendance;

  CheckInRequestModel({
    this.message,
    this.attendance,
  });

  factory CheckInRequestModel.fromJson(Map<String, dynamic> json) =>
      CheckInRequestModel(
        message: json["message"],
        attendance: json["attendance"] == null
            ? null
            : Attendance.fromJson(json["attendance"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "attendance": attendance?.toJson(),
      };
}

class Attendance {
  String? salesman;
  DateTime? checkInTime;
  String? location;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attendance({
    this.salesman,
    this.checkInTime,
    this.location,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        salesman: json["salesman"],
        checkInTime: json["checkInTime"] == null
            ? null
            : DateTime.parse(json["checkInTime"]),
        location: json["location"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "salesman": salesman,
        "checkInTime": checkInTime?.toIso8601String(),
        "location": location,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
