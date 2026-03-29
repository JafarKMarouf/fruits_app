import 'package:flutter/material.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';
import 'package:fruits_app/features/checkout/presentation/manager/controllers/checkout_controller.dart';

import 'package:provider/provider.dart';

import 'checkout_payment_handler.dart';

class CheckoutActionButton extends StatelessWidget {
  const CheckoutActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckoutController>();
    final isLastStep = controller.isLastStep;

    return AppPrimaryButton(
      text: _resolveLabel(context, controller, isLastStep),
      onPressed: () => isLastStep
          ? CheckoutPaymentHandler.process(context)
          : controller.validateAndGoNext(context),
    );
  }

  String _resolveLabel(
    BuildContext context,
    CheckoutController controller,
    bool isLastStep,
  ) {
    if (!isLastStep) return 'التالي';

    final payWithCash = context.watch<OrderInputEntity>().payWithCash;
    return payWithCash == true ? 'تأكيد الطلب' : 'الدفع عبر PayPal';
  }
}
