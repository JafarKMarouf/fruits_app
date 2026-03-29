import 'package:flutter/material.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/checkout_widgets/address_step.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/checkout_widgets/review_step.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/checkout_widgets/shipping_method_step.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utils/constants/app_constants.dart';
import '../../../../../../core/widgets/custom_main_app_bar.dart';
import '../../../manager/controllers/checkout_controller.dart';
import 'checkout_action_button.dart';
import 'checkout_steps_indicator.dart';
import 'checkout_steps_page_view.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  static const _stepLabels = ['الشحن', 'العنوان', 'المراجعه'];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckoutController>();

    return SafeArea(
      child: Column(
        children: [
          const CustomMainAppBar(
            title: 'إتمام الطلب',
            isShowNotification: false,
          ),
          const SizedBox(height: 20),
          const CheckoutStepIndicator(steps: _stepLabels),
          const SizedBox(height: 20),
          Expanded(
            child: CheckoutStepsPageView(
              pageController: controller.pageController,
              stepLabels: _stepLabels,
              stepPages: _buildStepPages(controller),
            ),
          ),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: CheckoutActionButton(),
    );
  }

  List<Widget> _buildStepPages(CheckoutController c) => [
    const ShippingMethodStep(),
    AddressStep(formKey: c.formKey, valueNotifier: c.autovalidateNotifier),
    const ReviewStep(),
  ];
}
