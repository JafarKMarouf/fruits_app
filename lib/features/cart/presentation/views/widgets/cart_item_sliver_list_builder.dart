import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/constants/app_constants.dart';
import 'package:fruits_app/core/utils/styles/app_colors.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_item_widget.dart';

class CartItemSliverListBuilder extends StatelessWidget {
  const CartItemSliverListBuilder({super.key, required this.cartItems});
  final List<CartItemEntity> cartItems;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: CartItemWidget(
            item: cartItems[index],
            onRemove: (value) {},
            onUpdateQuantity: (value, index) {},
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(color: AppColors.grayscale300);
      },
    );
  }
}
