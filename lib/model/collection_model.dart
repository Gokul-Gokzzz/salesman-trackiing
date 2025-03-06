// To parse this JSON data, do
//
//     final collectionModel = collectionModelFromJson(jsonString);

import 'dart:convert';

CollectionModel collectionModelFromJson(String str) =>
    CollectionModel.fromJson(json.decode(str));

String collectionModelToJson(CollectionModel data) =>
    json.encode(data.toJson());

class CollectionModel {
  List<Collection>? collections;

  CollectionModel({
    this.collections,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        collections: json["collections"] == null
            ? []
            : List<Collection>.from(
                json["collections"]!.map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "collections": collections == null
            ? []
            : List<dynamic>.from(collections!.map((x) => x.toJson())),
      };
}

class Collection {
  String? id;
  Client? client;
  Salesman? salesman;
  int? amount;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Collection({
    this.id,
    this.client,
    this.salesman,
    this.amount,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        id: json["_id"],
        client: clientValues.map[json["client"]]!,
        salesman: salesmanValues.map[json["salesman"]]!,
        amount: json["amount"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
        "client": clientValues.reverse[client],
        "salesman": salesmanValues.reverse[salesman],
        "amount": amount,
        "date": date?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

enum Client {
  THE_67_AD71_E20_B04_E1597_A61_F0_EB,
  THE_67_AD71_E20_B04_E1597_A61_F0_FB
}

final clientValues = EnumValues({
  "67ad71e20b04e1597a61f0eb": Client.THE_67_AD71_E20_B04_E1597_A61_F0_EB,
  "67ad71e20b04e1597a61f0fb": Client.THE_67_AD71_E20_B04_E1597_A61_F0_FB
});

enum Salesman {
  THE_67_A9_BCD879021_F36_D7_FE0681,
  THE_67_AD6_CD557834965242_D6401
}

final salesmanValues = EnumValues({
  "67a9bcd879021f36d7fe0681": Salesman.THE_67_A9_BCD879021_F36_D7_FE0681,
  "67ad6cd557834965242d6401": Salesman.THE_67_AD6_CD557834965242_D6401
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
