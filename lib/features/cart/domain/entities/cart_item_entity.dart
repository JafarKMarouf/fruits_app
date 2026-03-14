import 'package:fruits_app/core/entities/product_entity.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  int count;

  CartItemEntity({required this.productEntity, required this.count});

  String get formatTotalItemPrice {
    num total = count * productEntity.price;
    if (total % 1 == 0) {
      return total.toInt().toString();
    }
    return total.toString();
  }
}
