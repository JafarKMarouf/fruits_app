import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fruits_app/core/services/bloc_observer.dart';
import 'package:fruits_app/core/services/get_it_service.dart';
import 'package:fruits_app/core/services/shared_preferences_service.dart';
import 'package:fruits_app/features/fruits_app.dart';
import 'package:fruits_app/firebase_options.dart';

import 'core/services/local_storage_services/local_storage_service.dart';

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
  runApp(const FruitsApp());
}
