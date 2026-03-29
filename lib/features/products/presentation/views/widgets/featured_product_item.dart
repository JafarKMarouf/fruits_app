import 'package:flutter/material.dart';
import 'package:fruits_app/core/entities/product_entity.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/core/widgets/custom_network_image.dart';

class FeaturedProductItem extends StatelessWidget {
  final ProductEntity product;

  const FeaturedProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 34.5,
          backgroundColor: const Color(0xFFF3F5F7),
          child: CustomNetworkImage(
            imageUrl: product.imageUrl,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        AppTextWidget(
          product.name,
          style: AppTextStyles.styleSemiBold13.copyWith(
            color: AppColors.grayscale950,
          ),
        ),
      ],
    );
  }
}
