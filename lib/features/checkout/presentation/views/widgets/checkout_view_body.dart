import 'package:flutter/material.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
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
  static const _buttonLabels = ['التالي', 'التالي', 'تأكيد الطلب'];

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckoutController>();
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
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: AppPrimaryButton(
              text: _buttonLabels[controller.currentStepIndex],
              onPressed: () => controller.validateAndGoNext(context),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStepPages(CheckoutController c) => [
    const ShippingMethodStep(),
    AddressStep(formKey: c.formKey, valueNotifier: c.autovalidateNotifier),
    const ReviewStep(),
  ];
}
