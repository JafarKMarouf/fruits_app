import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/styles/app_colors.dart';
import '../../../manager/cubit/order_tracking_cubit/order_tracking_cubit.dart';
import 'tracking_error_view.dart';
import 'tracking_loaded_body.dart';

class OrderTrackingBlocBuilder extends StatelessWidget {
  const OrderTrackingBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderTrackingCubit, OrderTrackingState>(
      builder: (context, state) => switch (state) {
        OrderTrackingInitial() || OrderTrackingLoading() => const Center(
          child: CircularProgressIndicator(color: AppColors.green1_500),
        ),
        OrderTrackingFailure(:final errMessage) => TrackingErrorView(
          message: errMessage,
        ),
        OrderTrackingLoaded(:final orderTrackingEntity) => TrackingLoadedBody(
          order: orderTrackingEntity,
        ),
      },
    );
  }
}
