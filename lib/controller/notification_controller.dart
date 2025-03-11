import 'package:flutter/material.dart';
import 'package:salesman/model/notification_model.dart';
import 'package:salesman/service/notification_service.dart';

class NotificationController extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();
  List<NotificationModel> _notifications = [];
  bool isLoading = false;

  List<NotificationModel> get notifications => _notifications;

  Future<void> loadNotifications(String userId) async {
    isLoading = true;
    notifyListeners();

    _notifications = await _notificationService.fetchNotifications(userId);

    isLoading = false;
    notifyListeners();
  }

  Future<void> markAsRead(String notificationId) async {
    await _notificationService.markAsRead(notificationId);
    _notifications = notifications.map((n) {
      if (n.id == notificationId) {
        return n.copyWith(isRead: true);
      }
      return n;
    }).toList();
    notifyListeners();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _notificationService.deleteNotification(notificationId);
    notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }
}
