class RewardHistoryModel {
  List<RewardHistory> rewardHistory;

  RewardHistoryModel({required this.rewardHistory});

  factory RewardHistoryModel.fromJson(Map<String, dynamic> json) {
    return RewardHistoryModel(
      rewardHistory: (json['rewardHistory'] as List)
          .map((item) => RewardHistory.fromJson(item))
          .toList(),
    );
  }
}

class RewardHistory {
  String id;
  User user;
  Reward reward;
  String status;
  int pointsUsed;

  RewardHistory({
    required this.id,
    required this.user,
    required this.reward,
    required this.status,
    required this.pointsUsed,
  });

  factory RewardHistory.fromJson(Map<String, dynamic> json) {
    return RewardHistory(
      id: json['_id'],
      user: User.fromJson(json['userId']),
      reward: Reward.fromJson(json['rewardId']),
      status: json['status'],
      pointsUsed: json['pointsUsed'],
    );
  }
}

class User {
  String id;
  String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class Reward {
  String id;
  String rewardName;
  int pointsRequired;
  String rewardImageURL;

  Reward({
    required this.id,
    required this.rewardName,
    required this.pointsRequired,
    required this.rewardImageURL,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['_id'],
      rewardName: json['rewardName'],
      pointsRequired: json['pointsRequired'],
      rewardImageURL: json['rewardImageURL'],
    );
  }
}
