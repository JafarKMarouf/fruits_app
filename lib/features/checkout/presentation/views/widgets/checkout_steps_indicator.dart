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
      controller.goBack();
    } else {
      controller.validateAndGoNext(context);
    }
  }
}

// class CheckoutStepIndicator extends StatelessWidget {
//   const CheckoutStepIndicator({
//     super.key,
//     required this.currentStep,
//     required this.steps,
//     required this.pageController,
//     required this.valueNotifier,
//     required this.formKey,
//   });

//   final int currentStep;
//   final List<String> steps;
//   final PageController pageController;
//   final ValueNotifier<AutovalidateMode> valueNotifier;
//   final GlobalKey<FormState> formKey;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: .center,
//       children: List.generate(steps.length, (index) {
//         return Expanded(
//           child: GestureDetector(
//             onTap: () {
//               if (index == 0) {
//                 CheckoutStepValidator.handleShippingSectionValidation(
//                   context,
//                   pageController: pageController,
//                   currentStepIndex: index,
//                 );
//               } else if (index == 1) {
//                 CheckoutStepValidator.handleAddressSectionValidation(
//                   context,
//                   pageController: pageController,
//                   formKey: formKey,
//                   currentStepIndex: index,
//                   valueNotifier: valueNotifier,
//                 );
//               }
//             },
//             child: StepItem(
//               index: index,
//               isActive: index <= currentStep,
//               stepLabel: steps[index],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
