import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/widgets/app_text_widget.dart';
import '../../../domain/entities/shipping_option.dart';

class ShippingItem extends StatelessWidget {
  const ShippingItem({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });
  final ShippingOption option;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: kAnimatedDuration),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: 18,
        ),

        decoration: BoxDecoration(
          color: const Color(0x33D9D9D9),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? AppColors.green1_500 : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.green1_500
                      : AppColors.grayscale300,
                  width: 1,
                ),
              ),
              child: isSelected
                  ? Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.green1_500,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    option.title,
                    style: AppTextStyles.styleSemiBold13.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AppTextWidget(
                    option.subtitle,
                    style: AppTextStyles.styleRegular13.copyWith(
                      color: Colors.black.withValues(alpha: 0.50),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Price badge
            AppTextWidget(
              option.price,
              style: AppTextStyles.styleBold13.copyWith(
                color: AppColors.green1_500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
