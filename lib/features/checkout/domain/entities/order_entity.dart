// import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
// import 'package:fruits_app/features/checkout/domain/entities/shipping_address_entity.dart';

// class OrderEntity {
//   final CartEntity cartEntity;
//   bool? payWithCash;
//   ShippingAddressEntity? shippingAddress = ShippingAddressEntity();

//   OrderEntity(this.cartEntity, {this.payWithCash});

//   static const num _cashTax = 40;

//   num get shippingFee => payWithCash! ? _cashTax : 0;

//   num get finalTotal => cartEntity.totalPrice + shippingFee;

//   String get formatFinalTotal {
//     final total = finalTotal;
//     return total % 1 == 0 ? total.toInt().toString() : total.toString();
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_app/features/checkout/domain/entities/shipping_address_entity.dart';

class OrderEntity extends ChangeNotifier {
  OrderEntity(this.cartEntity);

  final CartEntity cartEntity;

  // ── Payment ──────────────────────────────────────────────
  bool? _payWithCash;
  bool? get payWithCash => _payWithCash;
  set payWithCash(bool? value) {
    if (_payWithCash == value) return;
    _payWithCash = value;
    notifyListeners();
  }

  // ── Shipping Address ─────────────────────────────────────
  ShippingAddressEntity? _shippingAddress = ShippingAddressEntity();
  ShippingAddressEntity? get shippingAddress => _shippingAddress;
  set shippingAddress(ShippingAddressEntity? value) {
    if (_shippingAddress == value) return;
    _shippingAddress = value;
    notifyListeners();
  }

  // ── Calculations ─────────────────────────────────────────
  static const num _cashTax = 40;

  /// Returns 0 if payment method not selected yet (no crash)
  num get shippingFee => _payWithCash == true ? _cashTax : 0;

  num get finalTotal => cartEntity.totalPrice + shippingFee;

  String get formatFinalTotal {
    final total = finalTotal;
    return total % 1 == 0 ? total.toInt().toString() : total.toString();
  }
}
