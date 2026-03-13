import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/no_result_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/helper/get_mock_cart.dart';
import '../../../../../core/widgets/custom_error_widget.dart';
import 'cart_item_sliver_list_builder.dart';

class CartItemListBlocBuilder extends StatelessWidget {
  const CartItemListBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          if (state.cart.cartItems.isEmpty) {
            return const SliverToBoxAdapter(child: NoResultBody());
          }
          return CartItemSliverListBuilder(cartItems: state.cart.cartItems);
        } else if (state is CartFailure) {
          return SliverToBoxAdapter(
            child: CustomErrorWidget(
              errorMessage: state.message,
              onRetry: () {
                context.read<CartCubit>().loadCart();
              },
            ),
          );
        } else {
          return Skeletonizer.sliver(
            enabled: true,
            child: CartItemSliverListBuilder(cartItems: getMockCartItems()),
          );
        }
      },
    );
  }
}
