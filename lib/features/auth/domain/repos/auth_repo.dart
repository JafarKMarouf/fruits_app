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
}
