// To parse this JSON data, do
//
//     final addClintModel = addClintModelFromJson(jsonString);

import 'dart:convert';

AddClintModel addClintModelFromJson(String str) =>
    AddClintModel.fromJson(json.decode(str));

String addClintModelToJson(AddClintModel data) => json.encode(data.toJson());

class AddClintModel {
  String? message;
  Client? client;

  AddClintModel({
    this.message,
    this.client,
  });

  factory AddClintModel.fromJson(Map<String, dynamic> json) => AddClintModel(
        message: json["message"],
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "client": client?.toJson(),
      };
}

class Client {
  String? salemanId;
  String? name;
  String? companyName;
  String? email;
  String? contact;
  String? address;
  int? outstandingDue;
  int? ordersPlaced;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Client({
    this.name,
    this.salemanId,
    this.companyName,
    this.email,
    this.contact,
    this.address,
    this.outstandingDue,
    this.ordersPlaced,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        name: json["name"],
        salemanId: json["salesmanId"],
        companyName: json["companyName"],
        email: json["email"],
        contact: json["contact"],
        address: json["address"],
        outstandingDue: json["outstandingDue"],
        ordersPlaced: json["ordersPlaced"],
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
        "name": name,
        "salesmanId": salemanId,
        "companyName": companyName,
        "email": email,
        "contact": contact,
        "address": address,
        "outstandingDue": outstandingDue,
        "ordersPlaced": ordersPlaced,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
