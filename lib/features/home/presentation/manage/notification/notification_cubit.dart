import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/notification_entity.dart';
import '../../../domain/repo/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo notificationRepo;

  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    final result = await notificationRepo.getNotifications();
    result.fold(
      (failure) => emit(NotificationFailure(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  Future<void> markAsRead(String id) async {
    await notificationRepo.markAsRead(notificationId: id);
    if (state is NotificationLoaded) {
      final current = (state as NotificationLoaded).notifications;
      final updated = current.map((n) {
        if (n.id == id) {
          return NotificationEntity(
            id: n.id,
            title: n.title,
            body: n.body,
            imageUrl: n.imageUrl,
            productId: n.productId,
            type: n.type,
            createdAt: n.createdAt,
            isRead: true,
          );
        }
        return n;
      }).toList();
      emit(NotificationLoaded(updated));
    }
  }

  Future<void> markAllAsRead() async {
    await notificationRepo.markAllAsRead();
    await getNotifications();
  }

  int get unreadCount {
    if (state is NotificationLoaded) {
      return (state as NotificationLoaded).notifications
          .where((n) => !n.isRead)
          .length;
    }
    return 0;
  }
}
