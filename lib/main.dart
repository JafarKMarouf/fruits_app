import 'package:flutter/material.dart';
import 'package:fruits_app/core/services/shared_preferences_service.dart';
import 'package:fruits_app/features/fruits_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(const FruitsApp());
}
