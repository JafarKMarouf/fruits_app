import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

import '../../../../domain/entities/order_tracking_entity/order_tracking_entity.dart';

class OrderInfoCard extends StatelessWidget {
  const OrderInfoCard({super.key, required this.order});

  final OrderTrackingEntity order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildIcon(),
          const SizedBox(width: 12),
          Expanded(child: _buildDetails()),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.green1_500.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.inventory_2_outlined,
        color: AppColors.green1_500,
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AppTextWidget(
          'طلب رقم: #${order.shortOrderId}',
          style: AppTextStyles.styleBold16.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          textDirection: TextDirection.rtl,
          children: [
            AppTextWidget(
              'عدد المنتجات: ${order.itemCount}',
              style: AppTextStyles.styleRegular13.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            AppTextWidget(
              '${order.finalTotal} جنيه',
              style: AppTextStyles.styleSemiBold13.copyWith(
                color: AppColors.green1_500,
              ),
            ),
          ],
        ),
        if (order.deliveryAddress.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 14,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              AppTextWidget(
                order.deliveryAddress,
                style: AppTextStyles.styleRegular13.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
