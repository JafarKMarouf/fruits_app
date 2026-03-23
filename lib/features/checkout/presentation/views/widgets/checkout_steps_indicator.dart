
import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';

import 'step_item.dart';

class CheckoutStepIndicator extends StatelessWidget {
  const CheckoutStepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.pageController,
  });

  final int currentStep;
  final List<String> steps;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: List.generate(steps.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: kAnimatedDuration),
                curve: kCurves,
              );
            },
            child: StepItem(
              index: index,
              isActive: index <= currentStep,
              stepLabel: steps[index],
            ),
          ),
        );
      }),
    );
  }
}
