import 'package:flutter/material.dart';

import 'widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  static const routeName = 'cart-view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CartViewBody());
  }
}
