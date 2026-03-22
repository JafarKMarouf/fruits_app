import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/widgets/app_text_widget.dart';

class OrderSummaryWidget extends StatelessWidget {
  const OrderSummaryWidget({super.key});
  static const _summaryRows = [
    (label: 'المجموع الفرعي :', value: '150 جنيه', isTotal: false),
    (label: 'التوصيل :', value: '30 جنية', isTotal: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._summaryRows.map(
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SummaryRow(label: row.label, value: row.value),
          ),
        ),
        const SizedBox(height: 12),
        const Divider(thickness: .5, color: AppColors.grayscale200),
        const SizedBox(height: 12),

        const _SummaryRow(label: 'الكلي', value: '180 جنيه', isTotal: true),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  TextStyle get _style => isTotal
      ? AppTextStyles.styleBold16.copyWith(color: AppColors.grayscale950)
      : AppTextStyles.styleRegular13.copyWith(color: AppColors.grayscale500);

  TextStyle get _valueStyle => isTotal
      ? AppTextStyles.styleBold16.copyWith(color: AppColors.grayscale950)
      : AppTextStyles.styleSemiBold16.copyWith(color: AppColors.grayscale900);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(label, style: _style),
        AppTextWidget(value, style: _valueStyle),
      ],
    );
  }
}
