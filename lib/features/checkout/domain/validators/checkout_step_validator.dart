import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper/show_messages_bar.dart';
import '../../../../core/utils/constants/app_constants.dart';
import '../entities/order_input_entity.dart';

abstract class CheckoutStepValidator {
  static void handleShippingSectionValidation(
    BuildContext context, {
    required PageController pageController,
    required int currentStepIndex,
  }) {
    if (context.read<OrderInputEntity>().payWithCash != null) {
      pageController.animateToPage(
        currentStepIndex,
        duration: const Duration(milliseconds: kAnimatedDuration),
        curve: kCurves,
      );
    } else {
      showErrorBar(context, 'يرجى تحديد طريقة الدفع');
    }
  }

  static void handleAddressSectionValidation(
    BuildContext context, {
    required PageController pageController,
    required GlobalKey<FormState> formKey,
    required ValueNotifier<AutovalidateMode> valueNotifier,
    required int currentStepIndex,
  }) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      pageController.animateToPage(
        currentStepIndex,
        duration: const Duration(milliseconds: kAnimatedDuration),
        curve: kCurves,
      );
    } else {
      valueNotifier.value = AutovalidateMode.always;
    }
  }
}
