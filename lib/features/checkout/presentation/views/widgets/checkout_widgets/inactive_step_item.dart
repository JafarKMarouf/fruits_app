import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../../core/widgets/app_text_widget.dart';

class InactiveStepItem extends StatelessWidget {
  const InactiveStepItem({
    super.key,
    required this.title,
    required this.stepNumber,
  });
  final String title;
  final int stepNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        CircleAvatar(
          radius: 11.5,
          backgroundColor: AppColors.grayscale50,
          child: AppTextWidget(
            '$stepNumber',
            style: AppTextStyles.styleBold13.copyWith(
              color: AppColors.grayscale950,
            ),
          ),
        ),
        const SizedBox(width: 4),
        AppTextWidget(
          title,
          style: AppTextStyles.styleBold13.copyWith(
            color: const Color(0xFFAAAAAA),
          ),
        ),
      ],
    );
  }
}
