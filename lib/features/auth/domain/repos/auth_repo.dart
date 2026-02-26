import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_app/features/auth/domain/requests/user_request.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required UserRequest request,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required UserRequest request,
  });

  Future<Either<Failure, UserEntity>> signInWithGoogle();

  Future<void> addUserData({required UserEntity user});

  Future<void> saveUserData({required UserEntity user});

  Future<UserEntity> getUserData({required String uid});

  Future<void> signOut();
}
