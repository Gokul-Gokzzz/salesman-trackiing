// To parse this JSON data, do
//
//     final getNoteModel = getNoteModelFromJson(jsonString);

import 'dart:convert';

List<GetNoteModel> getNoteModelFromJson(String str) => List<GetNoteModel>.from(
    json.decode(str).map((x) => GetNoteModel.fromJson(x)));

String getNoteModelToJson(List<GetNoteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNoteModel {
  String? id;
  String? salesman;
  String? title;
  String? note;
  int? v;

  GetNoteModel({
    this.id,
    this.salesman,
    this.title,
    this.note,
    this.v,
  });

  factory GetNoteModel.fromJson(Map<String, dynamic> json) => GetNoteModel(
        id: json["_id"],
        salesman: json["salesman"],
        title: json["title"],
        note: json["note"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "salesman": salesman,
        "title": title,
        "note": note,
        "__v": v,
      };
}
