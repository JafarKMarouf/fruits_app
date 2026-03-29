part of 'order_tracking_cubit.dart';

sealed class OrderTrackingState {}

final class OrderTrackingInitial extends OrderTrackingState {}

final class OrderTrackingLoading extends OrderTrackingState {}

final class OrderTrackingFailure extends OrderTrackingState {
  final String errMessage;
  OrderTrackingFailure(this.errMessage);
}

final class OrderTrackingLoaded extends OrderTrackingState {
  final OrderTrackingEntity orderTrackingEntity;
  OrderTrackingLoaded(this.orderTrackingEntity);
}
