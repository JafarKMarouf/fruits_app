import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

void buildErrorBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.textSecondary,
      content: AppTextWidget(
        text: message,
        style: AppTextStyles.styleSemiBold13.copyWith(color: AppColors.error),
      ),
    ),
  );
}

void buildSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.success,
      content: AppTextWidget(
        text: message,
        style: AppTextStyles.styleSemiBold13.copyWith(
          color: AppColors.textPrimary,
        ),
      ),
    ),
  );
}
