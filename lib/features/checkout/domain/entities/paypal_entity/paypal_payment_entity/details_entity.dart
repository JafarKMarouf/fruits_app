import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';

class DetailsEntity {
  String? subtotal;
  String? shipping;
  int? shippingDiscount;

  DetailsEntity({this.subtotal, this.shipping, this.shippingDiscount});

  factory DetailsEntity.fromEntity(OrderInputEntity orderEntity) {
    return DetailsEntity(
      subtotal: orderEntity.cartEntity.totalPrice.toString(),
      shipping: orderEntity.calShippingFee(),
      shippingDiscount: orderEntity.calShippingDiscount(),
    );
  }

  Map<String, dynamic> toJson() => {
    'subtotal': subtotal,
    'shipping': shipping,
    'shipping_discount': shippingDiscount,
  };
}
