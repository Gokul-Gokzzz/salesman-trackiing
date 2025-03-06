// To parse this JSON data, do
//
//     final addExpenseModel = addExpenseModelFromJson(jsonString);

import 'dart:convert';

AddExpenseModel addExpenseModelFromJson(String str) =>
    AddExpenseModel.fromJson(json.decode(str));

String addExpenseModelToJson(AddExpenseModel data) =>
    json.encode(data.toJson());

class AddExpenseModel {
  String? message;
  Expense? expense;

  AddExpenseModel({
    this.message,
    this.expense,
  });

  factory AddExpenseModel.fromJson(Map<String, dynamic> json) =>
      AddExpenseModel(
        message: json["message"],
        expense:
            json["expense"] == null ? null : Expense.fromJson(json["expense"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "expense": expense?.toJson(),
      };
}

class Expense {
  String? salesman;
  String? expenseType;
  int? amount;
  String? notes;
  String? receiptUrl;
  String? status;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Expense({
    this.salesman,
    this.expenseType,
    this.amount,
    this.notes,
    this.receiptUrl,
    this.status,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        salesman: json["salesman"],
        expenseType: json["expenseType"],
        amount: json["amount"],
        notes: json["notes"],
        receiptUrl: json["receiptURL"],
        status: json["status"],
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
        "expenseType": expenseType,
        "amount": amount,
        "notes": notes,
        "receiptURL": receiptUrl,
        "status": status,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
