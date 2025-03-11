import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:salesman/model/notification_model.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String baseUrl =
      "https://salesman-tracking-app.onrender.com/api/notification/user";

  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      final response =
          await _dio.get('$baseUrl/$userId?recipientType=user-stas');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['notifications'];
        return data.map((json) => NotificationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      log('Error fetching notifications: $e');
      return [];
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _dio.put(
          "https://salesman-tracking-app.onrender.com/api/notification/read/$notificationId");
    } catch (e) {
      log("Error marking as read: $e");
    }
  }

  // Delete Notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _dio.delete(
          "https://salesman-tracking-app.onrender.com/api/notification/$notificationId");
    } catch (e) {
      log("Error deleting notification: $e");
    }
  }
}
