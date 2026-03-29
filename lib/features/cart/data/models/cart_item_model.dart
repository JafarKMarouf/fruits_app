import 'package:hive_ce/hive.dart';

import '../../../../core/models/product_model.dart';
import '../../domain/entities/cart_item_entity.dart';
part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel {
  @HiveField(0)
  final ProductModel productModel;

  @HiveField(1)
  int quantity;

  CartItemModel({required this.productModel, required this.quantity});

  // ── Entity Mapping ─────────────────────────────

  CartItemEntity toEntity() {
    return CartItemEntity(
      productEntity: productModel.toEntity(),
      quantity: quantity,
    );
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productModel: ProductModel.fromEntity(entity.productEntity),
      quantity: entity.quantity,
    );
  }

  // ── JSON Mapping ───────────────────────────────

  Map<String, dynamic> toJson() {
    return {'product': productModel.toJson(), 'quantity': quantity};
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productModel: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
