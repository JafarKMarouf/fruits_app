import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/notification_entity.dart';
import '../../../domain/repo/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepo _notificationRepo;

  NotificationCubit(this._notificationRepo)
    : super(const NotificationInitial());

  Future<void> getNotifications() async {
    emit(const NotificationLoading());
    final result = await _notificationRepo.getNotifications();
    result.fold(
      (failure) => emit(NotificationFailure(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  Future<void> markAsRead(String id) async {
    final current = state;
    if (current is! NotificationLoaded) return;

    final updatedList = current.notifications.map((n) {
      return n.id == id ? n.copyWith(isRead: true) : n;
    }).toList();
    emit(current.copyWith(notifications: updatedList));

    final result = await _notificationRepo.markAsRead(notificationId: id);
    result.fold((failure) {
      emit(current);
    }, (_) {});
  }

  Future<void> markAllAsRead() async {
    final current = state;
    if (current is! NotificationLoaded) return;
    if (!current.hasUnread) return; // nothing to do

    final updatedList = current.notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    emit(current.copyWith(notifications: updatedList));

    final result = await _notificationRepo.markAllAsRead();
    result.fold((failure) => emit(current), (_) {});
  }

  int get unreadCount {
    final current = state;
    return current is NotificationLoaded ? current.unreadCount : 0;
  }
}
