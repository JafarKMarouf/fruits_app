import 'package:fruits_app/core/cubits/product/product_cubit.dart';
import 'package:fruits_app/core/repositories/order_repo/order_repo.dart';
import 'package:fruits_app/core/repositories/order_repo/order_repo_impl.dart';
import 'package:fruits_app/core/services/auth/firebase_auth_service.dart';
import 'package:fruits_app/core/services/database/database_service.dart';
import 'package:fruits_app/core/services/database/firestore_service.dart';
import 'package:fruits_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:fruits_app/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:fruits_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:fruits_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/checkout/domain/repos/order_tracking_repo.dart';
import 'package:fruits_app/features/checkout/presentation/manager/cubit/add_order_cubit/add_order_cubit.dart';
import 'package:fruits_app/features/home/presentation/manage/notification/notification_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../features/checkout/data/repo/order_tracking_repo_impl.dart';
import '../../features/checkout/presentation/manager/cubit/order_tracking_cubit/order_tracking_cubit.dart';
import '../../features/home/data/repos/notification_repo_impl.dart';
import '../../features/home/domain/repo/notification_repo.dart';
import '../cubits/featured_products/featured_product_cubit.dart';
import '../repositories/product_repo/product_repo.dart';
import '../repositories/product_repo/product_repo_impl.dart';
import 'local_storage/hive_storage.dart';
import 'local_storage/local_storage_service.dart';
import 'notification/local_notification/local_notification_service.dart';
import 'notification/local_notification/local_notification_service_impl.dart';
import 'notification/push_notifications/push_notification_service.dart';
import 'notification/push_notifications/push_notification_service_impl.dart';

final getIt = GetIt.instance;

/// Initializes and registers all app dependencies.
Future<void> setupServiceLocator() async {
  _registerDataSource();
  _registerServices();
  _registerRepositories();
  _registerCubits();
}

void _registerServices() {
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<DatabaseService>(() => FirestoreService());
  getIt.registerLazySingleton<LocalStorageService>(() => HiveStorage());

  // ── Notification Services ──────────────────
  getIt.registerLazySingleton<LocalNotificationService>(
    () => LocalNotificationServiceImpl(),
  );
  getIt.registerLazySingleton<PushNotificationService>(
    () => PushNotificationServiceImpl(getIt<LocalNotificationService>()),
  );
}

void _registerDataSource() {
  getIt.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSourceImpl(getIt<DatabaseService>()),
  );
  getIt.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(getIt<LocalStorageService>()),
  );
}

void _registerRepositories() {
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      getIt<FirebaseAuthService>(),
      getIt<DatabaseService>(),
      getIt<PushNotificationService>(),
    ),
  );
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<CartRepo>(
    () => CartRepoImpl(
      localDataSource: getIt<CartLocalDataSource>(),
      remoteDataSource: getIt<CartRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<OrderRepo>(
    () => OrderRepoImpl(getIt<DatabaseService>()),
  );

  getIt.registerLazySingleton<OrderTrackingRepo>(() => OrderTrackingRepoImpl());

  getIt.registerLazySingleton<NotificationRepo>(
    () => NotificationRepoImpl(getIt<DatabaseService>()),
  );
}

void _registerCubits() {
  /// Auth Cubit
  getIt.registerFactory<SigninCubit>(() => SigninCubit(getIt<AuthRepo>()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt<AuthRepo>()));

  /// Product Cubit
  getIt.registerFactory<ProductCubit>(() => ProductCubit(getIt<ProductRepo>()));
  getIt.registerFactory<FeaturedProductCubit>(
    () => FeaturedProductCubit(getIt<ProductRepo>()),
  );

  /// cart Cubit
  getIt.registerFactory<CartCubit>(() => CartCubit(getIt<CartRepo>()));

  /// order cubit
  getIt.registerFactory<AddOrderCubit>(() => AddOrderCubit(getIt<OrderRepo>()));
  getIt.registerFactory<OrderTrackingCubit>(
    () => OrderTrackingCubit(getIt<OrderTrackingRepo>()),
  );

  /// notification cubit
  getIt.registerFactory<NotificationCubit>(
    () => NotificationCubit(getIt<NotificationRepo>()),
  );
}
