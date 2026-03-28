import 'package:dartz/dartz.dart';

import '../../../features/checkout/domain/entities/order_input_entity/order_input_entity.dart';
import '../../errors/failure.dart';

abstract class OrderRepo {
  Future<Either<Failure, String>> addOrder({
    required OrderInputEntity orderEntity,
  });
}
