import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

class NotificationSectionHeader extends StatelessWidget {
  const NotificationSectionHeader({
    super.key,
    required this.label,
    required this.count,
    required this.isAllSelected,
    required this.onSelectAll,
  });

  final String label;
  final int count;
  final bool isAllSelected;
  final ValueChanged<bool> onSelectAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            AppTextWidget(text: label, style: AppTextStyles.styleBold16),

            const SizedBox(width: 8),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: AppTextWidget(
                text: '$count',
                style: AppTextStyles.styleBold13.copyWith(
                  color: AppColors.green1_500,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => onSelectAll(!isAllSelected),
          child: AppTextWidget(
            text: 'تحديد الكل مقروء',
            style: AppTextStyles.styleRegular13.copyWith(
              color: AppColors.grayscale400,
            ),
          ),
        ),
      ],
    );
  }
}
