import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';
import 'package:fruits_app/features/checkout/domain/entities/paypal_entity/paypal_payment_entity/paypal_payment_entity.dart';
import 'package:fruits_app/features/checkout/presentation/manager/cubit/add_order_cubit/add_order_cubit.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/address_step.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/review_step.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/shipping_method_step.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/widgets/custom_main_app_bar.dart';
import '../../manager/controllers/checkout_controller.dart';
import 'checkout_steps_indicator.dart';
import 'checkout_steps_page_view.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});
  static const _stepLabels = ['الشحن', 'العنوان', 'المراجعه'];
  static const _buttonLabels = ['التالي', 'التالي', 'الدفع عبر Paypal'];
  static const int _lastStepIndex = 2;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckoutController>();
    final isLastStep = controller.currentStepIndex == _lastStepIndex;
    return SafeArea(
      child: Column(
        children: [
          const CustomMainAppBar(title: 'الشحن', isShowNotification: false),
          const SizedBox(height: 20),
          const CheckoutStepIndicator(steps: _stepLabels),
          const SizedBox(height: 20),
          Expanded(
            child: CheckoutStepsPageView(
              pageController: controller.pageController,
              stepPages: _buildStepPages(controller),
              stepLabels: _stepLabels,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: kTopPadding,
            ),
            child: AppPrimaryButton(
              text: _buttonLabels[controller.currentStepIndex],
              onPressed: () => isLastStep
                  ? _processPayment(context)
                  : controller.validateAndGoNext(context),
            ),
          ),
        ],
      ),
    );
  }

  void _processPayment(BuildContext context) {
    OrderInputEntity orderEntity = context.read<OrderInputEntity>();
    var order = context.read<AddOrderCubit>();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckoutView(
          sandboxMode: true,
          clientId: dotenv.env['PAYPAL_CLIENT_ID'],
          secretKey: dotenv.env['PAYPAL_SECRET_KEY'],
          transactions: [PaypalPaymentEntity.fromEntity(orderEntity)],
          note: 'Contact us for any questions on your order.',
          onSuccess: (Map params) async {
            log('onSuccess: $params');
            order.placeOrder(orderEntity: orderEntity);
          },
          onError: (error) {
            log('onError: $error');
            Navigator.pop(context);
          },
          onCancel: () {
            log('cancelled:');
          },
        ),
      ),
    );
  }

  List<Widget> _buildStepPages(CheckoutController c) => [
    const ShippingMethodStep(),
    AddressStep(formKey: c.formKey, valueNotifier: c.autovalidateNotifier),
    const ReviewStep(),
  ];
}
