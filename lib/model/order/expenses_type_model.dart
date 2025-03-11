// To parse this JSON data, do
//
//     final expenseTypeModel = expenseTypeModelFromJson(jsonString);

import 'dart:convert';

ExpenseTypeModel expenseTypeModelFromJson(String str) =>
    ExpenseTypeModel.fromJson(json.decode(str));

String expenseTypeModelToJson(ExpenseTypeModel data) =>
    json.encode(data.toJson());

class ExpenseTypeModel {
  List<ExpenseType>? expenseTypes;

  ExpenseTypeModel({
    this.expenseTypes,
  });

  factory ExpenseTypeModel.fromJson(Map<dynamic, dynamic> json) =>
      ExpenseTypeModel(
        expenseTypes: json["expenseTypes"] == null
            ? []
            : List<ExpenseType>.from(
                json["expenseTypes"]!.map((x) => ExpenseType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expenseTypes": expenseTypes == null
            ? []
            : List<dynamic>.from(expenseTypes!.map((x) => x.toJson())),
      };
}

class ExpenseType {
  String? id;
  String? name;
  int? v;

  ExpenseType({
    this.id,
    this.name,
    this.v,
  });

  factory ExpenseType.fromJson(Map<dynamic, dynamic> json) => ExpenseType(
        id: json["_id"],
        name: json["name"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "__v": v,
      };
}
