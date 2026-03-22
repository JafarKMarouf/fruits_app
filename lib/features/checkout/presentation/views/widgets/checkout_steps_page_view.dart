import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';

class CheckoutStepsPageView extends StatelessWidget {
  const CheckoutStepsPageView({
    super.key,
    required this.pageController,
    required this.stepLabels,
    required this.stepPages,
  });

  final PageController pageController;
  final List<String> stepLabels;
  final List<Widget> stepPages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
        horizontal: kHorizontalPadding,
      ),
      child: PageView.builder(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: stepLabels.length,
        itemBuilder: (context, index) {
          return stepPages[index];
        },
      ),
    );
  }
}
