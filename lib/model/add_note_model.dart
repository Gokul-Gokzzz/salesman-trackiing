// To parse this JSON data, do
//
//     final addNoteModel = addNoteModelFromJson(jsonString);

import 'dart:convert';

AddNoteModel addNoteModelFromJson(String str) =>
    AddNoteModel.fromJson(json.decode(str));

String addNoteModelToJson(AddNoteModel data) => json.encode(data.toJson());

class AddNoteModel {
  String? salesman;
  String? title;
  String? note;
  String? id;

  AddNoteModel({
    this.salesman,
    this.title,
    this.note,
    this.id,
  });

  factory AddNoteModel.fromJson(Map<String, dynamic> json) => AddNoteModel(
        salesman: json["salesman"],
        title: json["title"],
        note: json["note"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "salesman": salesman,
        "title": title,
        "note": note,
        "_id": id,
      };
}
