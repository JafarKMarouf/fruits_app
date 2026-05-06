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

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(message) async =>
    firebaseMessagingBackgroundHandler(message);

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

  // Init local notifications
  await getIt<LocalNotificationService>().init();

  // Init push notifications (request permissions, subscribe to topic)
  await getIt<PushNotificationService>().init();

  // Listen for token refresh → update Firestore
  getIt<PushNotificationService>().onTokenRefresh.listen((newToken) async {
    final user = getUser();
    await getIt<AuthRepo>().updateFcmToken(uid: user.uId, token: newToken);
  });

  runApp(const FruitsApp());
}
