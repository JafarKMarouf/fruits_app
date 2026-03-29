import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';

import 'amount_entity.dart';
import 'item_list_entity.dart';

class PaypalPaymentEntity {
  AmountEntity? amount;
  String? description;
  ItemListEntity? itemList;

  PaypalPaymentEntity({this.amount, this.description, this.itemList});

  factory PaypalPaymentEntity.fromEntity(OrderInputEntity orderEntity) {
    return PaypalPaymentEntity(
      amount: AmountEntity.fromEntity(orderEntity),
      itemList: ItemListEntity.fromEntity(orderEntity),
      description: 'Payment Description',
    );
  }

  Map<String, dynamic> toJson() => {
    'amount': amount?.toJson(),
    'description': description,
    'item_list': itemList?.toJson(),
  };
}
