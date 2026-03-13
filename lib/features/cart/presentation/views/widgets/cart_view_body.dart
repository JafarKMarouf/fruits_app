import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/get_user.dart';
import 'package:fruits_app/core/widgets/app_primary_button.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_header_bloc_builder.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_item_list_bloc_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/constants/app_constants.dart';
import '../../../../../core/utils/styles/app_colors.dart';
import '../../../../../core/widgets/custom_main_app_bar.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  void initState() {
    super.initState();
    _initCart();
  }

  Future<void> _initCart() async {
    final cartCubit = context.read<CartCubit>();
    await cartCubit.syncCart(getUser().uId);
    await cartCubit.loadCart();
  }

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

          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  return state.cart.cartItems.isNotEmpty
                      ? AppPrimaryButton(
                          text: 'الدفع ${state.cart.totalPrice} ل.س',
                          onPressed: () {
                            context.read<CartCubit>().syncCart(getUser().uId);
                          },
                        )
                      : const SizedBox.shrink();
                } else {
                  return Skeletonizer(
                    enabled: true,
                    child: AppPrimaryButton(
                      text: 'الدفع  120جنيه',
                      onPressed: () {},
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
