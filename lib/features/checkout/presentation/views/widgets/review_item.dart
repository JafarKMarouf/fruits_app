import 'package:flutter/material.dart';
import 'package:fruits_app/core/widgets/app_decoration.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/widgets/app_text_widget.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        AppTextWidget(
          title,
          style: AppTextStyles.styleBold13.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: AppDecoration.grayDecoration,
          child: child,
        ),
      ],
    );
  }
}
