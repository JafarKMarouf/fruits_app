import 'dart:convert';

import 'package:fruits_app/core/services/local_storage/shared_preferences_service.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/features/auth/data/models/user_model.dart';
import 'package:fruits_app/features/auth/domain/entities/user_entity.dart';

UserEntity getUser() {
  var jsonData = SharedPreferencesService.getString(kUserData);
  return UserModel.fromJson(jsonDecode(jsonData!));
}
