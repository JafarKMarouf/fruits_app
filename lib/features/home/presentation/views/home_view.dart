import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubits/product/product_cubit.dart';

import 'package:fruits_app/features/home/presentation/views/widgets/home_view_body.dart';

import '../../../../core/services/get_it_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = 'home-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<ProductCubit>(),
        child: const HomeViewBody(),
      ),
    );
  }
}
