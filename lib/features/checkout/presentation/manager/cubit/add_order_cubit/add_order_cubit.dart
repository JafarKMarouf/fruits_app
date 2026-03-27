import 'package:bloc/bloc.dart';
import 'package:fruits_app/core/repositories/order_repo/order_repo.dart';
import 'package:fruits_app/features/checkout/domain/entities/order_input_entity.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  final OrderRepo orderRepo;
  AddOrderCubit(this.orderRepo) : super(AddOrderInitial());

  Future<void> placeOrder({required OrderInputEntity orderEntity}) async {
    emit(AddOrderLoading());
    var result = await orderRepo.addOrder(orderEntity: orderEntity);
    result.fold(
      (fail) {
        emit(AddOrderFailure(fail.message));
      },
      (success) {
        emit(AddOrderSuccess());
      },
    );
  }
}
