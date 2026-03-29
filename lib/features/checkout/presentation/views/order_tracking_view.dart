import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../manager/cubit/order_tracking_cubit/order_tracking_cubit.dart';
import 'widgets/order_tracking_widgets/order_tracking_view_body.dart';

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key, required this.orderId});

  static const routeName = 'order_tracking';
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt<OrderTrackingCubit>()..watchOrder(orderId),
        child: const OrderTrackingViewBody(),
      ),
    );
  }
}
