import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
import 'package:hive_ce/hive.dart';

import 'cart_item_model.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 2)
class CartModel {
  @HiveField(0)
  final List<CartItemModel> cartItems;

  @HiveField(1)
  final num totalPrice;

  const CartModel({required this.cartItems, required this.totalPrice});

  // ── Entity Mapping ─────────────────────────────

  CartEntity toEntity() {
    return CartEntity(
      cartItems: cartItems.map((cartItem) => cartItem.toEntity()).toList(),
      totalPrice: totalPrice,
    );
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      cartItems: entity.cartItems
          .map((cartItem) => CartItemModel.fromEntity(cartItem))
          .toList(),
      totalPrice: entity.totalPrice,
    );
  }

  // ── JSON Mapping ───────────────────────────────

  Map<String, dynamic> toJson() {
    return {
      'cart_items': cartItems.map((cartItem) => cartItem.toJson()).toList(),
      'total_price': totalPrice,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartItems: (json['cart_items'] as List<dynamic>)
          .map((e) => CartItemModel.fromJson(json))
          .toList(),
      totalPrice: json['total_price'],
    );
  }
}
