import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits_app/features/cart/data/models/cart_model.dart';
import 'package:fruits_app/features/checkout/data/models/order_model/shipping_address_model.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';

class OrderInputModel {
  final String uId;
  final CartModel cartModel;
  final String payMethod;
  final ShippingAddressModel shippingAddressModel;
  final num finalTotal;
  final String status;
  final DateTime? createdAt;

  OrderInputModel({
    required this.uId,
    required this.cartModel,
    required this.payMethod,
    required this.shippingAddressModel,
    required this.finalTotal,
    this.status = 'pendding',
    this.createdAt,
  });

  factory OrderInputModel.fromEntity(OrderInputEntity entity) {
    return OrderInputModel(
      uId: entity.uId,
      cartModel: CartModel.fromEntity(entity.cartEntity),
      payMethod: entity.payWithCash == true ? 'Cash' : 'Online',
      shippingAddressModel: ShippingAddressModel.fromEntity(
        entity.shippingAddress!,
      ),
      finalTotal: entity.finalTotal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': uId,
      'items': cartModel.cartItems
          .map(
            (item) => {
              'product_code': item.productModel.code,
              'product_name': item.productModel.name,
              'price_at_purchase': item.productModel.price,
              'image_url': item.productModel.imageUrl,
              'count': item.quantity,
            },
          )
          .toList(),
      'pay_method': payMethod,
      'shipping_address': shippingAddressModel.toJson(),
      'status': status,
      'total_price': cartModel.totalPrice,
      'final_total': finalTotal,
      'created_at': FieldValue.serverTimestamp(),
    };
  }
}
