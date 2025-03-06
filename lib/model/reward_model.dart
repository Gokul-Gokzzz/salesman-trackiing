// To parse this JSON data, do
//
//     final getRewardModel = getRewardModelFromJson(jsonString);

import 'dart:convert';

GetRewardModel getRewardModelFromJson(String str) =>
    GetRewardModel.fromJson(json.decode(str));

String getRewardModelToJson(GetRewardModel data) => json.encode(data.toJson());

class GetRewardModel {
  List<Reward>? rewards;

  GetRewardModel({
    this.rewards,
  });

  factory GetRewardModel.fromJson(Map<String, dynamic> json) => GetRewardModel(
        rewards: json["rewards"] == null
            ? []
            : List<Reward>.from(
                json["rewards"]!.map((x) => Reward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "rewards": rewards == null
            ? []
            : List<dynamic>.from(rewards!.map((x) => x.toJson())),
      };
}

class Reward {
  String? id;
  String? rewardName;
  int? pointsRequired;
  int? quantityAvailable;
  String? rewardImageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? description;

  Reward({
    this.id,
    this.rewardName,
    this.pointsRequired,
    this.quantityAvailable,
    this.rewardImageUrl,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json["_id"],
        rewardName: json["rewardName"],
        pointsRequired: json["pointsRequired"],
        quantityAvailable: json["quantityAvailable"],
        rewardImageUrl: json["rewardImageURL"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "rewardName": rewardName,
        "pointsRequired": pointsRequired,
        "quantityAvailable": quantityAvailable,
        "rewardImageURL": rewardImageUrl,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "description": description,
      };
}
