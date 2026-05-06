import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fruits_app/core/errors/failure.dart';
import 'package:fruits_app/core/services/database/database_service.dart';
import 'package:fruits_app/features/home/domain/entities/notification_entity.dart';
import 'package:fruits_app/features/home/domain/repo/notification_repo.dart';

import '../../../../core/utils/constants/backend_endpoints.dart';
import '../models/notification_model.dart';

class NotificationRepoImpl implements NotificationRepo {
  final DatabaseService databaseService;

  NotificationRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    try {
      final data =
          await databaseService.getData(
                path: BackendEndpoints.notifications,
                query: {'orderBy': 'createdAt', 'descending': true},
              )
              as List<Map<String, dynamic>>;
      List<NotificationEntity> notifications = data
          .map(
            (notification) => NotificationModel.fromJson(
              notification,
              notification['id'] as String,
            ).toEntity(),
          )
          .toList();
      return Right(notifications);
    } catch (e) {
      log('Exception in NotificationRepoImpl.getNotifications: $e');
      return Left(ServerFailure('Failed to load notifications'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead({
    required String notificationId,
  }) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoints.notifications,
        documentId: notificationId,
        data: {'isRead': true},
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update notification'));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      final result = await getNotifications();
      await result.fold((_) async {}, (notifications) async {
        final unread = notifications.where((n) => !n.isRead).toList();
        for (final n in unread) {
          await databaseService.updateData(
            path: BackendEndpoints.notifications,
            documentId: n.id,
            data: {'isRead': true},
          );
        }
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to mark all as read'));
    }
  }
}
