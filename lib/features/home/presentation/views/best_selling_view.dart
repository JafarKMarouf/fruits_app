import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/best_selling_view_body.dart';

import '../../../../core/cubits/product/product_cubit.dart';
import '../../../../core/services/get_it_service.dart';

class BestSellingView extends StatelessWidget {
  const BestSellingView({super.key});

  static const routeName = 'best-selling-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ProductCubit>(),
        child: const BestSellingViewBody(),
      ),
    );
  }
}
