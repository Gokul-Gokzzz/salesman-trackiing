// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

MeetingModel meetingModelFromJson(String str) =>
    MeetingModel.fromJson(json.decode(str));

String meetingModelToJson(MeetingModel data) => json.encode(data.toJson());

class MeetingModel {
  List<Meeting>? meetings;

  MeetingModel({
    this.meetings,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        meetings: json["meetings"] == null
            ? []
            : List<Meeting>.from(
                json["meetings"]!.map((x) => Meeting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meetings": meetings == null
            ? []
            : List<dynamic>.from(meetings!.map((x) => x.toJson())),
      };
}

class Meeting {
  String? id;
  String? salesman;
  String? client;
  DateTime? date;
  String? location;
  String? agenda;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Meeting({
    this.id,
    this.salesman,
    this.client,
    this.date,
    this.location,
    this.agenda,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        id: json["_id"],
        salesman: json["salesman"],
        client: json["client"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        location: json["location"],
        agenda: json["agenda"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "salesman": salesman,
        "client": client,
        "date": date?.toIso8601String(),
        "location": location,
        "agenda": agenda,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
