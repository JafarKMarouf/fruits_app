import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final String? productId;
  final String type;
  final Timestamp createdAt;
  bool isRead;

  NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    this.productId,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });
}
