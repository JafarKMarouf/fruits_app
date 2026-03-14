import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/helper/get_user.dart';
import '../../../../../core/widgets/app_primary_button.dart';
import '../../cubit/cart_cubit/cart_cubit.dart';

class CheckoutButtonBlocBuilder extends StatelessWidget {
  const CheckoutButtonBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          final String price = state.cart.formatTotalPrice;
          return AppPrimaryButton(
            text: 'الدفع $price ل.س',
            onPressed: () {
              context.read<CartCubit>().syncCart(getUser().uId);
            },
          );
        } else if (state is CartEmpty) {
          return const SizedBox.shrink();
        } else {
          return const Skeletonizer(
            enabled: true,
            child: AppPrimaryButton(text: 'الدفع 0000 ل.س', onPressed: null),
          );
        }
      },
    );
  }
}
