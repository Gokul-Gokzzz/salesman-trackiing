// To parse this JSON data, do
//
//     final dashoardModel = dashoardModelFromJson(jsonString);

import 'dart:convert';

class DashoardModel {
  int? ordersCount;
  int? meetingsCount;
  int? collectionsTotalAmount;

  DashoardModel({
    this.ordersCount,
    this.meetingsCount,
    this.collectionsTotalAmount,
  });

  factory DashoardModel.fromJson(Map<String, dynamic> json) => DashoardModel(
        ordersCount: json["ordersCount"],
        meetingsCount: json["meetingsCount"],
        collectionsTotalAmount: json["collectionsTotalAmount"],
      );

  Map<String, dynamic> toJson() => {
        "ordersCount": ordersCount,
        "meetingsCount": meetingsCount,
        "collectionsTotalAmount": collectionsTotalAmount,
      };
}
