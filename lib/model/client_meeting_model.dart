// To parse this JSON data, do
//
//     final clintMeetingModel = clintMeetingModelFromJson(jsonString);

import 'dart:convert';

ClintMeetingModel clintMeetingModelFromJson(String str) =>
    ClintMeetingModel.fromJson(json.decode(str));

String clintMeetingModelToJson(ClintMeetingModel data) =>
    json.encode(data.toJson());

class ClintMeetingModel {
  String? message;
  Meeting? meeting;

  ClintMeetingModel({
    this.message,
    this.meeting,
  });

  factory ClintMeetingModel.fromJson(Map<String, dynamic> json) =>
      ClintMeetingModel(
        message: json["message"],
        meeting:
            json["meeting"] == null ? null : Meeting.fromJson(json["meeting"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "meeting": meeting?.toJson(),
      };
}

class Meeting {
  String? salesman;
  String? client;
  DateTime? date;
  String? location;
  String? agenda;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Meeting({
    this.salesman,
    this.client,
    this.date,
    this.location,
    this.agenda,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        salesman: json["salesman"],
        client: json["client"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        location: json["location"],
        agenda: json["agenda"],
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
        "client": client,
        "date": date?.toIso8601String(),
        "location": location,
        "agenda": agenda,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
