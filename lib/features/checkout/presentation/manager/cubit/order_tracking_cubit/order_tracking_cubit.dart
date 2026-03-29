import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_tracking_entity/order_tracking_entity.dart';

import '../../../../domain/repos/order_tracking_repo.dart';

part 'order_tracking_state.dart';

class OrderTrackingCubit extends Cubit<OrderTrackingState> {
  OrderTrackingCubit(this.repo) : super(OrderTrackingInitial());

  final OrderTrackingRepo repo;
  StreamSubscription? _subscription;

  void watchOrder(String orderId) {
    emit(OrderTrackingLoading());
    _subscription?.cancel();

    _subscription = repo
        .watchOrder(orderId)
        .listen(
          (result) => result.fold(
            (failure) => emit(OrderTrackingFailure(failure.message)),
            (order) => emit(OrderTrackingLoaded(order)),
          ),
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
