part of 'notification_cubit.dart';

sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  NotificationLoaded(this.notifications);
}

class NotificationFailure extends NotificationState {
  final String message;
  NotificationFailure(this.message);
}
