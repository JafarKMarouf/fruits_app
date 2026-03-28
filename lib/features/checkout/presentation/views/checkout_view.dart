import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/helper/get_user.dart';
import 'package:fruits_app/features/cart/domain/entities/cart_entity.dart';
import 'package:fruits_app/features/cart/presentation/cubit/cart_cubit/cart_cubit.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity/order_input_entity.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/add_order_cubit_bloc_consumer.dart';
import 'package:fruits_app/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/get_it_service.dart';
import '../manager/controllers/checkout_controller.dart';
import '../manager/cubit/add_order_cubit/add_order_cubit.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key, required this.cartEntity});

  static const routeName = 'checkout';
  final CartEntity cartEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => OrderInputEntity(getUser().uId, cartEntity),
          ),
          ChangeNotifierProvider(create: (_) => CheckoutController()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AddOrderCubit>()),
            BlocProvider(create: (context) => getIt<CartCubit>()),
          ],
          child: const AddOrderCubitBlocConsumer(child: CheckoutViewBody()),
        ),
      ),
    );
  }
}
