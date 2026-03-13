import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';

class CartEntity {
  final List<CartItemEntity> cartItems;
  final num totalPrice;

  const CartEntity({required this.cartItems, required this.totalPrice});
}
