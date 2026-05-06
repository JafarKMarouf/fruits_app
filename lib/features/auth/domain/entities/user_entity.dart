import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  final String uId;
  final String name;
  final String email;
  final String? role;
  final Timestamp? createdAt;
  final String? status;
  final String? fcmToken;
  const UserEntity({
    required this.uId,
    required this.name,
    required this.email,
    this.role,
    this.createdAt,
    this.status,
    this.fcmToken,
  });
}
