import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_app/core/cubits/product/product_cubit.dart';
import 'package:fruits_app/features/home/presentation/views/widgets/products_grid_view_bloc_builder.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/search_text_field.dart';
import '../best_selling_view.dart';
import '../notification_view.dart';
import '../search_view.dart';
import 'featured_list.dart';
import 'home_app_bar.dart';
import 'show_more_best_selling.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<ProductCubit>().getBestSelling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: kTopPadding),
                  HomeAppBar(
                    onNotificationTapped: () => Navigator.of(
                      context,
                    ).pushNamed(NotificationView.routeName),
                  ),
                  const SizedBox(height: 16),
                  SearchTextField(
                    readOnly: true,
                    onTap: () =>
                        Navigator.of(context).pushNamed(SearchView.routeName),
                  ),
                  const SizedBox(height: 12),
                  const FeaturedList(),
                  const SizedBox(height: 12),
                  ShowMoreBestSelling(
                    onTap: () => Navigator.of(
                      context,
                    ).pushNamed(BestSellingView.routeName),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            const ProductsGridViewBlocBuilder(),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
