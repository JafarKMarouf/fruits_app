import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/controllers/checkout_controller.dart';
import 'step_item.dart';

class CheckoutStepIndicator extends StatelessWidget {
  const CheckoutStepIndicator({super.key, required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CheckoutController>();

    return Row(
      children: List.generate(steps.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _onStepTapped(context, controller, index),
            child: StepItem(
              index: index,
              isActive: index <= controller.currentStepIndex,
              stepLabel: steps[index],
            ),
          ),
        );
      }),
    );
  }

  void _onStepTapped(
    BuildContext context,
    CheckoutController controller,
    int tappedIndex,
  ) {
    if (tappedIndex == controller.currentStepIndex) return;

    if (tappedIndex < controller.currentStepIndex) {
      controller.goBack(tappedIndex);
    } else {
      controller.validateAndGoNext(context);
    }
  }
}
