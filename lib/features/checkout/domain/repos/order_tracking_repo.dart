import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/order_tracking_entity/order_tracking_entity.dart';

abstract class OrderTrackingRepo {
  Stream<Either<Failure, OrderTrackingEntity>> watchOrder(String orderId);
}
