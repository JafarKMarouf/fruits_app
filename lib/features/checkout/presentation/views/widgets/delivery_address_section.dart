import 'package:provider/provider.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

import '../../../domain/entities/order_entity.dart';
import 'review_item.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final address = context.read<OrderEntity>().shippingAddress;

    return ReviewItem(
      title: 'يرجى تأكيد  طلبك : ',
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              const AppTextWidget(
                'عنوان التوصيل',
                style: AppTextStyles.styleBold13,
              ),
              Row(
                children: [
                  SvgPicture.asset(AppImages.imagesEdit),
                  const SizedBox(width: 6),
                  AppTextWidget(
                    'تعديل',
                    style: AppTextStyles.styleSemiBold13.copyWith(
                      color: AppColors.grayscale400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SvgPicture.asset(AppImages.imagesLocation),
              const SizedBox(width: 6),
              AppTextWidget(
                address!.formattedAddress,
                style: AppTextStyles.styleRegular16.copyWith(
                  color: AppColors.grayscale500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
