import 'dart:developer';

import 'package:flutter/material.dart';

import 'step_item.dart';

class CheckoutStepIndicator extends StatelessWidget {
  const CheckoutStepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  final int currentStep;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: List.generate(steps.length, (index) {
        log('index: $index');
        return Expanded(
          child: StepItem(
            index: index,
            isActive: index <= currentStep,
            stepLabel: steps[index],
          ),
        );
      }),
    );
  }
}
