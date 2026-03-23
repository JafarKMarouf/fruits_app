import 'package:flutter/material.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_entity.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:provider/provider.dart';

import '../manager/controllers/checkout_controller.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.cartEntity});

  static const routeName = 'checkout';
  final CartEntity cartEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => OrderEntity(cartEntity)),
          ChangeNotifierProvider(create: (_) => CheckoutController()),
        ],
        child: const CheckoutViewBody(),
      ),
    );
  }
}
