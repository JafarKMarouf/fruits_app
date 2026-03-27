import 'package:fruits_app/core/cubits/product/product_cubit.dart';
import 'package:fruits_app/core/repositories/order_repo/order_repo.dart';
import 'package:fruits_app/core/repositories/order_repo/order_repo_impl.dart';
import 'package:fruits_app/core/services/firebase_auth_service.dart';
import 'package:fruits_app/core/services/store_services/database_service.dart';
import 'package:fruits_app/core/services/store_services/firestore_service.dart';
import 'package:fruits_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits_app/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_app/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_app/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:fruits_app/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:fruits_app/features/cart/data/repo/cart_repo_impl.dart';
import 'package:fruits_app/features/cart/domain/repo/cart_repo.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/checkout/presentation/manager/cubit/add_order_cubit/add_order_cubit.dart';
import 'package:get_it/get_it.dart';

import '../cubits/featured_products/featured_product_cubit.dart';
import '../repositories/product_repo/product_repo.dart';
import '../repositories/product_repo/product_repo_impl.dart';
import 'local_storage_services/hive_storage.dart';
import 'local_storage_services/local_storage_service.dart';

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
    () => AuthRepoImpl(getIt<FirebaseAuthService>(), getIt<DatabaseService>()),
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
}
