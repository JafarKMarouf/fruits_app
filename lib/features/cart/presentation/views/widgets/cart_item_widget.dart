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
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_item_action_buttons.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemEntity item;
  final Function(String) onRemove;
  final Function(String, int) onUpdateQuantity;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: const BoxDecoration(color: Color(0xFFF3F5F7)),
            child: CustomNetworkImage(
              imageUrl: item.productEntity.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 17),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  Row(
                    children: [
                      AppTextWidget(
                        item.productEntity.name,
                        style: AppTextStyles.styleBold13.copyWith(
                          color: const Color(0xFF05161B),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.read<CartCubit>().removeItem(
                            item.productEntity.code,
                          );
                        },
                        child: SvgPicture.asset(AppImages.imagesTrash),
                      ),
                    ],
                  ),

                  AppTextWidget(
                    '${item.count} كم',
                    textAlign: TextAlign.right,
                    style: AppTextStyles.styleRegular13.copyWith(
                      color: AppColors.orange500,
                    ),
                  ),
                  Row(
                    children: [
                      CartItemActionButtons(cartItemEntity: item),
                      const Spacer(),
                      AppTextWidget(
                        '${item.calculateTotalPrice()} ل.س',
                        style: AppTextStyles.styleBold16.copyWith(
                          color: AppColors.orange500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
