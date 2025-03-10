class UserMetricsModel {
  final UserModel user;
  final int ordersCount;
  final int meetingsCount;
  final int collectionsTotalAmount;

  UserMetricsModel({
    required this.user,
    required this.ordersCount,
    required this.meetingsCount,
    required this.collectionsTotalAmount,
  });

  factory UserMetricsModel.fromJson(Map<String, dynamic> json) {
    return UserMetricsModel(
      user: UserModel.fromJson(json['user'] ?? {}),
      ordersCount: json['ordersCount'] ?? 0,
      meetingsCount: json['meetingsCount'] ?? 0,
      collectionsTotalAmount: json['collectionsTotalAmount'] ?? 0,
    );
  }
}

class UserModel {
  final String name;
  final String email;
  final String mobileNumber;

  UserModel({
    required this.name,
    required this.email,
    required this.mobileNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      mobileNumber: (json['mobileNumber'] ?? "").toString(),
    );
  }
}
