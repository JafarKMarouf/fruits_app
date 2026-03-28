import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';

import 'item_entity.dart';

class ItemListEntity {
  List<ItemEntity>? items;

  ItemListEntity({this.items});

  factory ItemListEntity.fromEntity(OrderInputEntity orderEntity) {
    return ItemListEntity(
      items: orderEntity.cartEntity.cartItems
          .map((e) => ItemEntity.fromEntity(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'items': items?.map((e) => e.toJson()).toList(),
  };
}
