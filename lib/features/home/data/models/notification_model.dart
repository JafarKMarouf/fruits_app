import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_app/features/home/domain/entities/notification_entity.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final String? productId;
  final String type;
  final Timestamp createdAt;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.imageUrl,
    this.productId,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      title: title,
      body: body,
      imageUrl: imageUrl,
      type: type,
      productId: productId,
      createdAt: createdAt,
      isRead: isRead,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json, String docId) {
    return NotificationModel(
      id: docId,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      imageUrl: json['image_url'],
      productId: json['product_id'],
      type: json['type'] ?? 'new_product',
      createdAt: json['created_at'] as Timestamp? ?? Timestamp.now(),
      isRead: json['is_read'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'image_url': imageUrl,
      'product_id': productId,
      'type': type,
      'created_at': createdAt,
      'is_read': isRead,
    };
  }
}
