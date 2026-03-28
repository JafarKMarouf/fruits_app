import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_text_styles.dart';
import '../../../../../core/widgets/app_text_widget.dart';
import '../../../domain/entities/order_input_entity/order_input_entity.dart';

class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final order = context.read<OrderInputEntity>();
    return Column(
      children: [
        _SummaryRow(
          label: 'المجموع الفرعي :',
          value: '${order.cartEntity.formatTotalPrice} ل.س',
        ),
        const SizedBox(height: 8),
        _SummaryRow(
          label: 'التوصيل :',
          value: order.payWithCash! ? '+40 ل.س' : 'مجاني',
          valueColor: order.payWithCash!
              ? AppColors.grayscale900
              : AppColors.green1_500,
        ),
        const SizedBox(height: 12),
        const Divider(thickness: .5, color: AppColors.grayscale200),
        const SizedBox(height: 12),
        _SummaryRow(
          label: 'الكلي',
          value: '${order.formatFinalTotal} ل.س',
          isTotal: true,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool isTotal;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final style = isTotal
        ? AppTextStyles.styleBold16.copyWith(color: AppColors.grayscale950)
        : AppTextStyles.styleRegular13.copyWith(color: AppColors.grayscale500);

    final valueStyle = isTotal
        ? AppTextStyles.styleBold16.copyWith(color: AppColors.grayscale950)
        : AppTextStyles.styleSemiBold16.copyWith(
            color: valueColor ?? AppColors.grayscale900,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTextWidget(label, style: style),
        AppTextWidget(value, style: valueStyle),
      ],
    );
  }
}
