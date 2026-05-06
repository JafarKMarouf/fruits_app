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
      final rawList = await databaseService.getDataCollection(
        path: BackendEndpoints.notifications,
      );
      final notifications =
          rawList
              .map(
                (e) => NotificationModel.fromJson(
                  e['data'] as Map<String, dynamic>,
                  e['id'] as String,
                ).toEntity(),
              )
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

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
