class NotificationModel {
  final String id;
  final String recipient;
  final String recipientType;
  final String message;
  final bool isRead;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.recipient,
    required this.recipientType,
    required this.message,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      recipient: json['recipient'],
      recipientType: json['recipientType'],
      message: json['message'],
      isRead: json['isRead'] ?? false, // Default to false if null
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // ✅ Add this copyWith method
  NotificationModel copyWith({
    String? id,
    String? recipient,
    String? recipientType,
    String? message,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      recipient: recipient ?? this.recipient,
      recipientType: recipientType ?? this.recipientType,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
