import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationEntity {
  final String id;
  final String title;
  final String body;
  final String? imageUrl;
  final String? productId;
  final String type;
  final Timestamp createdAt;
  final bool isRead;

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

  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    String? imageUrl,
    String? productId,
    String? type,
    Timestamp? createdAt,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      productId: productId ?? this.productId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          isRead == other.isRead;

  @override
  int get hashCode => id.hashCode ^ isRead.hashCode;
}
