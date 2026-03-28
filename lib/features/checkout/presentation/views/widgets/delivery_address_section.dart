import 'package:fruits_app/core/l10n/l10n.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/utils/styles/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';

import '../../../domain/entities/order_input_entity/order_input_entity.dart';

class DeliveryAddressSection extends StatelessWidget {
  const DeliveryAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final order = context.read<OrderInputEntity>();
    final l10n = AppLocalizations.of(context);
    final address = order.shippingAddress!.formattedAddress(l10n);

    return Column(
      children: [
        _DeliveryAddressHeader(),

        const SizedBox(height: 8),

        _DeliveryAddressRow(formattedAddress: address),
      ],
    );
  }
}

class _DeliveryAddressHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const AppTextWidget('عنوان التوصيل', style: AppTextStyles.styleBold13),
        Row(
          mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class _DeliveryAddressRow extends StatelessWidget {
  const _DeliveryAddressRow({required this.formattedAddress});

  final String formattedAddress;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(AppImages.imagesLocation),
        const SizedBox(width: 6),
        Expanded(
          child: AppTextWidget(
            formattedAddress,
            style: AppTextStyles.styleRegular16.copyWith(
              color: AppColors.grayscale500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
