import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/core/utils/styles/app_images.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/core/widgets/custom_network_image.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/item_action_button.dart';

import '../entities/product_entity.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F5F7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Expanded(
                    child: CustomNetworkImage(imageUrl: product.imageUrl),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppTextWidget(
                              product.name,
                              style: AppTextStyles.styleSemiBold16,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 2),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${product.price} ل.س / ',
                                    style: AppTextStyles.styleBold13.copyWith(
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'كيلو',
                                    style: AppTextStyles.styleBold13.copyWith(
                                      color: AppColors.secondaryLight,
                                    ),
                                  ),
                                ],
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),

                      ItemActionButton(
                        backgroundColor: AppColors.green1_500,
                        iconColor: Colors.white,
                        icon: Icons.add,
                        onTap: () {
                          context.read<CartCubit>().addItem(
                            CartItemEntity(productEntity: product, quantity: 1),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImages.imagesHeart),
            ),
          ),
        ],
      ),
    );
  }
}
