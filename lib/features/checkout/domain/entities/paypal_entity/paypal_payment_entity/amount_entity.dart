import 'package:fruits_app/core/helper/get_currency.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';

import 'details_entity.dart';

class AmountEntity {
  String? total;
  String? currency;
  DetailsEntity? details;

  AmountEntity({this.total, this.currency, this.details});

  factory AmountEntity.fromEntity(OrderInputEntity orderEntity) {
    return AmountEntity(
      total: orderEntity.formatFinalTotal,
      currency: getCurrency(),
      details: DetailsEntity.fromEntity(orderEntity),
    );
  }

  Map<String, dynamic> toJson() => {
    'total': total,
    'currency': currency,
    'details': details?.toJson(),
  };
}
