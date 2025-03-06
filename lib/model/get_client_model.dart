// To parse this JSON data, do
//
//     final getClientModel = getClientModelFromJson(jsonString);

import 'dart:convert';

GetClientModel getClientModelFromJson(String str) =>
    GetClientModel.fromJson(json.decode(str));

String getClientModelToJson(GetClientModel data) => json.encode(data.toJson());

class GetClientModel {
  List<Client>? clients;

  GetClientModel({
    this.clients,
  });

  factory GetClientModel.fromJson(Map<String, dynamic> json) => GetClientModel(
        clients: json["clients"] == null
            ? []
            : List<Client>.from(
                json["clients"]!.map((x) => Client.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "clients": clients == null
            ? []
            : List<dynamic>.from(clients!.map((x) => x.toJson())),
      };
}

class Client {
  String? id;
  String? name;
  String? contact;
  String? address;
  int? outstandingDue;
  int? ordersPlaced;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? companyName;
  String? email;

  Client({
    this.id,
    this.name,
    this.contact,
    this.address,
    this.outstandingDue,
    this.ordersPlaced,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.companyName,
    this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["_id"],
        name: json["name"],
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
        companyName: json["companyName"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "contact": contact,
        "address": address,
        "outstandingDue": outstandingDue,
        "ordersPlaced": ordersPlaced,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "companyName": companyName,
        "email": email,
      };
}
