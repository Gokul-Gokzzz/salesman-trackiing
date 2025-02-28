// To parse this JSON data, do
//
//     final getExpenseModel = getExpenseModelFromJson(jsonString);

import 'dart:convert';

GetExpenseModel getExpenseModelFromJson(String str) =>
    GetExpenseModel.fromJson(json.decode(str));

String getExpenseModelToJson(GetExpenseModel data) =>
    json.encode(data.toJson());

class GetExpenseModel {
  List<Expense>? expenses;

  GetExpenseModel({
    this.expenses,
  });

  factory GetExpenseModel.fromJson(Map<String, dynamic> json) =>
      GetExpenseModel(
        expenses: json["expenses"] == null
            ? []
            : List<Expense>.from(
                json["expenses"]!.map((x) => Expense.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "expenses": expenses == null
            ? []
            : List<dynamic>.from(expenses!.map((x) => x.toJson())),
      };
}

class Expense {
  String? id;
  String? salesman;
  String? expenseType;
  int? amount;
  String? notes;
  String? receiptUrl;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Expense({
    this.id,
    this.salesman,
    this.expenseType,
    this.amount,
    this.notes,
    this.receiptUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json["_id"],
        salesman: json["salesman"],
        expenseType: json["expenseType"],
        amount: json["amount"],
        notes: json["notes"],
        receiptUrl: json["receiptURL"],
        status: json["status"],
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
        "expenseType": expenseType,
        "amount": amount,
        "notes": notes,
        "receiptURL": receiptUrl,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
