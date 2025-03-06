// To parse this JSON data, do
//
//     final addCollectionModel = addCollectionModelFromJson(jsonString);

import 'dart:convert';

AddCollectionModel addCollectionModelFromJson(String str) =>
    AddCollectionModel.fromJson(json.decode(str));

String addCollectionModelToJson(AddCollectionModel data) =>
    json.encode(data.toJson());

class AddCollectionModel {
  String? message;
  Collection? collection;

  AddCollectionModel({
    this.message,
    this.collection,
  });

  factory AddCollectionModel.fromJson(Map<String, dynamic> json) =>
      AddCollectionModel(
        message: json["message"],
        collection: json["collection"] == null
            ? null
            : Collection.fromJson(json["collection"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "collection": collection?.toJson(),
      };
}

class Collection {
  String? client;
  String? salesman;
  int? amount;
  DateTime? date;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Collection({
    this.client,
    this.salesman,
    this.amount,
    this.date,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        client: json["client"],
        salesman: json["salesman"],
        amount: json["amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        "client": client,
        "salesman": salesman,
        "amount": amount,
        "date": date?.toIso8601String(),
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
