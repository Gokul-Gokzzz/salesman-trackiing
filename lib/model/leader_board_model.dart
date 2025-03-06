// To parse this JSON data, do
//
//     final leaderBoardModel = leaderBoardModelFromJson(jsonString);

import 'dart:convert';

LeaderBoardModel leaderBoardModelFromJson(String str) =>
    LeaderBoardModel.fromJson(json.decode(str));

String leaderBoardModelToJson(LeaderBoardModel data) =>
    json.encode(data.toJson());

class LeaderBoardModel {
  int? currentPage;
  int? totalPages;
  int? totalUsers;
  List<Leaderboard>? leaderboard;

  LeaderBoardModel({
    this.currentPage,
    this.totalPages,
    this.totalUsers,
    this.leaderboard,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) =>
      LeaderBoardModel(
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
        totalUsers: json["totalUsers"],
        leaderboard: json["leaderboard"] == null
            ? []
            : List<Leaderboard>.from(
                json["leaderboard"]!.map((x) => Leaderboard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalUsers": totalUsers,
        "leaderboard": leaderboard == null
            ? []
            : List<dynamic>.from(leaderboard!.map((x) => x.toJson())),
      };
}

class Leaderboard {
  String? id;
  String? name;
  int? points;

  Leaderboard({
    this.id,
    this.name,
    this.points,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        id: json["_id"],
        name: json["name"],
        points: json["points"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "points": points,
      };
}
