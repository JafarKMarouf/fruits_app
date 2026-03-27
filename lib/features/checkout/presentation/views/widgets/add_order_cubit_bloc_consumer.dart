import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/show_messages_bar.dart';
import 'package:fruits_app/core/widgets/bottom_nav_bar/app_shell.dart';
import 'package:fruits_app/core/widgets/custom_progress_hud.dart';
import 'package:fruits_app/features/checkout/presentation/manager/cubit/add_order_cubit/add_order_cubit.dart';

import '../../../../../core/helper/get_user.dart';
import '../../../../cart/presentation/cubit/cart_cubit/cart_cubit.dart'
    show CartCubit;

class AddOrderCubitBlocConsumer extends StatelessWidget {
  const AddOrderCubitBlocConsumer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit, AddOrderState>(
      listener: (context, state) {
        if (state is AddOrderFailure) {
          showErrorBar(context, state.errMessage);
        }
        if (state is AddOrderSuccess) {
          Navigator.pushReplacementNamed(context, AppShell.routeName);
          context.read<CartCubit>().clearCart(getUser().uId);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is AddOrderLoading,
          child: child,
        );
      },
    );
  }
}
