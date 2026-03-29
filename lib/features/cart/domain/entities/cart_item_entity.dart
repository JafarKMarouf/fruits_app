import 'package:fruits_app/core/entities/product_entity.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  int quantity;

  CartItemEntity({required this.productEntity, required this.quantity});

  String get formatTotalItemPrice {
    num total = quantity * productEntity.price;
    if (total % 1 == 0) {
      return total.toInt().toString();
    }
    return total.toString();
  }
}
