import 'package:flutter/material.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_header_bloc_builder.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_item_list_bloc_builder.dart';

import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/widgets/custom_main_app_bar.dart';
import 'checkout_button_bloc_builder.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: kTopPadding),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: kHorizontalPadding,
                      ),
                      child: CustomMainAppBar(
                        title: 'السلة',
                        isShowNotification: false,
                      ),
                    ),
                    SizedBox(height: 16),
                    CartHeaderBlocBuilder(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
              const SliverToBoxAdapter(
                child: Divider(color: AppColors.grayscale200),
              ),
              const CartItemListBlocBuilder(),
              const SliverToBoxAdapter(
                child: Divider(color: AppColors.grayscale200),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: MediaQuery.sizeOf(context).height * .1),
              ),
            ],
          ),

          const Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: CheckoutButtonBlocBuilder(),
          ),
        ],
      ),
    );
  }
}
