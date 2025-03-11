import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:salesman/controller/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  final String userId;

  const NotificationScreen({super.key, required this.userId});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationController>(context, listen: false)
          .loadNotifications(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Consumer<NotificationController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notifications.isEmpty) {
            return const Center(
              child: Text(
                "No notifications available.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final notification = controller.notifications[index];

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor:
                        notification.isRead ? Colors.grey : Colors.deepPurple,
                    child: Icon(
                      notification.isRead
                          ? Icons.notifications_none
                          : Icons.notifications_active,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color:
                          notification.isRead ? Colors.black54 : Colors.black87,
                    ),
                  ),
                  subtitle: Text(
                    timeago.format(notification.createdAt),
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  tileColor:
                      notification.isRead ? Colors.grey[200] : Colors.white,
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'read') {
                        if (!notification.isRead) {
                          controller.markAsRead(notification.id);
                        }
                      } else if (value == 'delete') {
                        controller.deleteNotification(notification.id);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'read',
                        child: Text(
                          notification.isRead ? "Already Read" : "Mark as Read",
                          style: TextStyle(
                              color: notification.isRead
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                        enabled: !notification.isRead,
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child:
                            Text("Delete", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
