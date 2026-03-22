import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/cart/presentation/views/widgets/cart_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartHeaderBlocBuilder extends StatelessWidget {
  const CartHeaderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return CartHeader(count: state.cart.cartItems.length);
        } else if (state is CartEmpty) {
          return const CartHeader(count: 0);
        } else {
          return const Skeletonizer(enabled: true, child: CartHeader(count: 1));
        }
      },
    );
  }
}
