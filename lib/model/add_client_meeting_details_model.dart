import 'dart:convert';

AddClientMeetingDetailsModel AddClientMeetingDetailsModelFromJson(String str) =>
    AddClientMeetingDetailsModel.fromJson(json.decode(str));

String AddClientMeetingDetailsModelToJson(AddClientMeetingDetailsModel data) =>
    json.encode(data.toJson());

class AddClientMeetingDetailsModel {
  String? message;
  AddMeeting? meeting;

  AddClientMeetingDetailsModel({this.message, this.meeting});

  factory AddClientMeetingDetailsModel.fromJson(Map<String, dynamic> json) =>
      AddClientMeetingDetailsModel(
        message: json["message"],
        meeting: json["meeting"] == null
            ? null
            : AddMeeting.fromJson(json["meeting"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "meeting": meeting?.toJson(),
      };
}

class AddMeeting {
  String? title;
  String? salesman;
  String? client;
  DateTime? dateTime;
  String? locationType;
  String? locationDetails;
  String? fieldStaff;
  String? agenda;
  String? notes;
  // String? attachment;
  String? repeatFrequency;
  DateTime? followUpReminder;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AddMeeting({
    this.title,
    this.salesman,
    this.client,
    this.dateTime,
    this.locationType,
    this.locationDetails,
    this.fieldStaff,
    this.agenda,
    this.notes,
    // this.attachment,
    this.repeatFrequency,
    this.followUpReminder,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AddMeeting.fromJson(Map<String, dynamic> json) => AddMeeting(
        title: json["title"],
        salesman: json["salesman"],
        client: json["client"],
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        locationType: json["locationType"],
        locationDetails: json["locationDetails"],
        fieldStaff: json["fieldStaff"],
        notes: json["notes"],
        // attachment: json["attachment"],
        repeatFrequency: json["repeatFrequency"],
        followUpReminder: json["followUpReminder"] == null
            ? null
            : DateTime.parse(json["followUpReminder"]),
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
        "title": title,
        "salesman": salesman,
        "client": client,
        "dateTime": dateTime?.toIso8601String(),
        "locationType": locationType,
        "locationDetails": locationDetails,
        "fieldStaff": fieldStaff,
        "agenda": agenda,
        "notes": notes,
        // "attachment": attachment,
        "repeatFrequency": repeatFrequency,
        "followUpReminder": followUpReminder?.toIso8601String(),
        // "_id": id,
        // "createdAt": createdAt?.toIso8601String(),
        // "updatedAt": updatedAt?.toIso8601String(),
        // "__v": v,
      };
}
