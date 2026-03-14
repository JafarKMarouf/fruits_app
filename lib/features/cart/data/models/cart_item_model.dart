import 'package:hive_ce/hive.dart';

import '../../../../core/models/product_model.dart';
import '../../domain/entities/cart_item_entity.dart';
part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel {
  @HiveField(0)
  final ProductModel productModel;

  @HiveField(1)
  int count;

  CartItemModel({required this.productModel, required this.count});

  // ── Entity Mapping ─────────────────────────────

  CartItemEntity toEntity() {
    return CartItemEntity(productEntity: productModel.toEntity(), count: count);
  }

  factory CartItemModel.fromEntity(CartItemEntity entity) {
    return CartItemModel(
      productModel: ProductModel.fromEntity(entity.productEntity),
      count: entity.count,
    );
  }

  // ── JSON Mapping ───────────────────────────────

  Map<String, dynamic> toJson() {
    return {'product': productModel.toJson(), 'count': count};
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productModel: ProductModel.fromJson(json['product']),
      count: json['count'],
    );
  }
}
