
import 'package:flutter/material.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.cartItems});

  static const routeName = 'checkout';
  final List<CartItemEntity> cartItems;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CheckoutViewBody());
  }
}
