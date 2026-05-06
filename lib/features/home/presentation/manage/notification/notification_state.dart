part of 'notification_cubit.dart';

sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

final class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;

  const NotificationLoaded(this.notifications);

  List<NotificationEntity> get unreadNotifications =>
      notifications.where((n) => !n.isRead).toList();

  List<NotificationEntity> get readNotifications =>
      notifications.where((n) => n.isRead).toList();

  int get unreadCount => unreadNotifications.length;

  bool get hasUnread => unreadCount > 0;

  // ── Immutable update helper ───────────────────────────────────────────────
  NotificationLoaded copyWith({List<NotificationEntity>? notifications}) {
    return NotificationLoaded(notifications ?? this.notifications);
  }
}

class NotificationFailure extends NotificationState {
  final String message;

  const NotificationFailure(this.message);
}
