import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/utils/constants/backend_endpoints.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/order_tracking_entity/order_tracking_entity.dart';
import '../../domain/repos/order_tracking_repo.dart';
import '../models/order_tracking_model/order_tracking_model.dart';

class OrderTrackingRepoImpl implements OrderTrackingRepo {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<Either<Failure, OrderTrackingEntity>> watchOrder(String orderId) {
    return firestore
        .collection(BackendEndpoints.getOrder)
        .doc(orderId)
        .snapshots()
        .map((doc) {
          if (!doc.exists || doc.data() == null) {
            return Left<Failure, OrderTrackingEntity>(
              ServerFailure('الطلب غير موجود'),
            );
          }
          final entity = OrderTrackingModel.fromDoc(doc.id, doc.data()!);
          return Right<Failure, OrderTrackingEntity>(entity);
        })
        .handleError((e) {
          log('OrderTrackingRepoImpl error: $e');
          return Left<Failure, OrderTrackingEntity>(
            ServerFailure('تعذّر تحميل بيانات الطلب'),
          );
        });
  }
}
