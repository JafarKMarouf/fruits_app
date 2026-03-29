part of 'add_order_cubit.dart';

sealed class AddOrderState {
  const AddOrderState();
}

final class AddOrderInitial extends AddOrderState {}

final class AddOrderLoading extends AddOrderState {}

final class AddOrderFailure extends AddOrderState {
  final String errMessage;
  const AddOrderFailure(this.errMessage);
}

final class AddOrderSuccess extends AddOrderState {
  final String orderId;
  const AddOrderSuccess(this.orderId);
}
