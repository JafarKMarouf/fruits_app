import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/order_tracking_entity/order_status.dart';
import 'tracking_step_icon.dart';

class TrackingTimelineItem extends StatelessWidget {
  const TrackingTimelineItem({
    super.key,
    required this.step,
    required this.isDone,
    required this.isActive,
    required this.isLast,
    this.date,
  });

  final OrderStatus step;
  final bool isDone;
  final bool isActive;
  final bool isLast;
  final DateTime? date;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIndicatorColumn(),
          const SizedBox(width: 16),
          Expanded(child: _buildLabelRow()),
        ],
      ),
    );
  }

  // ── Left column: icon + connector ─────────────────────────────────────────

  Widget _buildIndicatorColumn() {
    return Column(
      children: [
        TrackingStepIcon(isDone: isDone, isActive: isActive),
        if (!isLast)
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 2,
              color: isDone ? AppColors.green1_500 : AppColors.border,
            ),
          ),
      ],
    );
  }

  // ── Right column: label + description + date ───────────────────────────────

  Widget _buildLabelRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildTexts(), if (isDone && date != null) _buildDate()],
      ),
    );
  }

  Widget _buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppTextWidget(
          step.label,
          style: AppTextStyles.styleBold16.copyWith(
            color: isDone ? AppColors.textPrimary : AppColors.textDisabled,
          ),
        ),
        if (isActive) ...[
          const SizedBox(height: 2),
          AppTextWidget(
            step.description,
            style: AppTextStyles.styleRegular13.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDate() {
    final formatted = DateFormat('d MMMM، yyyy', 'ar').format(date!);
    return AppTextWidget(
      formatted,
      style: AppTextStyles.styleRegular13.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }
}
