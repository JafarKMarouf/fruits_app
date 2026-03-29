import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';

import 'active_step_item.dart';
import 'inactive_step_item.dart';

class StepItem extends StatelessWidget {
  const StepItem({
    super.key,
    required this.stepLabel,
    required this.index,
    required this.isActive,
  });
  final String stepLabel;
  final int index;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: ActiveStepItem(title: stepLabel),
      secondChild: InactiveStepItem(title: stepLabel, stepNumber: index + 1),
      crossFadeState: isActive
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: kAnimatedDuration),
    );
  }
}
