import 'package:flutter/material.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/address_step.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/review_step.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/shipping_method_step.dart';

import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/widgets/custom_main_app_bar.dart';
import 'checkout_steps_indicator.dart';
import 'checkout_steps_page_view.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;
  int _currentStepIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        _currentStepIndex = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final List<String> _stepLabels = ['الشحن', 'العنوان', 'المراجعه'];
  final List<String> _buttonLabels = ['التالي', 'التالي', 'تأكيد الطلب'];
  final List<Widget> _stepPages = [
    const ShippingMethodStep(),
    const AddressStep(),
    const ReviewStep(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomMainAppBar(title: 'الشحن', isShowNotification: false),
          const SizedBox(height: 20),

          CheckoutStepIndicator(
            currentStep: _currentStepIndex,
            steps: _stepLabels,
            pageController: pageController,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CheckoutStepsPageView(
              pageController: pageController,
              stepLabels: _stepLabels,
              stepPages: _stepPages,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: AppPrimaryButton(
              text: _buttonLabels[_currentStepIndex],
              onPressed: () {
                pageController.animateToPage(
                  _currentStepIndex + 1,
                  duration: const Duration(milliseconds: kAnimatedDuration),
                  curve: kCurves,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
