import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class BestSellingHeader extends StatelessWidget {
  const BestSellingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(
          text: 'الأكثر مبيعاً',
          style: AppTextStyles.styleBold16.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
        AppTextWidget(
          text: 'المزيد',
          style: AppTextStyles.styleRegular13.copyWith(
            color: AppColors.grayscale400,
          ),
        ),
      ],
    );
  }
}
