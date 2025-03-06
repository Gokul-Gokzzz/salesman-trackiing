// To parse this JSON data, do
//
//     final meetingModel = meetingModelFromJson(jsonString);

import 'dart:convert';

MeetingModel meetingModelFromJson(String str) =>
    MeetingModel.fromJson(json.decode(str));

String meetingModelToJson(MeetingModel data) => json.encode(data.toJson());

class MeetingModel {
  List<GetMeeting>? meetings;

  MeetingModel({
    this.meetings,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
        meetings: json["meetings"] == null
            ? []
            : List<GetMeeting>.from(
                json["meetings"]!.map((x) => GetMeeting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meetings": meetings == null
            ? []
            : List<dynamic>.from(meetings!.map((x) => x.toJson())),
      };
}

class GetMeeting {
  String? id;
  String? title;
  Salesman? salesman;
  Client? client;
  DateTime? dateTime;
  String? locationType;
  String? locationDetails;
  String? fieldStaff;
  String? agenda;
  String? notes;
  String? attachment;
  String? repeatFrequency;
  DateTime? followUpReminder;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  GetMeeting({
    this.id,
    this.title,
    this.salesman,
    this.client,
    this.dateTime,
    this.locationType,
    this.locationDetails,
    this.fieldStaff,
    this.agenda,
    this.notes,
    this.attachment,
    this.repeatFrequency,
    this.followUpReminder,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetMeeting.fromJson(Map<String, dynamic> json) => GetMeeting(
        id: json["_id"],
        title: json["title"],
        salesman: json["salesman"] == null
            ? null
            : Salesman.fromJson(json["salesman"]),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        dateTime:
            json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
        locationType: json["locationType"],
        locationDetails: json["locationDetails"],
        fieldStaff: json["fieldStaff"],
        agenda: json["agenda"],
        notes: json["notes"],
        attachment: json["attachment"],
        repeatFrequency: json["repeatFrequency"],
        followUpReminder: json["followUpReminder"] == null
            ? null
            : DateTime.parse(json["followUpReminder"]),
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
        "title": title,
        "salesman": salesman?.toJson(),
        "client": client?.toJson(),
        "dateTime": dateTime?.toIso8601String(),
        "locationType": locationType,
        "locationDetails": locationDetails,
        "fieldStaff": fieldStaff,
        "agenda": agenda,
        "notes": notes,
        "attachment": attachment,
        "repeatFrequency": repeatFrequency,
        "followUpReminder": followUpReminder?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Client {
  String? id;
  String? name;
  String? companyName;
  String? email;
  String? contact;
  String? address;
  int? outstandingDue;
  int? ordersPlaced;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Client({
    this.id,
    this.name,
    this.companyName,
    this.email,
    this.contact,
    this.address,
    this.outstandingDue,
    this.ordersPlaced,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["_id"],
        name: json["name"],
        companyName: json["companyName"],
        email: json["email"],
        contact: json["contact"],
        address: json["address"],
        outstandingDue: json["outstandingDue"],
        ordersPlaced: json["ordersPlaced"],
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
        "name": name,
        "companyName": companyName,
        "email": email,
        "contact": contact,
        "address": address,
        "outstandingDue": outstandingDue,
        "ordersPlaced": ordersPlaced,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Salesman {
  String? id;
  String? name;
  String? email;
  int? mobileNumber;
  String? password;
  String? accountProvider;
  int? points;
  int? v;

  Salesman({
    this.id,
    this.name,
    this.email,
    this.mobileNumber,
    this.password,
    this.accountProvider,
    this.points,
    this.v,
  });

  factory Salesman.fromJson(Map<String, dynamic> json) => Salesman(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
        accountProvider: json["accountProvider"],
        points: json["points"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "mobileNumber": mobileNumber,
        "password": password,
        "accountProvider": accountProvider,
        "points": points,
        "__v": v,
      };
}
