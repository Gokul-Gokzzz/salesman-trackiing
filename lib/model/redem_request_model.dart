class RedemptionRequestModel {
  final String userId;
  final String rewardId;
  final String status;
  final int pointsUsed;
  final String id;
  final String createdAt;
  final String updatedAt;

  RedemptionRequestModel({
    required this.userId,
    required this.rewardId,
    required this.status,
    required this.pointsUsed,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RedemptionRequestModel.fromJson(Map<String, dynamic> json) {
    return RedemptionRequestModel(
      userId: json["userId"],
      rewardId: json["rewardId"],
      status: json["status"],
      pointsUsed: json["pointsUsed"],
      id: json["_id"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }
}
