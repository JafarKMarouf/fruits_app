import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fruits_app/core/helper/show_messages_bar.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';
import 'package:fruits_app/features/checkout/presentation/manager/cubit/add_order_cubit/add_order_cubit.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/paypal_entity/paypal_payment_entity/paypal_payment_entity.dart';

class CheckoutPaymentHandler {
  const CheckoutPaymentHandler._();

  static void process(BuildContext context) {
    final orderEntity = context.read<OrderInputEntity>();
    final payWithCash = orderEntity.payWithCash ?? true;

    if (payWithCash) {
      _placeCashOrder(context, orderEntity);
    } else {
      _openPayPal(context, orderEntity);
    }
  }

  static void _placeCashOrder(
    BuildContext context,
    OrderInputEntity orderEntity,
  ) {
    context.read<AddOrderCubit>().placeOrder(orderEntity: orderEntity);
  }

  static void _openPayPal(BuildContext context, OrderInputEntity orderEntity) {
    final orderCubit = context.read<AddOrderCubit>();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: dotenv.env['PAYPAL_CLIENT_ID'],
          secretKey: dotenv.env['PAYPAL_SECRET_KEY'],
          transactions: [PaypalPaymentEntity.fromEntity(orderEntity)],
          note: 'Contact us for any questions on your order.',
          onSuccess: (Map params) async {
            log('PayPal onSuccess: $params');
            Navigator.pop(context);
            orderCubit.placeOrder(orderEntity: orderEntity);
          },
          onError: (error) {
            log('PayPal onError: $error');
            Navigator.pop(context);
            showErrorBar(context, '$error');
          },
          onCancel: () {
            log('PayPal cancelled');
            showErrorBar(context, 'تم إلغاء عملية الدفع');
          },
        ),
      ),
    );
  }
}
