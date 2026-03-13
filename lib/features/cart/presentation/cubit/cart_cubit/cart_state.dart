part of 'cart_cubit.dart';

@immutable
sealed class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartEntity cart;
  const CartLoaded(this.cart);

  @override
  List<Object> get props => [cart];
}

class CartFailure extends CartState {
  final String message;
  const CartFailure(this.message);

  @override
  List<Object> get props => [message];
}
