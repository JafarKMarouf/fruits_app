import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/utils/styles/app_text_styles.dart';
import 'package:fruits_app/core/widgets/app_text_widget.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';

import '../../../../../core/utils/styles/app_colors.dart';
import 'item_action_button.dart';

class CartItemActionButtons extends StatelessWidget {
  const CartItemActionButtons({super.key, required this.cartItemEntity});
  final CartItemEntity cartItemEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        ItemActionButton(
          backgroundColor: AppColors.green1_500,
          iconColor: Colors.white,
          icon: Icons.add,
          onTap: () {
            context.read<CartCubit>().addItem(
              CartItemEntity(
                productEntity: cartItemEntity.productEntity,
                quantity: 1,
              ),
            );
          },
        ),

        AppTextWidget(
          '${cartItemEntity.quantity}',
          textAlign: TextAlign.center,
          style: AppTextStyles.styleBold16.copyWith(
            color: AppColors.green1_950,
          ),
        ),

        ItemActionButton(
          backgroundColor: const Color(0xFFF3F5F7),
          iconColor: const Color(0xFF969899),
          icon: Icons.remove,
          onTap: () {
            context.read<CartCubit>().decreaseCartItemCount(
              cartItemEntity.productEntity.code,
            );
          },
        ),
      ],
    );
  }
}
