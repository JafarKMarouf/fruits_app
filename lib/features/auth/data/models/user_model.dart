import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uId,
    required super.name,
    required super.email,
    super.role,
    super.status,
    super.createdAt,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uId: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    return UserModel(
      uId: jsonData['uid'],
      name: jsonData['name'],
      email: jsonData['email'],
      role: jsonData['role'],
      status: jsonData['status'],
      createdAt: jsonData['created_at'] != null
          ? Timestamp.fromDate(DateTime.parse(jsonData['created_at']))
          : null,
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      uId: userEntity.uId,
      name: userEntity.name,
      email: userEntity.email,
      role: userEntity.role,
      status: userEntity.status,
      createdAt: userEntity.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uid': uId,
      'role': role ?? 'customer',
      'status': status ?? 'active',
      'created_at': createdAt?.toDate().toIso8601String(),
    };
  }
}
