import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fruits_app/core/services/bloc_observer.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/core/services/local_storage/shared_preferences_service.dart';
import 'package:fruits_app/core/services/notification/local_notification/local_notification_service.dart';
import 'package:fruits_app/features/fruits_app.dart';
import 'package:fruits_app/firebase_options.dart';

import 'core/helper/get_user.dart';
import 'core/services/local_storage/local_storage_service.dart';
import 'core/services/notification/push_notifications/push_notification_service.dart';
import 'features/auth/domain/repos/auth_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Future.wait([
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    dotenv.load(fileName: '.env'),
    SharedPreferencesService.init(),
  ]);

  await setupServiceLocator();

  final storage = getIt<LocalStorageService>();
  await storage.init();

  await getIt<LocalNotificationService>().init();

  await getIt<PushNotificationService>().init();

  getIt<PushNotificationService>().onTokenRefresh.listen((newToken) async {
    try {
      final user = getUser();
      await getIt<AuthRepo>().updateFcmToken(uid: user.uId, token: newToken);
    } catch (_) {
      log('Not logged in yet — new token will be persisted on next sign-in');
    }
  });

  runApp(const FruitsApp());
}
