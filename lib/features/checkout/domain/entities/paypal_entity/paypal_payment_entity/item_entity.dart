import 'package:fruits_app/core/helper/get_currency.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';

class ItemEntity {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  ItemEntity({this.name, this.quantity, this.price, this.currency});

  factory ItemEntity.fromEntity(CartItemEntity cartItemEntity) {
    return ItemEntity(
      name: cartItemEntity.productEntity.name,
      quantity: cartItemEntity.quantity,
      price: cartItemEntity.productEntity.price.toString(),
      currency: getCurrency(),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'price': price,
    'currency': currency,
  };
}
