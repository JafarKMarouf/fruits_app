import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/custom_exceptions.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/services/database_service.dart';
import 'package:fruits_app/core/services/firebase_auth_service.dart';
import 'package:fruits_app/core/services/shared_preferences_service.dart';
import 'package:fruits_app/core/utils/backend_endpoints.dart';
import 'package:fruits_app/core/utils/constants.dart';
import 'package:fruits_app/features/auth/data/models/user_model.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/domain/requests/user_request.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(this.firebaseAuthService, this.databaseService);

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required UserRequest request,
  }) async {
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailAndPassword(
        request: request,
      );
      UserEntity userEntity = UserEntity(
        uId: user.uid,
        name: request.name!,
        email: request.email,
      );
      await addUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      await firebaseAuthService.deleteAuthUser();
      return Left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}',
      );
      if (user != null) {
        await firebaseAuthService.deleteAuthUser();
      }
      return Left(ServerFailure('genericError'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required UserRequest request,
  }) async {
    try {
      var user = await firebaseAuthService.signinWithEmailAndPassword(
        request: request,
      );
      UserEntity userEntity = await getUserData(uid: user.uid);
      await saveUserData(user: userEntity);

      return Right(userEntity);
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      log(
        'Exception in AuthRepoImpl.signinWithEmailAndPassword: ${e.toString()}',
      );
      return Left(ServerFailure('genericError'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      UserEntity userEntity = UserEntity(
        uId: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
      );
      bool isUserExists = await databaseService.isDataExists(
        path: BackendEndpoints.isUserExists,
        documentId: user.uid,
      );
      if (!isUserExists) {
        await addUserData(user: userEntity);
      } else {
        await getUserData(uid: user.uid);
      }
      await saveUserData(user: userEntity);
      return Right(userEntity);
    } on CustomException catch (e) {
      await firebaseAuthService.deleteAuthUser();
      return Left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      if (user != null) {
        await firebaseAuthService.deleteAuthUser();
      }
      return Left(ServerFailure('genericError'));
    }
  }

  @override
  Future<void> addUserData({required UserEntity user}) async {
    await databaseService.addData(
      path: BackendEndpoints.addUser,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uid}) async {
    var user = await databaseService.getData(
      path: BackendEndpoints.getUser,
      documentId: uid,
    );
    return UserModel.fromJson(user);
  }

  @override
  Future<void> saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await SharedPreferencesService.setString(kUserData, jsonData);
    await SharedPreferencesService.setBool(kIsUserLoggedIn, true);
  }

  @override
  Future<void> signOut() async {
    await SharedPreferencesService.remove(kUserData);
    await SharedPreferencesService.remove(kIsUserLoggedIn);
  }
}
