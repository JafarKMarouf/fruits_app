import 'order_status.dart';

class OrderTrackingEntity {
  final String orderId;
  final num totalPrice;
  final num shippingFee;
  final int itemCount;
  final String payMethod;
  final OrderStatus status;
  final String deliveryAddress;
  final DateTime? createdAt;

  const OrderTrackingEntity({
    required this.orderId,
    required this.totalPrice,
    required this.shippingFee,
    required this.itemCount,
    required this.payMethod,
    required this.status,
    required this.deliveryAddress,
    this.createdAt,
  });

  num get finalTotal => totalPrice + shippingFee;

  String get shortOrderId =>
      orderId.length > 10 ? orderId.substring(0, 10) : orderId;
}
