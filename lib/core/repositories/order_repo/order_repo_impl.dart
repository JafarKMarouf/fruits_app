import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/repositories/order_repo/order_repo.dart';
import 'package:fruits_app/core/services/store_services/database_service.dart';
import 'package:fruits_app/core/utils/constants/backend_endpoints.dart';
import 'package:fruits_app/features/checkout/data/models/order_model/order_input_model.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';

class OrderRepoImpl implements OrderRepo {
  final DatabaseService databaseService;
  const OrderRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, String>> addOrder({
    required OrderInputEntity orderEntity,
  }) async {
    try {
      final docId = await databaseService.addData(
        path: BackendEndpoints.addOrder,
        data: OrderInputModel.fromEntity(orderEntity).toJson(),
      );
      return Right(docId);
    } catch (e) {
      log('Exception in OrderRepoImpl.addOrder: ${e.toString()}');
      return Left(ServerFailure('Failed in add Order Repo'));
    }
  }
}
