import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_app/core/errors/custom_exceptions.dart';
import 'package:fruits_app/features/auth/domain/requests/user_request.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword({
    required UserRequest request,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: request.email,
            password: request.password,
          );

      await credential.user?.updateDisplayName(request.name);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'FirebaseAuthException in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}, and code: ${e.code}',
      );
      switch (e.code) {
        case 'weak-password':
          throw CustomException(message: 'weakPassword');
        case 'invalid-email':
          throw CustomException(message: 'invalidEmail');
        case 'network-request-failed':
          throw CustomException(message: 'networkRequestFailed');
        case 'email-already-in-use':
          throw CustomException(message: 'emailAlreadyInUse');
        default:
          throw CustomException(message: 'genericError');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService createUserWithEmailAndPassword: ${e.toString()}',
      );

      throw CustomException(message: 'genericError');
    }
  }

  Future<User> signinWithEmailAndPassword({
    required UserRequest request,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log(
        'FirebaseAuthException in FirebaseAuthService.signinWithEmailAndPassword: ${e.toString()}, and code: ${e.code}',
      );
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(message: 'invalidEmail');
        case 'invalid-credential':
          throw CustomException(message: 'invalidCredential');
        case 'network-request-failed':
          throw CustomException(message: 'networkRequestFailed');
        default:
          throw CustomException(message: 'genericError');
      }
    } catch (e) {
      log(
        'Exception in FirebaseAuthService.signinWithEmailAndPassword: ${e.toString()}',
      );

      throw CustomException(message: 'genericError');
    }
  }
}
