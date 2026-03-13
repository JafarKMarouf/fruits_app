import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubits/featured_products/featured_product_cubit.dart';
import 'package:fruits_app/core/cubits/product/product_cubit.dart';
import 'package:fruits_app/features/products/presentation/views/widgets/products_view_body.dart';

import '../../../../core/services/get_it_service.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  static const routeName = 'products-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<FeaturedProductCubit>()),
          BlocProvider(create: (context) => getIt<ProductCubit>()),
          // BlocProvider(create: (context) => getIt<CartCubit>()),
        ],
        child: const ProductsViewBody(),
      ),
    );
  }
}
