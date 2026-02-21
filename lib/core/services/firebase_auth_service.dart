import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fruits_app/core/errors/custom_exceptions.dart';
import 'package:fruits_app/features/auth/domain/requests/user_request.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId: dotenv.env['GOOGLE_WEB_CLIENT_ID']!,
      );

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return userCredential.user!;
    } on GoogleSignInException catch (e) {
      log(
        'GoogleSignInException in FirebaseAuthService.signInWithGoogle: ${e.toString()}',
      );
      throw CustomException(message: 'genericError');
    } catch (e) {
      log('Exception in FirebaseAuthService.signInWithGoogle: ${e.toString()}');
      throw CustomException(message: 'genericError');
    }
  }
}
