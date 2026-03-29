import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

import '../../../../../../core/utils/styles/app_colors.dart';

class TrackingErrorView extends StatelessWidget {
  const TrackingErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.error,
            size: 56,
          ),
          const SizedBox(height: 12),
          AppTextWidget(
            message,
            style: AppTextStyles.styleSemiBold16.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
