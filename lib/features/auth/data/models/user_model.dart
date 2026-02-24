import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.uId, required super.name, required super.email});

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
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      uId: userEntity.uId,
      name: userEntity.name,
      email: userEntity.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'uid': uId};
  }
}
